import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import 'package:chat_app/global/environment.dart';
import 'package:chat_app/models/login_response.dart';
import 'package:chat_app/models/user.dart';

final urls = {
  'login': '${Environment.baseApiUrl}/login',
  'signup': '${Environment.baseApiUrl}/login/create_user',
  'renew_token': '${Environment.baseApiUrl}/login/renew_token',
};

enum AuthState { authenticated, unauthenticated, authenticationError }

class AuthService with ChangeNotifier {
  late User user;
  bool _isAuthenticating = false;

  AuthState _authState = AuthState.unauthenticated;

  final _secureStorage = const FlutterSecureStorage();

  bool get isAuthenticating => _isAuthenticating;

  set isAuthenticating(bool value) {
    _isAuthenticating = value;
    notifyListeners();
  }

  AuthState get authState => _authState;

  set authState(AuthState state) {
    _authState = state;
    notifyListeners();
  }

  // Token static getters and setters
  static Future<String?> getToken() async {
    const secureStorage = FlutterSecureStorage();
    final token = await secureStorage.read(key: 'token');
    return token;
  }

  Future<bool> login(String email, String password) async {
    isAuthenticating = true;

    final data = {
      "email": email,
      "password": password,
    };

    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode(data);

    try {
      final resp = await http.post(Uri.parse(urls['login']!),
          headers: headers, body: body);

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
      isAuthenticating = false;
      throw Error.safeToString(exception);
    }
  }

  Future<dynamic> signup(String name, String email, String password) async {
    isAuthenticating = true;
    final data = {
      "name": name,
      "email": email,
      "password": password,
    };

    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode(data);

    try {
      final resp = await http.post(Uri.parse(urls['signup']!),
          headers: headers, body: body);

      isAuthenticating = false;
      await Future.delayed(const Duration(seconds: 1));
      if (resp.statusCode == 200) {
        final response = LoginResponse.fromJson(jsonDecode(resp.body));
        user = response.user;

        await _saveToken(response.token);

        return true;
      } else {
        final respBody = jsonDecode(resp.body);
        return respBody['msg'];
      }
    } catch (exception) {
      isAuthenticating = false;
      throw Error.safeToString(exception);
    }
  }

  Future<dynamic> isLoggedIn() async {
    final token = await _secureStorage.read(key: 'token');
    if (token == null) {
      return false;
    }

    try {
      final headers = {'Content-Type': 'application/json', 'X-Token': token};

      final resp = await http.get(
        Uri.parse(urls['renew_token']!),
        headers: headers,
      );

      isAuthenticating = false;
      await Future.delayed(const Duration(seconds: 1));

      if (resp.statusCode == 200) {
        final response = LoginResponse.fromJson(jsonDecode(resp.body));
        user = response.user;

        await _saveToken(response.token);

        // Delayed to show the loading animation
        await Future.delayed(const Duration(seconds: 2));

        return true;
      } else {
        await logout();
        return false;
      }
    } catch (exception) {
      isAuthenticating = false;
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
