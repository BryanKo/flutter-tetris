import 'package:flutter/material.dart';
import 'package:tetris/settings.dart';
import 'dart:math';

import 'block/block.dart';
import 'block/IBlock.dart';
import 'block/JBlock.dart';
import 'block/LBlock.dart';
import 'block/SBlock.dart';
import 'block/SqBlock.dart';
import 'block/TBlock.dart';
import 'block/ZBlock.dart';
import 'game.dart';

Block getRandomBlock() {
  var setting = Setting();
  int randomNbr = Random().nextInt(7);
  switch (randomNbr) {
    case 0:
      return IBlock(setting.boardWidth);
    case 1:
      return JBlock(setting.boardWidth);
    case 2:
      return LBlock(setting.boardWidth);
    case 3:
      return SBlock(setting.boardWidth);
    case 4:
      return SqBlock(setting.boardWidth);
    case 5:
      return TBlock(setting.boardWidth);
    case 6:
      return ZBlock(setting.boardWidth);
  }
}

Widget getTetrisPoint(Color color) {
  var setting = Setting();
  return Container(
    width: setting.pointSize,
    height: setting.pointSize,
    decoration: new BoxDecoration(
      color: color,
      shape: BoxShape.rectangle,
    ),
  );
}

Widget getGameOverText(int score) {
  return Center(
    child: Text(
      'Game Over\nEnd Score: $score',
      style: TextStyle(
        fontSize: 35.0,
        fontWeight: FontWeight.bold,
        color: Colors.red,
        shadows: [
          Shadow(
            color: Colors.black,
            blurRadius: 3.0,
            offset: Offset(2.0, 2.0),
          ),
        ],
      ),
    ),
  );
}
