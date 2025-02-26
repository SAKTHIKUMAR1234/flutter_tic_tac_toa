import 'package:flutter/material.dart';
import 'screens/start_screen.dart';

void main(List<String> args) {
  runApp(TictakToa());
}


class TictakToa extends StatelessWidget{
  const TictakToa({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: StartScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
  
}



