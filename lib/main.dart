
import 'package:ourprojecttest/Data/DatabaseHelper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:ourprojecttest/Screens/LoginPage.dart';
import 'package:ourprojecttest/Screens/RegistrationPage.dart';

import 'Screens/MyHomePage.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options:
  const FirebaseOptions(
       apiKey: "AIzaSyCfBMUkGzgmRUdPntGa2msyEQ0npS_DyX4",
       appId: "1:457179983533:android:38513d50e834f770df6024",
       messagingSenderId: "457179983533",
       projectId: "ourmobileproject-1ed6c"));

  final datatabaseRef=FirebaseDatabase.instance.reference();
  datatabaseRef.child('message').push().set({'proName':'123'});


  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
       //home: const MyHomePage(title: 'Register page',),
       home: const LoginPage(title: 'login page',),

    );
  }
}

