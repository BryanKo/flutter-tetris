import 'package:flutter/material.dart';

import '../settings.dart';
import 'point.dart';
import '../game.dart';

class Block {
  List<Point> points = List<Point>(4);
  Point rotateCenter;
  Color color;
  var setting = Setting();

  void move(MoveDir dir) {
    switch (dir) {
      case MoveDir.LEFT:
        if (canMoveToSide(-1)) {
          points.forEach((point) {
            point.x -= 1;
          });
        }
        break;
      case MoveDir.RIGHT:
        if (canMoveToSide(1)) {
          points.forEach((point) {
            point.x += 1;
          });
        }
        break;
      case MoveDir.DOWN:
        points.forEach((point) {
          point.y += 1;
        });
        break;
    }
  }

  bool canMoveToSide(int moveAmt) {
    bool retVal = true;

    points.forEach((point) {
      if (point.x + moveAmt < 0 || point.x + moveAmt >= setting.boardWidth) {
        retVal = false;
      }
    });

    return retVal;
  }

  bool allPointsInside() {
    bool retVal = true;

    points.forEach((point) {
      if (point.x < 0 || point.x >= setting.boardWidth) {
        retVal = false;
      }
    });
    return retVal;
  }

  void rotateRight() {
    print("[testing] right: ${rotateCenter.x}, ${rotateCenter.y}");
    points.forEach((point) {
      int x = point.x;
      point.x = rotateCenter.x - point.y + rotateCenter.y;
      point.y = rotateCenter.y + x - rotateCenter.x;
    });

    if (!allPointsInside()) {
      rotateLeft();
    }
  }

  void rotateLeft() {
    print("[testing left]: ${rotateCenter.x}, ${rotateCenter.y}");
    points.forEach((point) {
      int x = point.x;
      point.x = rotateCenter.x + point.y - rotateCenter.y;
      point.y = rotateCenter.y - x + rotateCenter.x;
    });

    if (!allPointsInside()) {
      rotateRight();
    }
  }

  bool isAtBottom() {
    int lowestPoint = 0;
    points.forEach((point) { 
      if (point.y > lowestPoint) {
        lowestPoint = point.y;
      }
    });

    if (lowestPoint >= setting.boardHeight -1)
      return true;
    return false;
  }
}
