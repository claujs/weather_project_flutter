import 'package:weather_app_mobile/src/features/weather/domain/temperature.dart';
import 'package:weather_app_mobile/src/features/weather/domain/weather/weather.dart';

/// Derived model class used in the UI
class WeatherData {
  WeatherData({
    required this.temp,
    required this.minTemp,
    required this.maxTemp,
    required this.description,
    required this.date,
    required this.icon,
  });

  factory WeatherData.from(Weather weather) {
    return WeatherData(
      temp: Temperature.celsius(weather.weatherParams.temp),
      minTemp: Temperature.celsius(weather.weatherParams.tempMin),
      maxTemp: Temperature.celsius(weather.weatherParams.tempMax),
      description: weather.weatherInfo[0].main,
      date: DateTime.fromMillisecondsSinceEpoch(weather.dt * 1000),
      icon: weather.weatherInfo[0].icon,
    );
  }

  factory WeatherData.fromJson(Map<String, dynamic> json) {
    return WeatherData(
      temp: Temperature.celsius(json['main']['temp']),
      minTemp: Temperature.celsius(json['main']['temp_min']),
      maxTemp: Temperature.celsius(json['main']['temp_max']),
      description: json['weather'][0]['main'],
      date: DateTime.fromMillisecondsSinceEpoch(json['dt'] * 1000),
      icon: json['weather'][0]['icon'],
    );
  }

  final Temperature temp;
  final Temperature minTemp;
  final Temperature maxTemp;
  final String description;
  final DateTime date;
  final String icon;

  String get iconUrl => "https://openweathermap.org/img/wn/$icon@2x.png";
}
