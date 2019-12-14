import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:task_for_web_stdy/models/auth_response.dart';
import 'package:task_for_web_stdy/utils/common_utils.dart';
import 'package:task_for_web_stdy/utils/dialogs.dart';
import 'package:task_for_web_stdy/utils/service_api_provider.dart';

class HomeScreen extends StatefulWidget {
  AuthResponse _authResponse;
  HomeScreen(this._authResponse);

  @override
  _HomeScreenState createState() => _HomeScreenState(_authResponse);
}

class _HomeScreenState extends State<HomeScreen> {
  AuthResponse _authResponse;
  _HomeScreenState(this._authResponse);

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _showLoadingIndicator = false;
  Dialogs _dialogs = Dialogs();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(title: Text('Home'), centerTitle: true),
      body: Center(
        child: Column(
          children: <Widget>[
            Text('Login Suceeded with id = ${_authResponse.id}'),
            _buildLogoutButton(context),
          ],
        ),
      ),
    );
  }

  Container _buildLogoutButton(BuildContext context) {
    return Container(
      alignment: Alignment.bottomCenter,
      child: RaisedButton(
        child: Text('Logout'),
        onPressed: () {
          checkInternetConnection();
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
        _callLogout();
      } else {
        setState(() {
          _showLoadingIndicator = false;
        });
        _showSnackBar('No Internet Connection Available');
      }
    });
  }

  _callLogout() {
    print("callLogout");

    ServiceApiProvider.logout().then((response) {
      setState(() {
        _showLoadingIndicator = false;
      });
      if (response != null && !response.toString().contains('Error')) {
        print("Logout Suceeded");
        AuthResponse registerResponse = response;
        _showSnackBar('Register Suceeded with id = ${registerResponse?.id}');
        Navigator.pushReplacementNamed(context, "/welcome");
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
