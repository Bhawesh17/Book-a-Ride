import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:book_a_ride/feature/login&singup_screen/login_screen.dart';
import 'package:book_a_ride/feature/login&singup_screen/singup.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedSplashScreen(
          duration: 4,
          splash: Image.asset('assets/logo.png'),
          nextScreen: LoginScreen(),
          splashTransition: SplashTransition.fadeTransition,
          splashIconSize: double.infinity,
          backgroundColor: Color(0xFFff4600),
          // pageTransitionType: PageTransitionType.scale,
          ));

  }
}
