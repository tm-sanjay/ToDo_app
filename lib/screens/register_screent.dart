import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/constants.dart';
import 'package:todo_app/screens/tasks_screen.dart';
import 'package:todo_app/widgets/build_button.dart';

class RegistrationScreen extends StatefulWidget {
  static const String id = 'RegistrationScreen';
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _auth = FirebaseAuth.instance;

  String? name;
  String? email;
  String? password;
  String? reEnterdaPwd;

  TextEditingController confirmpassword = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    confirmpassword.dispose();
  }

  void signupUser() async {
    print(email);
    print(password);

    if ((email != null) || (password != null)) {
      try {
        final UserCredential? userCredential = await _auth
            .createUserWithEmailAndPassword(email: email!, password: password!);
        if (userCredential != null) {
          print(userCredential);
          Navigator.pushNamed(context, TasksScreen.id);
        }
      } catch (e) {
        print(e);
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
                  autofillHints: [AutofillHints.email],
                  keyboardType: TextInputType.emailAddress,
                  textAlign: TextAlign.center,
                  decoration: buildInputDecoration(
                      icons: Icons.email, hinttext: 'Email'),
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
                      return 'Please enter password';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 15,
                ),
                TextFormField(
                  controller: confirmpassword,
                  obscureText: true,
                  keyboardType: TextInputType.text,
                  textAlign: TextAlign.center,
                  decoration: buildInputDecoration(
                      icons: Icons.lock, hinttext: 'Confirm Password'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please re-enter password';
                    }
                    print(password);
                    print(value);
                    if (password != value) {
                      return "Password does not match";
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                Hero(
                  tag: 'signup',
                  child: BuildButton(
                      onPress: () {
                        if (_formKey.currentState!.validate()) {
                          print('successful');
                          ScaffoldMessenger.of(context)
                            ..removeCurrentSnackBar()
                            ..showSnackBar(
                                SnackBar(content: Text('Successful')));
                          signupUser();
                          return;
                        } else {
                          print('unsuccessful');
                        }
                      },
                      color: Colors.greenAccent,
                      title: 'Sign Up'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
