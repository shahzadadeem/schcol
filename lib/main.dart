import 'package:flutter/material.dart';
import 'package:schcol/pages/home_page.dart';
import 'package:schcol/pages/login_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      color: Colors.blue.shade50,
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange.shade900),
          useMaterial3: true,
          appBarTheme: const AppBarTheme(
              elevation: 10,
              centerTitle: true,
              titleTextStyle: TextStyle(
                fontSize: 25,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ))),
      home: const Scaffold(body: LoginPage()),
      initialRoute: "login",
      routes: {
        "/login": (context) => const LoginPage(),
        "/home": (context) => const HomePage(),
      },
    );
  }
}
