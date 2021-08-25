import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/models/task_data.dart';

// ignore: todo
//TODO proper border for Bottom Sheet

class AddTaskSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String? newTaskTitle;
    return Container(
      color: Color(0xff757575),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30.0),
                topRight: Radius.circular(30.0))),
        padding: EdgeInsets.all(15.0),
        child: Column(
          children: [
            Text(
              'Add Task',
              style: TextStyle(
                  fontSize: 30.0,
                  fontWeight: FontWeight.w500,
                  color: Colors.lightBlueAccent),
            ),
            TextField(
              autofocus: true,
              textAlign: TextAlign.center,
              decoration: InputDecoration(hintText: 'Enter your task'),
              onChanged: (value) {
                newTaskTitle = value;
              },
            ),
            SizedBox(
              height: 10.0,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  primary: Colors.lightBlueAccent,
                  padding: EdgeInsets.symmetric(horizontal: 50)),
              onPressed: () {
                print(newTaskTitle);
                if (newTaskTitle != null) {
                  Provider.of<TaskData>(context, listen: false)
                      .addNewTask(newTaskTitle!);
                  Navigator.pop(context);
                } else {
                  print('empty tast can\'t be added');
                }
              },
              child: Text(
                'Add',
                style: TextStyle(fontSize: 18.0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
