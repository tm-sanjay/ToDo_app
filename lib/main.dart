import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/models/store_data.dart';
import 'package:todo_app/models/task_data.dart';
import 'package:todo_app/screens/tasks_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); //importent
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
        home: TasksScreen(),
      ),
    );
  }
}
