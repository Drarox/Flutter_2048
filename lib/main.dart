import 'package:flutter/material.dart';
import 'package:flutter2048/screens/game_screen.dart';
import 'package:flutter2048/constants.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override aad
  Widget build(BuildContext context) {
    return MaterialApp(
      title: KAppTitle,
      theme: ThemeData(
        primarySwatch: kMainColor,
      ),
      home: GameScreen(),
    );
  }
}
