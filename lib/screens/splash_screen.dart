import 'dart:async';
import 'package:flutter/material.dart';
import 'start_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Timer.periodic(Duration(seconds: 3), (timer) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            return StartScreen();
          },
        ),
      );
    });
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [Image.network('assets/tictactoa.png')],
      ),
    );
  }
}
