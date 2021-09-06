import 'dart:collection';
import 'dart:convert';
import 'package:todo_app/models/store_data.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/models/task.dart';

class TaskData extends ChangeNotifier {
  List<Task> list = [];

  //this data type will avoide modifing list(tasks)
  UnmodifiableListView<Task> get tasks {
    getSavedTasks();
    return UnmodifiableListView(list);
  }

  int get taskCount {
    return tasks.length;
  }

  void addNewTask(String? newTask) {
    final task = Task(name: newTask!);
    print('${task.name} is added');
    list.add(task);
    saveTasks();
    notifyListeners(); //importent
  }

  void updateTask(Task task) {
    //get the index of task
    var index = list.indexWhere((x) => x.name == task.name);
    list[index].isDone = !(list[index].isDone);
    print('toggled ${task.name}');
    saveTasks();
    notifyListeners(); //importent
  }

  void removeTask(Task task) {
    //get the index of task
    var index = list.indexWhere((x) => x.name == task.name);
    list.removeAt(index);
    print('${task.name} is removed');
    saveTasks();
    notifyListeners(); //importent
  }

  void saveTasks() {
    List<String> spList = list.map((item) => taskToJson(item)).toList();
    StoreData.setList(spList);
    print('saving => $spList');
  }

  void getSavedTasks() {
    List<String>? spList = StoreData.getList();
    list = spList!.map((item) => Task.fromJson(json.decode(item))).toList();
  }
}
