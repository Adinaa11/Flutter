import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'viewmodels/activity_viewmodel.dart';
import 'viewmodels/login_viewmodel.dart';
import 'views/splash_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ActivityViewModel(),
        ),
        ChangeNotifierProvider(
          create: (_) => LoginViewModel(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'STRIDE',
      theme: ThemeData.light().copyWith(
        primaryColor: const Color(0xFF6A3DBF),
        scaffoldBackgroundColor: const Color(0xFFF5F4FF),
      ),
      home: const SplashScreen(),
    );
  }
}