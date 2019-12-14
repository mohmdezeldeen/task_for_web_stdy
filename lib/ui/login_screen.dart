import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:task_for_web_stdy/models/auth_response.dart';
import 'package:task_for_web_stdy/ui/home_screen.dart';
import 'package:task_for_web_stdy/utils/common_utils.dart';
import 'package:task_for_web_stdy/utils/dialogs.dart';
import 'package:task_for_web_stdy/utils/service_api_provider.dart';
import 'package:task_for_web_stdy/utils/shared_preferences_utils.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();

  TextEditingController _phoneController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  Dialogs _dialogs = Dialogs();
  FocusNode _myFocusNode = FocusNode();
  bool _showLoadingIndicator = false;
  bool _isObscure = true;
  Color _eyeButtonColor = Colors.grey;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(title: Text('Login'), centerTitle: true),
      body: Form(key: _formKey, child: _createLoginView(context)),
    );
  }

  Widget _createLoginView(BuildContext context) {
    if (_showLoadingIndicator)
      return buildLoadingDataIndicator('Check Login Info!');
    else
      return ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.fromLTRB(22.0, 0.0, 22.0, 22.0),
          children: <Widget>[
            _buildPhoneTextField(),
            SizedBox(height: 10.0),
            _buildPasswordTextField(),
            SizedBox(height: 20.0),
            _buildLoginExitButtons(context),
          ]);
  }

  TextFormField _buildPhoneTextField() {
    return TextFormField(
      controller: _phoneController,
      onSaved: (phone) {
        _phoneController.text = phone;
      },
      validator: (phone) {
        if (phone.isEmpty) {
          return 'Required Field';
        }
      },
      maxLines: 1,
      keyboardType: TextInputType.phone,
      decoration: InputDecoration(labelText: 'Phone'),
    );
  }

  TextFormField _buildPasswordTextField() {
    return TextFormField(
      controller: _passwordController,
      onSaved: (password) {
        _passwordController.text = password;
      },
      validator: (password) {
        if (password.isEmpty) {
          return 'Required Field';
        }
      },
      maxLines: 1,
      obscureText: _isObscure,
      decoration: InputDecoration(
          labelText: 'Password',
          suffixIcon: IconButton(
              icon: Icon(
                Icons.remove_red_eye,
                color: _eyeButtonColor,
              ),
              onPressed: () {
                if (_isObscure) {
                  setState(() {
                    _isObscure = false;
                    _eyeButtonColor = Theme.of(context).primaryColor;
                  });
                } else {
                  setState(() {
                    _isObscure = true;
                    _eyeButtonColor = Colors.grey;
                  });
                }
              })),
    );
  }

  Row _buildLoginExitButtons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Expanded(child: _buildExitButton(context), flex: 10),
        Expanded(child: SizedBox(width: 10.0), flex: 1),
        Expanded(child: _buildLoginButton(context), flex: 10),
      ],
    );
  }

  Container _buildLoginButton(BuildContext context) {
    return Container(
      child: RaisedButton(
        child: Text('Login'),
        onPressed: () {
          if (_formKey.currentState.validate()) {
            _formKey.currentState.save();
            checkInternetConnection();
          }
        },
        color: Colors.deepOrange,
        textColor: Colors.white,
        padding: EdgeInsets.fromLTRB(0, 12, 0, 12),
        splashColor: Colors.grey,
        shape: getCommonButtonShape(),
      ),
    );
  }

  Container _buildExitButton(BuildContext context) {
    return Container(
      child: RaisedButton(
        child: Text('Exit'),
        onPressed: () {
          print("Exit Pressed");
          exit(0);
        },
        color: Colors.deepOrange,
        textColor: Colors.white,
        padding: EdgeInsets.fromLTRB(0, 12, 0, 12),
        splashColor: Colors.grey,
        shape: getCommonButtonShape(),
      ),
    );
  }

  checkInternetConnection() {
    print("checkConnectivity");
    Connectivity().checkConnectivity().then((result) {
      if (result == ConnectivityResult.mobile ||
          result == ConnectivityResult.wifi) {
        setState(() {
          _showLoadingIndicator = true;
        });
        _callLogin();
      } else {
        setState(() {
          _showLoadingIndicator = false;
        });
        _showSnackBar('No Internet Connection Available');
      }
    });
  }

  _callLogin() {
    print("callRegister");
    String phone = _phoneController.text;
    String password = _passwordController.text;

    ServiceApiProvider.login(phone, password).then((response) async {
      setState(() {
        _showLoadingIndicator = false;
      });
      if (response != null && !response.toString().contains('Error')) {
        print("Login Suceeded");
        AuthResponse authResponse = response;
        await UtilsSharedPreferences.setBoolPref(
            UtilsSharedPreferences.SP_IS_LOGIN, true);
        await UtilsSharedPreferences.setIntPref(
            UtilsSharedPreferences.SP_USER_ID, authResponse.id);
        Navigator.pop(context);
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => HomeScreen(authResponse)));
      } else {
        print('ERROR: ${response}');
        _dialogs.errorDialog(context, '${response}');
      }
    });
  }

  _showSnackBar(String content) {
    print('showSnackBar');
    final snackBar = SnackBar(
      content: Text(content),
      action: SnackBarAction(
          label: 'Try Again',
          textColor: Colors.redAccent,
          onPressed: checkInternetConnection),
    );
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }
}
