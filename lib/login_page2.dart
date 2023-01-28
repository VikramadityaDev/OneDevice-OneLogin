import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:unique_identifier/unique_identifier.dart';

import 'homepage.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  late String _email, _password;
  late String _deviceId;

  @override
  void initState() {
    super.initState();
    _getDeviceId();
  }

  void _getDeviceId() async {
    _deviceId = (await UniqueIdentifier.serial)!;
  }

  Future<void> _login() async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
        email: _email,
        password: _password,
      );
      User? user = result.user;

      // Check if the device has already been used to login
      var snapshot = await _db
          .collection('users')
          .doc(user!.uid)
          .collection('devices')
          .where('deviceId', isEqualTo: _deviceId)
          .get();

      // ignore: prefer_is_empty
      if (snapshot.docs.length > 0) {
        // Device already used, login successful
        // ignore: use_build_context_synchronously
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const HomePage()));
      } else {
        // Device not used, add it to the list of devices
        _db
            .collection('users')
            .doc(user.uid)
            .collection('devices')
            .add({'deviceId': _deviceId});
        // ignore: use_build_context_synchronously
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const HomePage()));
      }
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.only(top: 30),
        child: Column(
          children: <Widget>[
            TextField(
              onChanged: (value) => _email = value,
              decoration: const InputDecoration(hintText: 'Email'),
            ),
            TextField(
              onChanged: (value) => _password = value,
              decoration: const InputDecoration(hintText: 'Password'),
            ),
            ElevatedButton(
              onPressed: _login,
              child: const Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
