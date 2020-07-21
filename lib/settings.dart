import 'dart:async';

import 'package:tetris/main.dart';

enum LastButtonPressed { LEFT, RIGHT, ROTATE_LEFT, ROTATE_RIGHT, NONE }
enum MoveDir { LEFT, RIGHT, DOWN }
enum GameSpeed { SPEED_1X, SPEED_2X, SPEED_3X }

class Setting {
  static final Setting _instance = Setting._internal();

  int boardWidth = 10;
  int boardHeight = 20;
  int gameSpeed  = 400;

  double pointSize = 20;
  double pixelWidth = 200;
  double pixelHeight = 400;
  
  Timer timer;

  bool _hasBeenSetup;

  factory Setting() {
    return _instance;
  }

  Setting._internal() {
    boardWidth = 10;
    boardHeight = 20;
    gameSpeed = 400;
    pointSize = 20;
    pixelWidth = 200;
    pixelHeight = 400;
    _hasBeenSetup = false;
  }

  void setupPlayingField(double screenWidth, double screenHeight) {
    if (_hasBeenSetup) return;

    _hasBeenSetup = true;
    double userInputFieldPadding = 250.0;

    double newHeight = screenHeight - userInputFieldPadding;
    double newWidth = newHeight/2.0;

    pixelHeight = newHeight;
    pixelWidth = newWidth;
    pointSize = pixelHeight/boardHeight;
    print("Calculated -> newHeight: $pixelHeight, newWidth: $pixelWidth, newPointSize: $pointSize");
  }

  void changeGameSpeed(GameSpeed newSpeed) {
    if (newSpeed == GameSpeed.SPEED_1X) {
      gameSpeed = 400;
    } else if (newSpeed == GameSpeed.SPEED_2X) {
      gameSpeed = 200;
    } else if (newSpeed == GameSpeed.SPEED_3X) {
      gameSpeed = 100;
    }
  }
}