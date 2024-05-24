import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app_mobile/src/features/weather/presentation/weather_choose_cities.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  List<String> defaultCities = [
    'Silverstone, UK',
    'Sao Paulo, Brazil',
    'Melbourne, Australia',
    'Monte Carlo, Monaco'
  ];
  List<String>? savedCities = prefs.getStringList('favoriteCities');
  if (savedCities == null || savedCities.isEmpty) {
    prefs.setStringList('favoriteCities', defaultCities);
  } else {
    // Add default cities only if they're not already present
    for (final defaultCity in defaultCities) {
      if (!savedCities.contains(defaultCity)) {
        savedCities.add(defaultCity);
      }
    }
    prefs.setStringList('favoriteCities', savedCities);
  }
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rock Weather App',
      debugShowCheckedModeBanner: false,
      theme: _buildTheme(context),
      home: const AddCityScreen(),
    );
  }

  ThemeData _buildTheme(BuildContext context) {
    const textStyle =
        TextStyle(color: Colors.black, fontWeight: FontWeight.w500);
    final boxShadow = BoxShadow(
      color: Colors.black12.withOpacity(0.25),
      spreadRadius: 1,
      blurRadius: 4,
      offset: const Offset(0, 0.5),
    );

    return ThemeData(
      brightness: Brightness.light,
      textTheme: TextTheme(
        headlineMedium: textStyle,
        bodyLarge: textStyle,
        bodySmall: textStyle.copyWith(fontSize: 13),
        displayLarge: textStyle.copyWith(shadows: [boxShadow]),
        displayMedium: textStyle.copyWith(shadows: [boxShadow]),
        displaySmall: textStyle.copyWith(shadows: [boxShadow]),
        headlineSmall: textStyle.copyWith(shadows: [boxShadow]),
        titleMedium: textStyle.copyWith(shadows: [boxShadow]),
        bodyMedium: textStyle.copyWith(shadows: [boxShadow]),
      ),
    );
  }
}
