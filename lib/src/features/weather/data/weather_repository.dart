import 'dart:convert';
import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app_mobile/src/api/api.dart';
import 'package:weather_app_mobile/src/api/api_keys.default.dart';
import 'package:weather_app_mobile/src/features/weather/data/api_exception.dart';
import 'package:weather_app_mobile/src/features/weather/domain/forecast/forecast.dart';
import 'package:weather_app_mobile/src/features/weather/domain/weather/weather.dart';

class HttpWeatherRepository {
  HttpWeatherRepository({required this.api, required this.client});
  final OpenWeatherMapAPI api;
  final http.Client client;

  Future<Forecast> getForecast({required String city}) => _getData(
        uri: api.forecast(city),
        builder: (data) => Forecast.fromJson(data),
        cacheKey: 'forecast_$city',
      );

  Future<Weather> getWeather({required String city}) => _getData(
        uri: api.weather(city),
        builder: (data) => Weather.fromJson(data),
        cacheKey: 'weather_$city',
      );

  Future<T> _getData<T>({
    required Uri uri,
    required T Function(dynamic data) builder,
    required String cacheKey,
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      final response = await client.get(uri);
      switch (response.statusCode) {
        case 200:
          final data = json.decode(response.body);
          await prefs.setString(cacheKey, response.body);
          return builder(data);
        case 401:
          throw InvalidApiKeyException();
        case 404:
          throw CityNotFoundException();
        default:
          throw UnknownException();
      }
    } on SocketException catch (_) {
      final cachedData = prefs.getString(cacheKey);
      if (cachedData != null) {
        final data = json.decode(cachedData);
        return builder(data);
      } else {
        throw NoInternetConnectionException();
      }
    }
  }
}

/// Providers used by rest of the app
final weatherRepositoryProvider = Provider<HttpWeatherRepository>((ref) {
  const apiKey = String.fromEnvironment(
    'API_KEY',
    defaultValue: APIKeys.openWeatherAPIKey,
  );
  return HttpWeatherRepository(
    api: OpenWeatherMapAPI(apiKey),
    client: http.Client(),
  );
});
