import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import 'package:chat_app/global/environment.dart';
import 'package:chat_app/models/login_response.dart';
import 'package:chat_app/models/user.dart';

class AuthService with ChangeNotifier {
  late User user;
  bool _isAuthenticating = false;

  final _secureStorage = const FlutterSecureStorage();

  bool get isAuthenticating => _isAuthenticating;

  set isAuthenticating(bool value) {
    _isAuthenticating = value;
    notifyListeners();
  }

  // Token static getters and setters
  static Future<String?> getToken() async {
    const secureStorage = FlutterSecureStorage();
    final token = await secureStorage.read(key: 'token');
    return token;
  }

  static Future<void> removeToken() async {
    const secureStorage = FlutterSecureStorage();
    await secureStorage.delete(key: 'token');
  }

  Future<bool> login(String email, String password) async {
    isAuthenticating = true;
    final data = {
      "email": email,
      "password": password,
    };

    final url = '${Environment.baseApiUrl}/login';
    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode(data);

    try {
      final resp =
          await http.post(Uri.parse(url), headers: headers, body: body);
      isAuthenticating = false;
      if (resp.statusCode == 200) {
        final loginResponse = LoginResponse.fromJson(jsonDecode(resp.body));
        user = loginResponse.user;

        await _saveToken(loginResponse.token);

        return true;
      } else {
        return false;
      }
    } catch (exception) {
      throw Error.safeToString(exception);
    }
  }

  Future _saveToken(String token) async {
    return await _secureStorage.write(key: 'token', value: token);
  }

  Future logout() async {
    await _secureStorage.delete(key: 'token');
  }
}
