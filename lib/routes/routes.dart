import 'package:flutter/material.dart';
import 'package:taichat/ui/pages/pages.dart';

const initialRoute = LoginPage.route;

final Map<String, Widget Function(BuildContext)> appRoutes = {
  UsersPage.route: (_) => const UsersPage(),
  LoginPage.route: (_) => const LoginPage(),
  LoadingPage.route: (_) => const LoadingPage(),
  ChatPage.route: (_) => const ChatPage(),
  SignUpPage.route: (_) => const SignUpPage(),
};