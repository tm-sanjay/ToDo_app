import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/models/store_data.dart';
import 'package:todo_app/models/task_data.dart';
import 'package:todo_app/screens/login_screen.dart';
import 'package:todo_app/screens/register_screent.dart';
import 'package:todo_app/screens/tasks_screen.dart';
import 'package:todo_app/screens/welcome_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); //importent
  await Firebase.initializeApp();
  await StoreData.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => TaskData(),
      child: MaterialApp(
        //check if user has loggedin or not
        initialRoute: FirebaseAuth.instance.currentUser == null
            ? WelcomeScreen.id
            : TasksScreen.id,
        routes: {
          WelcomeScreen.id: (context) => WelcomeScreen(),
          LoginScreen.id: (context) => LoginScreen(),
          TasksScreen.id: (context) => TasksScreen(),
          RegistrationScreen.id: (context) => RegistrationScreen()
        },
      ),
    );
  }
}
