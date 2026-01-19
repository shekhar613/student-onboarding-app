import 'package:flutter/material.dart';
// import 'package:student_onboarding/pages/HomeScreen.dart';
import 'package:student_onboarding/pages/StartOnboardingScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Student Onboarding',
      home: Startonboardingscreen(),
    );
  }
}
