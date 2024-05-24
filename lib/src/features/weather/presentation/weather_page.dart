import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app_mobile/src/features/weather/application/providers.dart';
import 'package:weather_app_mobile/src/features/weather/presentation/city_search_box.dart';
import 'package:weather_app_mobile/src/features/weather/presentation/current_weather.dart';

class WeatherPage extends ConsumerStatefulWidget {
  const WeatherPage({super.key, required this.city});

  final String city;

  @override
  ConsumerState<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends ConsumerState<WeatherPage> {
  final dayPeriod = DateTime.now().hour;
  List<String>? storedCities = [];

  final PageController _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _loadFavoriteCities();
    super.initState();
    _pageController.addListener(() {
      final index = _pageController.page!.round();
      final cities = ref.watch(favoriteCitiesProvider);
      index < cities.length
          ? ref.read(cityProvider.notifier).state = cities[index]
          : ref.read(cityProvider.notifier).state = cities.last;
    });
  }

  Future<void> _loadFavoriteCities() async {
    final prefs = await SharedPreferences.getInstance();
    final cities = prefs.getStringList('favoriteCities') ??
        ['Melbourne', 'Monte Carlo', 'Sao Paulo', 'Silverstone'];
    ref.read(favoriteCitiesProvider.notifier).state =
        List<String>.unmodifiable(cities);
    storedCities = ref.read(favoriteCitiesProvider.notifier).state;
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              dayPeriod <= 18
                  ? 'assets/images/day_background.jpeg' // Replace with actual asset path
                  : 'assets/images/night_background.jpeg', // Replace with actual asset path
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.05,
            vertical: MediaQuery.of(context).size.height * 0.1,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const CitySearchBox(),
              const SizedBox(height: 50),
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: ref
                      .watch(favoriteCitiesProvider)
                      .length, // Use the actual length of cities
                  itemBuilder: (context, index) => CurrentWeather(),
                ),
              ),
              const SizedBox(height: 50),
              Text(
                'Swipe to see more',
                style: textTheme.bodyMedium,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
