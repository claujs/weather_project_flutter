import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app_mobile/src/features/weather/application/providers.dart';
import 'package:weather_app_mobile/src/features/weather/presentation/city_search_box.dart';
import 'package:weather_app_mobile/src/features/weather/presentation/current_weather.dart';

import '../../../constants/app_colors.dart';

class WeatherPage extends ConsumerStatefulWidget {
  const WeatherPage({super.key, required this.city});
  final String city;

  @override
  ConsumerState<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends ConsumerState<WeatherPage> {
  final PageController _pageController = PageController();
  List<String>? storedCities = [];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  @override
  void initState() {
    super.initState();

    _pageController.addListener(() {
      final index = _pageController.page!.round();
      const cities = ['Melbourne', 'Monte Carlo', 'Sao Paulo', 'Silverstone'];
      final city = cities[index];
      ref.read(cityProvider.notifier).state = city;
    });
  }

  final hour = DateTime.now().hour;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors:
                hour <= 18 ? AppColors.rainGradient : AppColors.nightGradient,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 100),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const CitySearchBox(),
              const SizedBox(height: 50),
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: 4,
                  itemBuilder: (context, index) => const CurrentWeather(),
                ),
              ),
              const SizedBox(height: 50),
              const Text(
                'Swipe to see more',
                style: TextStyle(color: Colors.white, fontSize: 12),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
