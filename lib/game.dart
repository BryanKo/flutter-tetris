import 'dart:async';

import 'package:flutter/material.dart';
import 'package:tetris/block/block.dart';
import 'package:tetris/settings.dart';
import 'helper.dart';
import 'block/alivePoint.dart';
import 'scoreDisplay.dart';
import 'userInput.dart';

class Game extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _Game();
}

class _Game extends State<Game> {
  LastButtonPressed performedAction = LastButtonPressed.NONE;
  Block currentBlock;
  List<AlivePoint> alivePoints = List<AlivePoint>();
  int score = 0;
  var setting = Setting();

  @override
  void initState() {
    super.initState();
    startGame();
  }

  void onActionButtonPressed(LastButtonPressed newAction) {
    setState(() {
      performedAction = newAction;
    });
  }

  void startGame() {
    setState(() {
      currentBlock = getRandomBlock();
    });
    setting.timer = new Timer.periodic(
      new Duration(milliseconds: setting.gameSpeed),
      onTimeTick,
    );
  }

  void checkForUserInput() {
    if (performedAction != LastButtonPressed.NONE) {
      setState(() {
        switch (performedAction) {
          case (LastButtonPressed.LEFT):
            currentBlock.move(MoveDir.LEFT);
            break;
          case (LastButtonPressed.RIGHT):
            currentBlock.move(MoveDir.RIGHT);
            break;
          case (LastButtonPressed.ROTATE_LEFT):
            currentBlock.rotateLeft();
            break;
          case (LastButtonPressed.ROTATE_RIGHT):
            currentBlock.rotateRight();
            break;
          default:
            break;
        }

        performedAction = LastButtonPressed.NONE;
      });
    }
  }

  void saveOldBlock() {
    currentBlock.points.forEach((point) {
      AlivePoint newPoints = AlivePoint(point.x, point.y, currentBlock.color);
      setState(() {
        alivePoints.add(newPoints);
      });
    });
  }

  bool isAboveOldBlock() {
    bool retVal = false;

    alivePoints.forEach((oldPoint) {
      if (oldPoint.checkIfPointsCollide(currentBlock.points)) {
        retVal = true;
      }
    });
    return retVal;
  }

  void removeRow(int row) {
    setState(() {
      alivePoints.removeWhere((point) => point.y == row);
      alivePoints.forEach((point) {
        if (point.y < row) {
          point.y += 1;
        }
      });
      score += 1;
    });
  }

  void removeFullRows() {
    for (int currentRow = 0; currentRow < setting.boardHeight; currentRow++) {
      int counter = 0;
      alivePoints.forEach((point) {
        if (point.y == currentRow) {
          counter++;
        }
      });

      if (counter == setting.boardWidth) {
        removeRow(currentRow);
      }
    }
  }

  bool playerLost() {
    bool retVal = false;

    alivePoints.forEach((point) {
      if (point.y <= 0) {
        retVal = true;
      }
    });

    return retVal;
  }

  void onTimeTick(Timer time) {
    if (currentBlock == null || playerLost()) return;

    removeFullRows();

    if (currentBlock.isAtBottom() || isAboveOldBlock()) {
      saveOldBlock();
      setState(() {
        currentBlock = getRandomBlock();
      });
    } else {
      setState(() {
        currentBlock.move(MoveDir.DOWN);
      });
      checkForUserInput();
    }
  }

  Widget drawTetrisBlock() {
    if (currentBlock == null) return null;

    List<Positioned> visiblePoints = List();

    currentBlock.points.forEach((point) {
      Positioned newPoint = Positioned(
        child: getTetrisPoint(currentBlock.color),
        left: point.x * setting.pointSize,
        top: point.y * setting.pointSize,
      );
      visiblePoints.add(newPoint);
    });

    alivePoints.forEach((point) {
      visiblePoints.add(
        Positioned(
          child: getTetrisPoint(point.color),
          left: point.x * setting.pointSize,
          top: point.y * setting.pointSize,
        ),
      );
    });

    return Stack(children: visiblePoints);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Center(
          child: Container(
            width: setting.pixelWidth,
            height: setting.pixelHeight,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
            ),
            child: (!playerLost()) ? drawTetrisBlock() : getGameOverText(score),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            ScoreDisplay(score),
            UserInput(onActionButtonPressed),
          ],
        ),
      ],
    );
  }
}
