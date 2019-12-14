import 'package:flutter/material.dart';

Text getCommonTextStyledOfContext(BuildContext context, String text) {
  return Text(text, style: Theme.of(context).primaryTextTheme.button);
}

ShapeBorder getCommonButtonShape() {
  return RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0));
}

Column buildLoadingDataIndicator(String text) {
  return Column(children: <Widget>[
    Center(
        child: Container(
            padding: EdgeInsetsDirectional.only(top: 150.0),
            alignment: Alignment.center,
            child: CircularProgressIndicator())),
    SizedBox(height: 25.0),
    Text(text)
  ]);
}

showSnackBar(var scaffoldKey, String content, [SnackBarBehavior behavior]) {
  print('showSnackBar');
  final snackBar = SnackBar(
    content: Text(content),
    behavior: behavior ?? SnackBarBehavior.fixed,
  );
  if (scaffoldKey.currentState != null)
    scaffoldKey.currentState.showSnackBar(snackBar);
}

showSnackBarByContext(BuildContext context, String content,
    [SnackBarBehavior behavior]) {
  print('showSnackBar');
  final snackBar = SnackBar(
    content: Text(content),
    behavior: behavior ?? SnackBarBehavior.fixed,
  );
  Scaffold.of(context).showSnackBar(snackBar);
}
