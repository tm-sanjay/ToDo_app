import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/models/task_data.dart';
import 'package:todo_app/screens/welcome_screen.dart';
import 'package:todo_app/widgets/task_list.dart';
import 'package:provider/provider.dart';
import 'addTask_screen.dart';

class TasksScreen extends StatefulWidget {
  static const String id = 'TaskScreen';
  @override
  _TasksScreenState createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  final _auth = FirebaseAuth.instance;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlueAccent,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print('pressed');
          showModalBottomSheet(
            context: context,
            builder: (context) => AddTaskSheet(),
          );
        },
        child: Icon(
          Icons.add,
          size: 40.0,
        ),
        backgroundColor: Colors.lightBlue,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(
                top: 60.0, right: 10.0, left: 30.0, bottom: 30.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 30.0,
                      backgroundColor: Colors.white,
                      child: Icon(
                        Icons.list,
                        size: 30.0,
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      'ToDo',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold),
                    ),
                    //to get single value use provider.of
                    Text('${Provider.of<TaskData>(context).taskCount} Tasks',
                        style: TextStyle(fontSize: 18.0, color: Colors.white)),
                  ],
                ),
                IconButton(
                    onPressed: () {
                      _auth.signOut();
                      Navigator.pushNamed(context, WelcomeScreen.id);
                    },
                    icon: Icon(
                      Icons.logout,
                      color: Colors.white70,
                    ))
              ],
            ),
          ),
          Expanded(
            child: Container(
              height: 100,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30.0),
                      topRight: Radius.circular(30.0))),
              child: TaskListWidget(),
            ),
          )
        ],
      ),
    );
  }
}
