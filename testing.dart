import 'dart:convert';
// To parse this JSON data, do
//
//     final taskList = taskListFromJson(jsonString);

TaskList taskListFromJson(String str) => TaskList.fromJson(json.decode(str));

String taskListToJson(TaskList data) => json.encode(data.toJson());

class TaskList {
  TaskList({
    required this.taskList,
  });

  List<Task> taskList;

  factory TaskList.fromJson(Map<String, dynamic> json) => TaskList(
        taskList:
            List<Task>.from(json["TaskList"].map((x) => Task.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "TaskList": List<dynamic>.from(taskList.map((x) => x.toJson())),
      };

  @override
  String toString() {
    return '{ "TaskList":${taskList.toString()} }';
  }
}

class Task {
  Task({
    required this.name,
    this.isDone = false,
  });

  String name;
  bool isDone;

  void toggle() {
    isDone = !isDone;
  }

  factory Task.fromJson(Map<String, dynamic> json) => Task(
        name: json["name"],
        isDone: json["isDone"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "isDone": isDone,
      };

  @override
  String toString() {
    return ' {"name":$name,"isDone":$isDone} ';
  }
}

void main() {
  List<Task> tasks = [Task(name: 'Test1'), Task(name: 'test2')];

  String taskString = tasksToString(tasks);

  stringToTasks(taskString);
}

String tasksToString(List<Task> tasks) {
  TaskList taskList = TaskList(taskList: tasks);
  String tasksString = taskListToJson(taskList);
  print('$tasksString');

  return tasksString;
}

void stringToTasks(String jsonString) {
  final taskList = taskListFromJson(jsonString);
  print(' from json $taskList');
}
