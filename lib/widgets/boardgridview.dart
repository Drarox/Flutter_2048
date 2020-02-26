import 'package:flutter/material.dart';
import 'package:flutter2048/screens/game_screen.dart';
import 'package:flutter2048/widgets/cellbox.dart';

class BoardGridWidget extends StatelessWidget {
  final GameWidgetState _state;
  BoardGridWidget(this._state);
  @override
  Widget build(BuildContext context) {
    Size boardSize = _state.boardSize();
    double width =
        (boardSize.width - (_state.column + 1) * _state.cellPadding) /
            _state.column;
    List<CellBox> _backgroundBox = List<CellBox>();
    for (int r = 0; r < _state.row; ++r) {
      for (int c = 0; c < _state.column; ++c) {
        CellBox box = CellBox(
          left: c * width + _state.cellPadding * (c + 1),
          top: r * width + _state.cellPadding * (r + 1),
          size: width,
          color: Colors.blueGrey[100],
        );
        _backgroundBox.add(box);
      }
    }
    return Positioned(
        left: 0.0,
        top: 0.0,
        child: Container(
          width: _state.boardSize().width,
          height: _state.boardSize().height,
          decoration: BoxDecoration(
            color: Colors.blueGrey,
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
          ),
          child: Stack(
            children: _backgroundBox,
          ),
        ));
  }
}
