import 'package:flutter/material.dart';

class TaskTile extends StatelessWidget {
  TaskTile(
      {required this.task,
      required this.isChecked,
      required this.onChange,
      required this.longPress});
  final String task;
  final bool isChecked;
  final Function(bool?)? onChange;
  final Function()? longPress;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onLongPress: longPress,
      title: Text(
        task,
        style: TextStyle(
            decoration: isChecked ? TextDecoration.lineThrough : null),
      ),
      trailing: Checkbox(
        value: isChecked,
        onChanged: onChange,
      ),
    );
  }
}
