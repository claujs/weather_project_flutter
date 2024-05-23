import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app_mobile/src/features/weather/data/weather_repository.dart';
import 'package:weather_app_mobile/src/features/weather/domain/forecast/forecast_data.dart';
import 'package:weather_app_mobile/src/features/weather/domain/weather/weather_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

final cityProvider = StateProvider<String>((ref) => 'Melbourne');

final weatherProvider = FutureProvider.autoDispose<WeatherData>((ref) async {
  final city = ref.watch(cityProvider);
  final weatherResponse =
      await ref.watch(weatherRepositoryProvider).getWeather(city: city);
  return WeatherData.from(weatherResponse!);
});

final forecastProvider = FutureProvider.autoDispose<ForecastData>((ref) async {
  final city = ref.watch(cityProvider);
  final forecastResponse =
      await ref.watch(weatherRepositoryProvider).getForecast(city: city);
  return ForecastData.from(forecastResponse!);
});

final favoriteCitiesProvider = StateProvider<List<String>>((ref) => []);

final loadFavoriteCitiesProvider = FutureProvider.autoDispose<List<String>>(
  (ref) async {
    final prefs = await SharedPreferences.getInstance();
    final cities = prefs.getStringList('favoriteCities') ?? [];
    ref.read(favoriteCitiesProvider.notifier).state = cities;
    return cities;
  },
);
