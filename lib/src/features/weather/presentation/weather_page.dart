import 'dart:io';

import 'package:flutter/cupertino.dart';
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
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: _buildBackground(context),
    );
  }

  Widget _buildBackground(BuildContext context) {
    final imagePath = dayPeriod <= 18
        ? 'assets/images/day_background.jpeg' // Replace with actual asset path
        : 'assets/images/night_background.jpeg'; // Replace with actual asset path
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(imagePath),
          fit: BoxFit.cover,
        ),
      ),
      child: SafeArea(child: _buildContent(context)),
    );
  }

  Widget _buildContent(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: size.width * 0.03,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          _buildBackButton(context),
          SizedBox(height: size.height * 0.03),
          const CitySearchBox(),
          SizedBox(height: size.height * 0.03),
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              itemCount: ref.watch(favoriteCitiesProvider).length,
              itemBuilder: (context, index) => CurrentWeather(),
            ),
          ),
          Text('Swipe to see more', style: textTheme.bodyMedium),
        ],
      ),
    );
  }

  Widget _buildBackButton(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Platform.isAndroid
              ? const Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                  size: 35,
                )
              : const Icon(CupertinoIcons.back, color: Colors.black, size: 35),
        ),
      ],
    );
  }
}
