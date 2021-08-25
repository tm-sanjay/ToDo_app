import 'package:flutter/material.dart';
import 'package:todo_app/widgets/tast_tile.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/models/task_data.dart';

class TaskListWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // to use value multiple times use consumer
    return Consumer<TaskData>(
      builder: (BuildContext context, taskData, Widget? child) {
        return taskData.tasks.isEmpty
            ? noTasks()
            : ListView.builder(
                itemCount: taskData.tasks.length,
                itemBuilder: (context, index) {
                  final task = taskData.tasks[index];
                  return TaskTile(
                    task: task.name,
                    isChecked: task.isDone,
                    onChange: (value) => taskData.updateTask(task),
                    longPress: () => taskData.removeTask(task),
                  );
                },
              );
      },
    );
  }

  Center noTasks() {
    return Center(
      child: Text(
        'No Tasks',
        style: TextStyle(fontSize: 17.0),
      ),
    );
  }
}
