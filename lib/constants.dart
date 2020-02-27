import 'package:flutter/material.dart';

const KAppTitle = 'Flutter 2048';
const kMainColor = Colors.blue;

final Map<int, Color> boxColor = <int, Color>{
  2: Colors.blue[50],
  4: Colors.blue[100],
  8: Colors.blue[200],
  16: Colors.blue[300],
  32: Colors.blue[400],
  64: Colors.blue[500],
  128: Colors.blue[600],
  256: Colors.blue[700],
  512: Colors.blue[800],
  1025: Colors.blue[900],
};

final mainOffColor = Colors.blue[200];

final dialogTextStyle = TextStyle(color: Colors.white, fontSize: 20);

final backgroundGradient = LinearGradient(
    begin: Alignment.topRight,
    end: Alignment.bottomLeft,
    colors: [Colors.blue, Colors.greenAccent]);

final boxBackground = Color.fromRGBO(96, 125, 139, 0.75); //Colors.blueGrey;

final textColor = Colors.white;

final boxTextStyle = TextStyle(
  fontSize: 30.0,
  fontWeight: FontWeight.bold,
  color: textColor,
);

final buttonGradient = LinearGradient(colors: [
  Color.fromRGBO(116, 116, 191, 1.0),
  Color.fromRGBO(52, 212, 212, 1.0)
]);

final titleTextStyle = TextStyle(
  fontSize: 100.0,
  fontWeight: FontWeight.bold,
  color: textColor,
);

final cellBoxColor = Color.fromRGBO(207, 216, 220, 0.5);

final borderColor = Color.fromRGBO(96, 125, 139, 0.75);
