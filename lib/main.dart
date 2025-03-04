import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:project_ui_demo/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MaterialApp(
    home: SplashScreen(),
  ));
}
