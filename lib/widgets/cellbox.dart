import 'package:flutter/material.dart';

class CellBox extends StatelessWidget {
  final double left;
  final double top;
  final double size;
  final Color color;
  final Text text;
  CellBox({this.left, this.top, this.size, this.color, this.text});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: left,
      top: top,
      child: Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
          ),
          child: Center(
            child: text,
          )),
    );
  }
}

