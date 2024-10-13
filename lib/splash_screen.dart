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
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 5), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const NavBar()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/images/entry_logo.png',height: 100,width: 100,),
          const SizedBox(height: 10,),
          const Center(
              child: Text('ParkIT!', style: TextStyle(fontSize: 25, color: Colors.black)),
          ),
          const Center(
              child: Text('Smart Parking Allotment Application', style: TextStyle(fontSize: 13)),
          ),
        ],
      ),
    );
  }
}

