import 'package:flutter/material.dart';
import 'package:flutter2048/models/boardcell.dart';
import 'package:flutter2048/screens/game_screen.dart';
import 'package:flutter2048/widgets/cellbox.dart';
import 'package:flutter2048/constants.dart';

class AnimatedCellWidget extends AnimatedWidget {
  final BoardCell cell;
  final GameWidgetState state;
  AnimatedCellWidget(
      {Key key, this.cell, this.state, Animation<double> animation})
      : super(key: key, listenable: animation);

  @override
  Widget build(BuildContext context) {
    final Animation<double> animation = listenable;
    double animationValue = animation.value;
    Size boardSize = state.boardSize();
    double width = (boardSize.width - (state.column + 1) * state.cellPadding) /
        state.column;
    if (cell.number == 0) {
      return Container();
    } else {
      return CellBox(
        left: (cell.column * width + state.cellPadding * (cell.column + 1)) +
            width / 2 * (1 - animationValue),
        top: cell.row * width +
            state.cellPadding * (cell.row + 1) +
            width / 2 * (1 - animationValue),
        size: width * animationValue,
        color: boxColor.containsKey(cell.number)
            ? boxColor[cell.number]
            : boxColor[boxColor.keys.last],
        text: Text(
          cell.number.toString(),
          style: TextStyle(
            fontSize: 30.0 * animationValue,
            fontWeight: FontWeight.bold,
            color: cell.number < 32 ? Colors.grey[600] : Colors.grey[50],
          ),
        ),
      );
    }
  }
}
