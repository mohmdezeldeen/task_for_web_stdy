import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:task_for_web_stdy/models/auth_response.dart';
import 'package:task_for_web_stdy/utils/common_utils.dart';
import 'package:task_for_web_stdy/utils/dialogs.dart';
import 'package:task_for_web_stdy/utils/service_api_provider.dart';
import 'package:task_for_web_stdy/utils/shared_preferences_utils.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();

  TextEditingController _nameController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _passwordConfirmController = TextEditingController();

  Dialogs _dialogs = Dialogs();
  FocusNode _myFocusNode = FocusNode();
  bool _showLoadingIndicator = false;
  bool _isObscurePass = true;
  bool _isObscurePassConfirm = true;
  Color _eyeButtonColorPass = Colors.grey;
  Color _eyeButtonColorPassConfirm = Colors.grey;

  @override
  void dispose() {
    _myFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(title: Text('Register'), centerTitle: true),
      body: Form(key: _formKey, child: _createRegisterView(context)),
    );
  }

  Widget _createRegisterView(BuildContext context) {
    if (_showLoadingIndicator)
      return buildLoadingDataIndicator('Check Login Info!');
    else
      return ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.fromLTRB(22.0, 0.0, 22.0, 22.0),
          children: <Widget>[
            _buildNameTextField(),
            SizedBox(height: 10.0),
            _buildPhoneTextField(),
            SizedBox(height: 10.0),
            _buildPasswordTextField(),
            SizedBox(height: 10.0),
            _buildPasswordConfirmTextField(),
            SizedBox(height: 20.0),
            _buildRegisterExitButtons(context),
          ]);
  }

  TextFormField _buildNameTextField() {
    return TextFormField(
      controller: _nameController,
      onSaved: (name) {
        _nameController.text = name;
      },
      validator: (name) {
        if (name.isEmpty) {
          return 'Required Field';
        }
      },
      maxLines: 1,
      decoration: InputDecoration(labelText: 'Name'),
    );
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
      obscureText: _isObscurePass,
      decoration: InputDecoration(
          labelText: 'Password',
          suffixIcon: IconButton(
              icon: Icon(
                Icons.remove_red_eye,
                color: _eyeButtonColorPass,
              ),
              onPressed: () {
                if (_isObscurePass) {
                  setState(() {
                    _isObscurePass = false;
                    _eyeButtonColorPass = Theme.of(context).primaryColor;
                  });
                } else {
                  setState(() {
                    _isObscurePass = true;
                    _eyeButtonColorPass = Colors.grey;
                  });
                }
              })),
    );
  }

  TextFormField _buildPasswordConfirmTextField() {
    return TextFormField(
      controller: _passwordConfirmController,
      onSaved: (password) {
        _passwordConfirmController.text = password;
      },
      validator: (password) {
        if (password.isEmpty) {
          return 'Required Field';
        }
      },
      maxLines: 1,
      obscureText: _isObscurePassConfirm,
      decoration: InputDecoration(
          labelText: 'Password Confirmation',
          suffixIcon: IconButton(
              icon: Icon(
                Icons.remove_red_eye,
                color: _eyeButtonColorPassConfirm,
              ),
              onPressed: () {
                if (_isObscurePassConfirm) {
                  setState(() {
                    _isObscurePassConfirm = false;
                    _eyeButtonColorPassConfirm = Theme.of(context).primaryColor;
                  });
                } else {
                  setState(() {
                    _isObscurePassConfirm = true;
                    _eyeButtonColorPassConfirm = Colors.grey;
                  });
                }
              })),
    );
  }

  Row _buildRegisterExitButtons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Expanded(child: buildExitButton(context), flex: 10),
        Expanded(child: SizedBox(width: 10.0), flex: 1),
        Expanded(child: buildRegisterButton(context), flex: 10),
      ],
    );
  }

  Container buildRegisterButton(BuildContext context) {
    return Container(
      child: RaisedButton(
        child: Text('Register'),
        onPressed: () {
          if (_formKey.currentState.validate()) {
            _formKey.currentState.save();
//            _checkIsPaswordsMatch();
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

//  _checkIsPaswordsMatch(){
//    var password = _passwordController.text;
//    var passwordConfirm = _passwordConfirmController.text;
//    if(password.isNotEmpty && passwordConfirm.isNotEmpty && password != passwordConfirm)
//
//  }

  Container buildExitButton(BuildContext context) {
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
        _callRegister();
      } else {
        setState(() {
          _showLoadingIndicator = false;
        });
        _showSnackBar('No Internet Connection Available');
      }
    });
  }

  _callRegister() {
    print("callRegister");
    String name = _nameController.text;
    String phone = _phoneController.text;
    String password = _passwordController.text;
    String passwordConfirm = _passwordConfirmController.text;

    ServiceApiProvider.register(name, phone, password, passwordConfirm)
        .then((response) async {
      setState(() {
        _showLoadingIndicator = false;
      });
      if (response != null && !response.toString().contains('Error')) {
        print("Register Suceeded");
        AuthResponse registerResponse = response;
        await UtilsSharedPreferences.setIntPref(
            UtilsSharedPreferences.SP_USER_ID, registerResponse.id);
        _showSnackBar('Register Suceeded with id = ${registerResponse.id}');
        Navigator.pushReplacementNamed(context, 'login');
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
