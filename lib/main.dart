import 'package:flutter/material.dart';

import 'models/conversion_model.dart';
import 'screens/splash_screen.dart';

void main() {
  runApp(const CurrencyConverterApp());
}

class CurrencyConverterApp extends StatefulWidget {
  const CurrencyConverterApp({super.key});

  @override
  State<CurrencyConverterApp> createState() => _CurrencyConverterAppState();
}

class _CurrencyConverterAppState extends State<CurrencyConverterApp> {
  // App-level state for theme mode and in-memory conversion history.
  ThemeMode _themeMode = ThemeMode.light;
  final List<ConversionModel> _history = [];

  void _updateThemeMode(ThemeMode mode) {
    setState(() {
      _themeMode = mode;
    });
  }

  void _addConversion(ConversionModel conversion) {
    setState(() {
      // Insert latest conversion at the top for better UX in history list.
      _history.insert(0, conversion);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Currency Converter App',
      themeMode: _themeMode,
      theme: _buildLightTheme(),
      darkTheme: _buildDarkTheme(),
      home: SplashScreen(
        onThemeChanged: _updateThemeMode,
        history: _history,
        onAddConversion: _addConversion,
      ),
    );
  }
}

ThemeData _buildLightTheme() {
  const primaryColor = Color(0xFFCC6D1A);

  return ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: primaryColor,
      brightness: Brightness.light,
    ),
    scaffoldBackgroundColor: const Color(0xFFFFF7F1),
    cardTheme: CardThemeData(
      color: const Color(0xFFFFFCF8),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
    ),
    appBarTheme: const AppBarTheme(
      centerTitle: true,
      elevation: 0,
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: const Color(0xFFFFFCF8),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),
  );
}

ThemeData _buildDarkTheme() {
  const primaryColor = Color(0xFFE4832A);

  return ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: primaryColor,
      brightness: Brightness.dark,
    ),
    scaffoldBackgroundColor: const Color(0xFF18110D),
    cardTheme: CardThemeData(
      color: const Color(0xFF231915),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
    ),
    appBarTheme: const AppBarTheme(
      centerTitle: true,
      elevation: 0,
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: const Color(0xFF2A1E18),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),
  );
}
