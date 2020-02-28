import 'package:flutter/material.dart';
import 'package:flutter2048/widgets/boardgridview.dart';
import 'package:flutter2048/models/game.dart';
import 'package:flutter2048/widgets/cellwidget.dart';
import 'package:flutter2048/constants.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:flutter2048/models/data.dart';

class GameScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GameWidget(),
    );
  }
}

class GameWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return GameWidgetState();
  }
}

class GameWidgetState extends State<GameWidget> {
  Game _game;
  MediaQueryData _queryData;
  final int row = 4;
  final int column = 4;
  final double cellPadding = 5.0;
  bool _isDragging = false;
  bool _isGameOver = false; //cause the game is never over!
  int bestScore = 0;

  @override
  void initState() {
    super.initState();
    _readBestScore();
    _game = Game(row, column);
    newGame();
  }

  _readBestScore() async {
    dynamic res = await readScore();
    setState(() {
      bestScore = res;
    });
  }

  void newGame() {
    _game.init();
    _isGameOver = false;
    setState(() {});
  }

  void moveLeft() {
    setState(() {
      _game.moveLeft();
      checkGameOver();
    });
  }

  void moveRight() {
    setState(() {
      _game.moveRight();
      checkGameOver();
    });
  }

  void moveUp() {
    setState(() {
      _game.moveUp();
      checkGameOver();
    });
  }

  void moveDown() {
    setState(() {
      _game.moveDown();
      checkGameOver();
    });
  }

  void checkGameOver() {
    if (_game.isGameOver()) {
      _isGameOver = true;
      String title = "Finished";
      int scoreEnd = _game.score;
      if (scoreEnd > bestScore) {
        saveScore(scoreEnd);
        title = "New High Score !";
        setState(() {
          bestScore = scoreEnd;
        });
      }
      Alert(
        context: context,
        type: AlertType.info,
        title: title,
        desc: "The game is over your score is $scoreEnd.",
        buttons: [
          DialogButton(
            child: Text(
              "Close",
              style: dialogTextStyle,
            ),
            onPressed: () => Navigator.pop(context),
            width: 120,
          ),
          DialogButton(
            child: Text(
              "New Game",
              style: dialogTextStyle,
            ),
            onPressed: () {
              newGame();
              Navigator.pop(context);
            },
            gradient: backgroundGradient,
          )
        ],
      ).show();
    }
  }

  @override
  Widget build(BuildContext context) {
    List<CellWidget> _cellWidget = List<CellWidget>();
    for (int r = 0; r < row; ++r) {
      for (int c = 0; c < column; ++c) {
        _cellWidget.add(CellWidget(cell: _game.get(r, c), state: this));
      }
    }
    _queryData = MediaQuery.of(context);
    List<Widget> children = List<Widget>();
    children.add(BoardGridWidget(this));
    children.addAll(_cellWidget);
    return Container(
      decoration: BoxDecoration(
        gradient: backgroundGradient,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            margin: const EdgeInsets.only(
              top: 30.0,
              bottom: 20.0,
            ),
            child: Text(
              '2048',
              style: titleTextStyle,
            ),
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.only(
                    bottom: 15.0,
                  ),
                  decoration: BoxDecoration(
                    color: boxBackground,
                    borderRadius: BorderRadius.all(
                      Radius.circular(10.0),
                    ),
                  ),
                  child: Container(
                    width: 130.0,
                    height: 60.0,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Score',
                          style: TextStyle(
                            color: textColor,
                          ),
                        ),
                        Text(
                          _game.score.toString(),
                          style: boxTextStyle,
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(
                    bottom: 15.0,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    color: boxBackground,
                  ),
                  width: 130.0,
                  height: 60.0,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Best',
                        style: TextStyle(
                          color: textColor,
                        ),
                      ),
                      Text(
                        bestScore.toString(),
                        style: boxTextStyle,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          FlatButton(
            padding: EdgeInsets.all(0.0),
            child: Container(
              width: 80.0,
              height: 60.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                color: boxBackground,
              ),
              child: Center(
                child: Icon(
                  Icons.refresh,
                  color: textColor,
                  size: 42,
                ),
              ),
            ),
            onPressed: () {
              newGame();
            },
          ),
          Container(
              padding: EdgeInsets.only(
                top: 20.0,
              ),
              margin: gameMargin,
              width: boardSize().width, //_queryData.size.width,
              height: _queryData.size.width,
              child: GestureDetector(
                onVerticalDragUpdate: (detail) {
                  if (detail.delta.distance == 0 || _isDragging) {
                    return;
                  }
                  _isDragging = true;
                  if (detail.delta.direction > 0) {
                    moveDown();
                  } else {
                    moveUp();
                  }
                },
                onVerticalDragEnd: (detail) {
                  _isDragging = false;
                },
                onVerticalDragCancel: () {
                  _isDragging = false;
                },
                onHorizontalDragUpdate: (detail) {
                  if (detail.delta.distance == 0 || _isDragging) {
                    return;
                  }
                  _isDragging = true;
                  if (detail.delta.direction > 0) {
                    moveLeft();
                  } else {
                    moveRight();
                  }
                },
                onHorizontalDragDown: (detail) {
                  _isDragging = false;
                },
                onHorizontalDragCancel: () {
                  _isDragging = false;
                },
                child: Stack(
                  children: children,
                ),
              )),
        ],
      ),
    );
  }

  Size boardSize() {
    assert(_queryData != null);
    Size size = _queryData.size;
    num width = size.width - gameMargin.left - gameMargin.right;
    double ratio = size.width / size.height;
    if (ratio > 0.75) {
      width = size.height / 2;
    }
    return Size(width, width);
  }
}
