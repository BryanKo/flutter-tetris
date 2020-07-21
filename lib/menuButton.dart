import 'package:flutter/material.dart';
import 'package:flutter/material.dart';

class MenuButton extends StatelessWidget {
  Function onClickFunction;
  MenuButton(this.onClickFunction);
  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
      height: 60,
      minWidth: 200,
      child: RaisedButton(
        onPressed: () {
          onClickFunction();
        },
        color: Colors.red,
        child: Icon(Icons.play_arrow),
      ),
    );
  }
}