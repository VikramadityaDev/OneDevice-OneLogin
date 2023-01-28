// import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:unique_identifier/unique_identifier.dart';

// import 'homepage.dart';
import 'login_page2.dart';

void main() async {
   WidgetsFlutterBinding.ensureInitialized();
   await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginPage(),
    );
  }
}

// class LoginScreen extends StatefulWidget {
//   @override
//   _LoginScreenState createState() => _LoginScreenState();
// }

// class _LoginScreenState extends State<LoginScreen> {
//   final _formKey = GlobalKey<FormState>();
//   late String _email;
//   late String _password;
//   bool _isLoading = false;
//   final FirebaseAuth _auth = FirebaseAuth.instance;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(),
//       body: _isLoading
//           ? const Center(child: CircularProgressIndicator())
//           : Form(
//               key: _formKey,
//               child: Column(
//                 children: <Widget>[
//                   TextFormField(
//                     decoration: const InputDecoration(labelText: 'Email'),
//                     validator: (value) {
//                       if (value!.isEmpty) {
//                         return 'Please enter your email';
//                       }
//                       return null;
//                     },
//                     onSaved: (value) => _email = value!,
//                   ),
//                   TextFormField(
//                     decoration: const InputDecoration(labelText: 'Password'),
//                     validator: (value) {
//                       if (value!.isEmpty) {
//                         return 'Please enter your password';
//                       }
//                       return null;
//                     },
//                     onSaved: (value) => _password = value!,
//                   ),
//                   ElevatedButton(
//                     onPressed: _submit,
//                     child: const Text('LOGIN'),
//                   ),
//                 ],
//               ),
//             ),
//     );
//   }

//   Future<void> _submit() async {
//     if (_formKey.currentState!.validate()) {
//       _formKey.currentState!.save();
//       setState(() {
//         _isLoading = true;
//       });
//       final response = await _auth.signInWithEmailAndPassword(
//         email: _email,
//         password: _password
//       );
//       _handleServerResponse(response);
//     }
//   }

//   Future<void> _handleServerResponse(UserCredential response) async {
//     setState(() {
//       _isLoading = false;
//     });
//     if (response.user != null) {
//       // login success
//       final prefs = await SharedPreferences.getInstance();
//       final deviceId = await _getDeviceId();
//       prefs.setString('deviceId', deviceId);
//       // ignore: use_build_context_synchronously
//       Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomePage()));
//     } else {
//       // login failed
//       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
//         content: Text('Login failed'),
//       ));
//     }
//   }

//   Future<String> _getDeviceId() async {
//     String deviceId;
//     try {
//       deviceId = (await UniqueIdentifier.serial)!;
//     return deviceId;
//     } catch (e) {
//     print(e);
//     rethrow;
//     }
//   }
// }