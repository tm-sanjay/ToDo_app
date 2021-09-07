import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/constants.dart';
import 'package:todo_app/screens/tasks_screen.dart';
import 'package:todo_app/widgets/build_button.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'LoginScreen';
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = FirebaseAuth.instance;

  String? name;
  String? email;
  String? password;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void loginUser() async {
    print(email);
    print(password);

    if ((email != null) || (password != null)) {
      try {
        final UserCredential? userCredential = await _auth
            .signInWithEmailAndPassword(email: email!, password: password!);
        if (userCredential != null) {
          print(userCredential);
          Navigator.pushNamed(context, TasksScreen.id);
        }
      } on FirebaseAuthException catch (e) {
        String error;
        if (e.code == 'wrong-password') {
          print('wrong password');
          error = 'Wrong Password';
        } else if (e.code == 'user-not-found') {
          print('user not found');
          error = 'User not found';
        } else {
          print('Error logging In');
          error = 'Error logging In';
        }
        ScaffoldMessenger.of(context)
          ..removeCurrentSnackBar()
          ..showSnackBar(SnackBar(content: Text(error)));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(22.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Hero(
                  tag: 'logo',
                  child: Container(
                    child: Image.asset('assets/todo_logo.png'),
                    height: 100,
                  ),
                ),
                SizedBox(
                  height: 22,
                ),
                TextFormField(
                  onChanged: (value) {
                    email = value;
                  },
                  keyboardType: TextInputType.emailAddress,
                  textAlign: TextAlign.center,
                  decoration: buildInputDecoration(
                      icons: Icons.mail, hinttext: 'Email'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter Email';
                    }
                    print('email $email');
                    if (!RegExp('^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]')
                        .hasMatch(value)) {
                      return 'Please a valid Email';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 15,
                ),
                TextFormField(
                  onChanged: (value) {
                    password = value;
                  },
                  keyboardType: TextInputType.visiblePassword,
                  textAlign: TextAlign.center,
                  obscureText: true,
                  decoration: buildInputDecoration(
                      icons: Icons.lock, hinttext: 'Password'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter Password';
                    }
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                Hero(
                  tag: 'login',
                  child: BuildButton(
                      onPress: () {
                        if (_formKey.currentState!.validate()) {
                          print('Form success');
                          loginUser();
                        } else {
                          print('Form failed');
                        }
                      },
                      color: Colors.lightBlueAccent,
                      title: 'Log in'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
