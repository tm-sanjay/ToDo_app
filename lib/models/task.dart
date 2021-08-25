import 'dart:convert';

String taskToJson(Task data) => json.encode(data.toJson());

class Task {
  String name;
  bool isDone;

  Task({
    required this.name,
    this.isDone = false,
  });

  void toggle() {
    isDone = !isDone;
  }

  factory Task.fromJson(Map<String, dynamic> json) => Task(
        name: json['name'],
        isDone: json['isDone'],
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'isDone': isDone,
      };

  @override
  String toString() {
    return "{'name':'$name','isDone':$isDone}";
  }
}
