import 'package:flutter/material.dart';
import 'package:tetris/settings.dart';
import 'game.dart';
import 'menu.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tetris',
      home: Home(),
    );
  }
}

class Home extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Main Menu'),
        centerTitle: true,
      ),
      backgroundColor: Colors.green,
      body: Menu(),
    );
  }
}

class GameScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var setting = Setting();
    return Scaffold(
      appBar: AppBar(
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back),
          onPressed: () async {
            setting.timer.cancel();
            Navigator.pop(context);
          },
        ),
        title: Text('Play'),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      body: Game(),
    );
  }
}
