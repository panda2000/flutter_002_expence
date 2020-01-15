import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class AdaptiveFlatButton extends StatelessWidget {
  final String text;
  final _handler;


  AdaptiveFlatButton(this.text, this._handler);

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
      ? CupertinoButton (
          child: Text (
            text,
            style: TextStyle(fontWeight: FontWeight.bold,)
          ),
          onPressed: _handler,
        )
      : FlatButton(
          textColor: Theme.of(context).primaryColor,
          child: Text (
            text,
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          onPressed: _handler,
    )
      ;
  }
}
