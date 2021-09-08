import 'package:flutter/material.dart';
import 'package:todo_app/screens/login_screen.dart';
import 'package:todo_app/screens/register_screent.dart';
import 'package:todo_app/widgets/build_button.dart';

class WelcomeScreen extends StatefulWidget {
  static const String id = 'WelcomeScreen';
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Hero(
              tag: 'logo',
              child: Container(
                child: Image.asset('assets/todo_logo.png'),
                height: 100,
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Hero(
              tag: 'login',
              child: BuildButton(
                  onPress: () {
                    Navigator.pushNamed(context, LoginScreen.id);
                  },
                  color: Colors.lightBlueAccent,
                  title: 'Log In'),
            ),
            SizedBox(
              height: 8.0,
            ),
            Hero(
              tag: 'signup',
              child: BuildButton(
                  onPress: () {
                    Navigator.pushNamed(context, RegistrationScreen.id);
                  },
                  color: Colors.greenAccent,
                  title: 'Sign Up'),
            )
          ],
        ),
      )),
    );
  }
}
