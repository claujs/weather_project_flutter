import 'package:weather_app_mobile/src/features/weather/domain/forecast/forecast.dart';

import '../weather/weather_data.dart';

class ForecastData {
  const ForecastData(this.list);

  factory ForecastData.from(Forecast forecast) {
    return ForecastData(
      forecast.list.map((e) => WeatherData.from(e)).toList(),
    );
  }

  final List<WeatherData> list;
}
