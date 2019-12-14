import 'package:flutter/material.dart';
import 'package:task_for_web_stdy/models/auth_response.dart';
import 'package:task_for_web_stdy/ui/home_screen.dart';
import 'package:task_for_web_stdy/ui/login_screen.dart';
import 'package:task_for_web_stdy/ui/register_screen.dart';
import 'package:task_for_web_stdy/ui/welcome_screen.dart';
import 'package:task_for_web_stdy/utils/shared_preferences_utils.dart';

var routes = <String, WidgetBuilder>{
  '/welcome': (context) => WelcomeScreen(),
  '/login': (context) => LoginScreen(),
  '/register': (context) => RegisterScreen(),
  '/home': (context) => HomeScreen(new AuthResponse())
};
void main() {
  var pushScreenRoot = '/welcome';
  var userId;
  UtilsSharedPreferences.getIntPref(UtilsSharedPreferences.SP_USER_ID)
      .then((onValue) {
    userId = onValue;
    UtilsSharedPreferences.getBoolPref(UtilsSharedPreferences.SP_IS_LOGIN)
        .then((onValue) {
      if (onValue != null && onValue == true) pushScreenRoot = '/home';
      runApp(MyApp(userId, pushScreenRoot));
    });
  });
}

class MyApp extends StatelessWidget {
  int _userId;
  String _pushScreenRoot;
  MyApp(this._userId, this._pushScreenRoot);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: _pushScreenRoot == '/home'
          ? HomeScreen(new AuthResponse(id: _userId))
          : WelcomeScreen(),
      routes: routes,
    );
  }
}
