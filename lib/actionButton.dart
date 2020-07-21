import 'package:flutter/material.dart';
import 'settings.dart';

class ActionButton extends StatelessWidget{
  Function onClickFunction;
  Icon buttonIcon;
  LastButtonPressed nextAction;
  ActionButton(this.onClickFunction, this.buttonIcon, this.nextAction);

  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
      child: Padding(
        padding: EdgeInsets.all(5),
        child: RaisedButton(
          onPressed: () {
            onClickFunction(nextAction);
          },
          color: Colors.red,
          child: buttonIcon,
        ),
      ),
    );
  }
}