import 'package:flutter/material.dart';

class AppTheme {
  // Identidade visual do eBuck
  static const Color primary = Color(0xFF0B72FF); // azul vibrante
  static const Color accent = Color(0xFFFFC857);  // amarelo quente
  static const Color bg = Color(0xFFF6F8FF);

  static final ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: bg,
    primaryColor: primary,
    colorScheme: ColorScheme.fromSeed(seedColor: primary, primary: primary, secondary: accent),
    useMaterial3: true,
    appBarTheme: const AppBarTheme(
      backgroundColor: primary,
      foregroundColor: Colors.white,
      elevation: 2,
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: accent,
      foregroundColor: Colors.black,
    ),
    textTheme: const TextTheme(
      titleLarge: TextStyle(fontWeight: FontWeight.bold),
    ),
  );
}