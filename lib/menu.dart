import 'package:flutter/material.dart';
import 'package:tetris/main.dart';
import 'package:tetris/menuButton.dart';
import 'settings.dart';

class Menu extends StatefulWidget {
  State<StatefulWidget> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  var setting = Setting();
  GameSpeed currentSpeed = GameSpeed.SPEED_1X;

  void onPlayClicked() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => GameScreen()),
    );
  }

  void changeGameSpeed() {
    if (currentSpeed == GameSpeed.SPEED_1X) {
      setState(() {
        currentSpeed = GameSpeed.SPEED_2X;
      });
    } else if (currentSpeed == GameSpeed.SPEED_2X) {
      setState(() {
        currentSpeed = GameSpeed.SPEED_3X;
      });
    } else if (currentSpeed == GameSpeed.SPEED_3X) {
      setState(() {
        currentSpeed = GameSpeed.SPEED_1X;
      });
    }
    setting.changeGameSpeed(currentSpeed);
  }

  String getCurrentGameSpeed() {
    var retVal;
    if (currentSpeed == GameSpeed.SPEED_1X) {
      retVal = '1x';
    } else if (currentSpeed == GameSpeed.SPEED_2X) {
      retVal = '2x';
    } else if (currentSpeed == GameSpeed.SPEED_3X) {
      retVal = '3x';
    }
    return retVal;
  }

  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    setting.setupPlayingField(screenWidth, screenHeight);

    return Container(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Tetris',
            style: TextStyle(
                fontSize: 70.0,
                fontWeight: FontWeight.bold,
                color: Colors.red,
                shadows: [
                  Shadow(
                      color: Colors.black,
                      blurRadius: 8.0,
                      offset: Offset(2.0, 2.0))
                ]),
          ),
          MenuButton(onPlayClicked),
          ButtonTheme(
            height: 40,
            minWidth: 160,
            child: RaisedButton(
              onPressed: () => changeGameSpeed(),
              color: Colors.red,
              child: Text('Game Speed: ' + getCurrentGameSpeed()),
            ),
          ),
        ],
      ),
    );
  }
}
