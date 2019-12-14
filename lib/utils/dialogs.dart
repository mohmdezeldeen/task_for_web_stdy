import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Dialogs {
  infoDialog(BuildContext context, String title, String content) {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return AlertDialog(
            title: Text(title),
            content: Text(content),
            actions: <Widget>[
              FlatButton(
                onPressed: () => Navigator.pop(context),
                child: Text('Ok'),
              )
            ],
          );
        });
  }

  errorDialog(BuildContext context, String errorMessage) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text(errorMessage),
            actions: <Widget>[
              FlatButton(
                onPressed: () => Navigator.pop(context),
                child: Text('Close'),
              ),
              FlatButton(
                onPressed: () {
                  Clipboard.setData(
                      ClipboardData(text: 'Error Message: \n$errorMessage'));
                  Navigator.pop(context);
                  Fluttertoast.showToast(
                      msg: 'Error message copied',
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIos: 1);
                },
                child: Text('Copy Error'),
              )
            ],
          );
        });
  }
}
