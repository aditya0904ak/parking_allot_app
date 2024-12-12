import 'package:flutter/material.dart';
import 'dart:async';
import 'package:project_ui_demo/nav_bar.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  // void initState() {
  //   super.initState();
  //   Timer(const Duration(seconds: 5), () {
  //     Navigator.pushReplacement(
  //       context,
  //       MaterialPageRoute(builder: (context) => const NavBar()),
  //     );
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/splash_img.png',
            height: 300,
            width: double.infinity, // Makes the image span the full width
            fit: BoxFit.cover, // Ensures the image fills the width proportionally
          ),
          const SizedBox(height: 10),

          Image.asset('assets/images/park_it_text.png'),
        ],
      ),
    );
  }
}
