import 'package:ourprojecttest/Data/DatabaseHelper.dart';
import 'package:flutter/material.dart';
import 'package:ourprojecttest/Data/DatabaseHelper.dart';
import 'package:crypto/crypto.dart';
import 'package:ourprojecttest/Data/DatabaseHelper.dart';
import 'package:ourprojecttest/main.dart';
import 'dart:convert';

import 'MyHomePage.dart';
import 'RegistrationPage.dart'; // For utf8.encode

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key, required String title}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: <Widget>[
            TextFormField(
              controller: _usernameController,
              decoration: const InputDecoration(
                labelText: 'Username',
                icon: Icon(Icons.person),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter username';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Password',
                icon: Icon(Icons.lock),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter password';
                }
                return null;

              },
            ),
            ElevatedButton(
              onPressed: _login,
              child: const Text('Login'),

            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const RegisterPage(title: 'Register Page',)),
                );
              },
              child: const Text('Don\'t have an account? Register here'),
            ),
          ],
        ),
      ),
    );
  }

  void _login() async {


    if (_formKey.currentState!.validate()) {
      final hashedPassword = sha256.convert(utf8.encode(_passwordController.text)).toString();

      bool loginSuccess = await DatabaseHelper.authenticateUser(
        _usernameController.text.toLowerCase(),
        hashedPassword,
      );

      if (loginSuccess) {
        // ignore: use_build_context_synchronously
        Navigator.pushReplacement(
          context,
            MaterialPageRoute(builder: (context) => const MyHomePage(title: 'MyHome Page ')),
        );
      }

      else {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Invalid username or password')),
        );

      }
    }

    
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}

class MyPage {
  const MyPage({required String title});
}
