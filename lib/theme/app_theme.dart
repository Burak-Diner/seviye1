// lib/theme/app_theme.dart

import 'package:flutter/material.dart';

class AppTheme {
  static final ThemeData themeData = ThemeData(
    fontFamily: 'Helvetica Neue',
    primaryColor: const Color.fromRGBO(106, 0, 255, 1),
    scaffoldBackgroundColor: const Color.fromRGBO(106, 0, 255, 1),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color.fromRGBO(106, 0, 255, 1),
      foregroundColor: Colors.white,
      elevation: 0,
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: Colors.white),
      bodyMedium: TextStyle(color: Colors.white),
      titleLarge: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      titleMedium: TextStyle(color: Colors.white),
      bodySmall: TextStyle(color: Colors.white70),
    ),
    colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.white),
  );
}
