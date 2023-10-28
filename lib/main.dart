import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:chat_app/routes/routes.dart';
import 'package:chat_app/services/auth_service.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthService()),
      ],
      child: MaterialApp(
        title: 'Chat App',
        debugShowCheckedModeBanner: false,
        initialRoute: initialRoute,
        routes: appRoutes,
      ),
    );
  }
}
