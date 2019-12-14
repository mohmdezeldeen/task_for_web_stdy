import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:task_for_web_stdy/models/auth_response.dart';

class ServiceApiProvider {
  static Future<dynamic> register(String name, String phone, String password,
      String passwordConfirm) async {
    var url = 'http://app.4-cars.sa/api/auth/signup';
    Map<String, String> headers = {
      "X-Requested-With": "XMLHttpRequest",
      "Accept": "application/json, text/plain, */*",
      "Content-Type": "application/x-www-form-urlencoded"
//      'Content-type' : 'application/json',
    };
    Map<String, String> body = {
      "name": name,
      "phone": phone,
      "password": password,
      "password_confirmation": passwordConfirm,
      "type": "1",
      "twitter_id": ""
    };
    return await http
        .post(Uri.encodeFull(url), body: body, headers: headers)
        .then((http.Response response) {
      print(response.body);
      final int statusCode = response.statusCode;
      if (statusCode < 200 || statusCode > 400 || json == null) {
        print("Error while register: ${response.reasonPhrase}");
        return "Error while register: ${response.reasonPhrase}";
        //        throw new Exception("Error while register ");
      }
      return AuthResponse.fromJson(json.decode(response.body));
    });
  }

  static Future<dynamic> login(String phone, String password) async {
    var url = 'http://app.4-cars.sa/api/auth/login';
    Map<String, String> headers = {
      "X-Requested-With": "XMLHttpRequest",
      "Accept": "application/json, text/plain, */*",
//      'Content-type' : 'application/json',
    };
    Map<String, String> body = {
      "phone": phone,
      "password": password,
      "type": "1",
      "facebook_id": ""
    };
    return await http
        .post(Uri.encodeFull(url), body: body, headers: headers)
        .then((http.Response response) {
      print(response.body);
      final int statusCode = response.statusCode;
      if (statusCode < 200 || statusCode > 400 || json == null) {
        print("Error while login: ${response.reasonPhrase}");
        return "Error while login: ${response.reasonPhrase}";
//        throw new Exception("Error while login ");
      }
      return AuthResponse.fromJson(json.decode(response.body));
    });
  }


  static Future<dynamic> logout() async {
    var url = 'http://app.4-cars.sa/api/auth/logout';
    Map<String, String> headers = {
      "X-Requested-With": "XMLHttpRequest",
      "Accept": "application/json, text/plain, */*",
//      'Content-type' : 'application/json',
    };
    Map<String, String> body = {
      "type": "1",
      "facebook_id": ""
    };
    return await http
        .post(Uri.encodeFull(url),  body: body,headers: headers)
        .then((http.Response response) {
      print(response.body);
      final int statusCode = response.statusCode;
      if (statusCode < 200 || statusCode > 400 || json == null) {
        print("Error while logout: ${response.reasonPhrase}");
        return "Error while logout: ${response.reasonPhrase}";
//        throw new Exception("Error while logout :${response.reasonPhrase}");
      }
      return json.decode(response.body);
    });
  }
}
