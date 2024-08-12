import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
 import 'package:intl/intl.dart';

import 'package:ourprojecttest/Data/DatabaseHelper.dart';

import 'package:ourprojecttest/Data/User.dart';
import 'package:ourprojecttest/Screens/LoginPage.dart';
import 'package:ourprojecttest/Data/User.dart';


class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key,required this.title});


  final String title;

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();

  DatabaseReference mydb = FirebaseDatabase.instance.ref("User");

  String gender = "male";
  bool checkedValue = true;
  DateTime? pickedDate;
  int userAge = 0;

  final _dobController = TextEditingController();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _phoneController = TextEditingController();
  DateTime _dob = DateTime.now().subtract(const Duration(days: 365 * 18)); // Default to 18 years ago
  String _selectedGender = 'male';
  bool _agreeToTerms = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Register")),
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
            TextFormField(
              controller: _phoneController,
              decoration: const InputDecoration(
                labelText: 'Mobile Phone Number',
                icon: Icon(Icons.phone),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a phone number';
                } else if (value.length != 8) {
                  return 'Phone number must be 8 digits';
                } else if (!value.startsWith('9') && !value.startsWith('7')) {
                  return 'Phone number must start with 9 or 7';
                }
                return null;
              },
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  child: Text('Gender',
                      style:
                      TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                ),
                RadioListTile<String>(
                  title: const Text('Male'),
                  value: 'male',
                  groupValue: _selectedGender,
                  onChanged: (String? value) {
                    setState(() {
                      _selectedGender = value!;
                    });
                  },
                ),
                RadioListTile<String>(
                  title: const Text('Female'),
                  value: 'female',
                  groupValue: _selectedGender,
                  onChanged: (String? value) {
                    setState(() {
                      _selectedGender = value!;
                    });
                  },
                ),
              ],
            ),
            TextFormField(
              controller: _dobController,
              readOnly: true,
              decoration: const InputDecoration(
                labelText: 'Date of Birth',
                icon: Icon(Icons.calendar_today),
              ),
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: _dob,
                  firstDate: DateTime(1900),
                  lastDate: DateTime.now(),
                );
                if (pickedDate != null && pickedDate != _dob) {
                  setState(() {
                    _dob = pickedDate;
                    _dobController.text = DateFormat('yyyy-MM-dd').format(
                        pickedDate); // Format the date and set it to the controller
                  });
                }
              },
              validator: (value) {
                if (DateTime.now().difference(_dob).inDays / 365 < 18) {
                  return 'You must be at least 18 years old';
                }
                return null;
              },
            ),


            /*TextFormField(
                readOnly: true,
                decoration: const InputDecoration(
                  labelText: 'Date of Birth',
                  icon: Icon(Icons.calendar_today),
                ),
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: _dob,
                    firstDate: DateTime(1900),
                    lastDate: DateTime.now(),
                  );
                  if (pickedDate != null && pickedDate != _dob) {
                    setState(() {
                      _dob = pickedDate;
                    });
                  }
                },
                validator: (value) {
                  if (DateTime.now().difference(_dob).inDays / 365 < 18) {
                    return 'You must be at least 18 years old';
                  }
                  return null;
                },
              ),*/
            CheckboxListTile(
              title: const Text("I agree to the terms and conditions"),
              value: _agreeToTerms,
              onChanged: (bool? value) {
                setState(() {
                  _agreeToTerms = value!;
                });
              },
              controlAffinity: ListTileControlAffinity.leading,
            ),
             ElevatedButton(
              onPressed: _submitForm,
              child: const Text('Register'),
            ),

            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginPage(title: 'login page',)),
                );
              },
              child: const Text('Do you have an account? Login here'),
            ),


          ],
        ),
      ),
    );
  }

  void _submitForm() {
    if (_formKey.currentState!.validate() && _agreeToTerms) {
      final hashedPassword =
      sha256.convert(utf8.encode(_passwordController.text)).toString();
      final userData = UserData(
        username: _usernameController.text.toLowerCase(),
        password: hashedPassword,
        mobilePhoneNumber: _phoneController.text,
        gender: _selectedGender,
        dob: _dob,
        agreeToTerms: _agreeToTerms,
      );
      final user = User(userData: userData); // Generate user key as needed

      DatabaseHelper.createNewUserRecordIntoFirebase(user);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('New user record inserted successfully')),
      );
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder:(context)=> const LoginPage(title: 'Login Page')));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please complete the form correctly')),
      );
    }
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    _phoneController.dispose();
    _dobController.dispose();
    super.dispose();
  }
}





