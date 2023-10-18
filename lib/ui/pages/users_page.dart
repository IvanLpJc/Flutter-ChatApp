import 'package:flutter/material.dart';

class UsersPage extends StatelessWidget {
  static const String route = 'users_page';
  const UsersPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('UsersPage'),
      ),
    );
  }
}
