import 'package:flutter/material.dart';
import 'login_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 10), () {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginPage()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF6A3DBF),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 190,
                height: 190,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Icon(Icons.directions_run, size: 115, color: Colors.white),
                ),
              ),
              const SizedBox(height: 35),
              const Text("STRIDE", style: TextStyle(fontSize: 42, fontWeight: FontWeight.bold, letterSpacing: 3, color: Colors.white)),
              const SizedBox(height: 12),
              const Text("Smart Tracking for Running\n& Daily Exercise", textAlign: TextAlign.center, style: TextStyle(fontSize: 16, height: 1.5, color: Colors.white70)),
              const SizedBox(height: 60),
              SizedBox(
                width: 160,
                child: LinearProgressIndicator(
                  minHeight: 5,
                  backgroundColor: Colors.white24,
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}