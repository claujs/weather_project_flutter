import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app_mobile/src/features/weather/presentation/weather_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rock Weather App',
      debugShowCheckedModeBanner: false,
      theme: _buildTheme(context),
      home: const WeatherPage(city: 'Melbourne'),
    );
  }

  ThemeData _buildTheme(BuildContext context) {
    const textStyle = TextStyle(color: Colors.white);
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
