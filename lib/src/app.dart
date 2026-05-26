import 'package:flutter/material.dart';
import 'package:barabar/src/screens/home_screen.dart';
import 'package:barabar/src/theme.dart';

class BiskyApp extends StatelessWidget {
  const BiskyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BISKY',
      debugShowCheckedModeBanner: false,
      theme: appTheme,
      home: const HomeScreen(),
    );
  }
}
