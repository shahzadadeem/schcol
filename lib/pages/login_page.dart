import 'package:flutter/material.dart';
import 'package:schcol/services/auth_service.dart';
import 'package:status_alert/status_alert.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _loginFormKey = GlobalKey();

  String? username, password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _heading(),
            _loginForm(),
            _loginButton(),
          ],
        ),
      ),
    );
  }

  Widget _heading() {
    return const Text(
      'Eat Healthy',
      style: TextStyle(
        fontSize: 35,
        fontWeight: FontWeight.bold,
      ),
    );
  } //End Heading

  Widget _loginForm() {
    return SizedBox(
      height: MediaQuery.sizeOf(context).height * 0.3,
      width: MediaQuery.sizeOf(context).width,
      child: Form(
        key: _loginFormKey,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextFormField(
              initialValue: "kminchelle",
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Enter Username";
                }
              },
              onSaved: (value) {
                setState(() {
                  username = value;
                });
              },
              decoration: const InputDecoration(hintText: 'Username'),
            ),
            TextFormField(
              initialValue: "0lelplR",
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Enter Password";
                }
                if (value.length < 5) {
                  return "Enter Longer Password";
                }
              },
              onSaved: (value) {
                setState(() {
                  password = value;
                });
              },
              obscureText: true,
              decoration: const InputDecoration(hintText: 'Password'),
            ),
            // TextFormField()
          ],
        ),
      ),
    );
  }

  Widget _loginButton() {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width * 0.5,
      child: ElevatedButton(
        onPressed: () async {
          if (_loginFormKey.currentState?.validate() ?? false) {
            _loginFormKey.currentState?.save();
            bool result = await AuthService().login(username!, password!);
            if (result) {
              StatusAlert.show(context,
                  title: "Login Success",
                  // subtitle: "Please try again.",
                  duration: const Duration(seconds: 2),
                  maxWidth: MediaQuery.sizeOf(context).width / 1.4,
                  configuration: const IconConfiguration(
                      icon: Icons.error, color: Colors.green));
              Navigator.pushReplacementNamed(context, "/home");
            } else {
              StatusAlert.show(context,
                  title: "Login Failed",
                  subtitle: "Please try again.",
                  duration: const Duration(seconds: 2),
                  maxWidth: MediaQuery.sizeOf(context).width / 1.4,
                  configuration: const IconConfiguration(
                      icon: Icons.error, color: Colors.red));
            }
          }
        },
        child: const Text('Login'),
      ),
    );
  }
}
