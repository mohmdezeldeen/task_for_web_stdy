import 'package:flutter/material.dart';
import 'package:task_for_web_stdy/utils/common_utils.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Welcome'), centerTitle: true),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            '4 Cars App',
            style: TextStyle(fontSize: 32.0),
          ),
          SizedBox(
            height: 25.0,
          ),
          _buildRegisterButton(context),
          _buildLoginButton(context),
        ],
      ),
    );
  }
}

Container _buildRegisterButton(BuildContext context) {
  return Container(
    alignment: Alignment.bottomCenter,
    child: RaisedButton(
      child: Text('Register'),
      onPressed: () {
        Navigator.pushNamed(context, "/register");
      },
      color: Colors.deepOrange,
      textColor: Colors.white,
      padding: EdgeInsets.fromLTRB(0, 12, 0, 12),
      splashColor: Colors.grey,
      shape: getCommonButtonShape(),
    ),
  );
}

Container _buildLoginButton(BuildContext context) {
  return Container(
    alignment: Alignment.bottomCenter,
    child: RaisedButton(
      child: Text('Login'),
      onPressed: () {
        Navigator.pushNamed(context, "/login");
      },
      color: Colors.deepOrange,
      textColor: Colors.white,
      padding: EdgeInsets.fromLTRB(0, 12, 0, 12),
      splashColor: Colors.grey,
      shape: getCommonButtonShape(),
    ),
  );
}
