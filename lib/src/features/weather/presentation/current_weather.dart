import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app_mobile/src/features/weather/application/providers.dart';
import 'package:weather_app_mobile/src/features/weather/presentation/hourly_weather.dart';
import 'package:weather_app_mobile/src/features/weather/presentation/weather_icon_image.dart';

import '../domain/weather/weather_data.dart';

class CurrentWeather extends ConsumerWidget {
  const CurrentWeather({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final weatherDataValue = ref.watch(weatherProvider);
    final city = ref.watch(cityProvider);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(city, style: Theme.of(context).textTheme.headlineSmall),
        weatherDataValue.when(
          data: (weatherData) => CurrentWeatherContents(data: weatherData),
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, __) => Text(e.toString()),
        ),
        const SizedBox(height: 20),
        const HourlyWeather(), // Display hourly weather below
      ],
    );
  }
}

class CurrentWeatherContents extends StatelessWidget {
  const CurrentWeatherContents({super.key, required this.data});
  final WeatherData data;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    final temp = data.temp.celsius.toInt().toString();
    final minTemp = data.minTemp.celsius.toInt().toString();
    final maxTemp = data.maxTemp.celsius.toInt().toString();
    final highAndLow = 'High: $maxTemp° Low: $minTemp°';
    final description = data.description;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        WeatherIconImage(iconUrl: data.iconUrl, size: 120),
        Text(
          temp,
          style: textTheme.displayMedium,
        ),
        Text(highAndLow, style: textTheme.bodyMedium),
        const SizedBox(height: 20),
        Text(description, style: textTheme.bodyMedium),
        const SizedBox(height: 20),
      ],
    );
  }
}
