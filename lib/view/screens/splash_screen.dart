import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:page_transition/page_transition.dart';
import 'home_screen.dart';

class SplashScreenF extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreenF> {
  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splashIconSize: 550.0,
      duration: 3000,
      splash: Card(
          child: Image(
        image: AssetImage("assate/images/unnamed.png"),

      )),
      nextScreen: HomeScreen(),
      splashTransition: SplashTransition.slideTransition,
      pageTransitionType: PageTransitionType.rightToLeft,
      backgroundColor: Color(0xffffffff),
    );
  }
}
