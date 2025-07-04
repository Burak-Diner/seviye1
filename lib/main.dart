// lib/main.dart

import 'package:flutter/material.dart';
import 'theme/app_theme.dart';
import 'screens/landing_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Spor Testi',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.themeData,
      home: const LandingPage(),
    );
  }
}
