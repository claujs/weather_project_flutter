import 'package:weather_app_mobile/src/features/weather/domain/forecast/forecast.dart';

import '../weather/weather_data.dart';

class ForecastData {
  const ForecastData(this.list);

  factory ForecastData.from(Forecast forecast) {
    return ForecastData(
      forecast.list.map((e) => WeatherData.from(e)).toList(),
    );
  }

  factory ForecastData.fromJson(Map<String, dynamic> json) {
    final list = json['list'] as List<dynamic>;
    return ForecastData(
      list.map((e) => WeatherData.fromJson(e)).toList(),
    );
  }

  final List<WeatherData> list;
}
