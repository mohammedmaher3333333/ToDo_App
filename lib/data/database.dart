import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class ToDoDataBase extends ChangeNotifier {
  List toDoList = [];

  // reference our box
  final _myBox = Hive.box('mybox');

  ToDoDataBase() {
    // Load data when the database is instantiated
    loadData();
  }

  // Create initial data if this is the 1st time ever opening this app
  void createInitialData() {
    toDoList = [
      // ["Make Tutorial", false],
      // ["Do Exercise", false],
    ];
    updateDataBase();
  }

  // Load the data from the database
  void loadData() {
    toDoList = _myBox.get("TODOLIST", defaultValue: []);
    notifyListeners();
  }

  // Update the database
  void updateDataBase() {
    _myBox.put("TODOLIST", toDoList);
    notifyListeners();
  }

  // Add a new task
  void addTask(String taskName) {
    toDoList.add([taskName, false]);
    updateDataBase();
  }

  // Edit an existing task
  void editTask(int index, String newTaskName) {
    toDoList[index][0] = newTaskName;
    updateDataBase();
  }

  // Delete a task
  void deleteTask(int index) {
    toDoList.removeAt(index);
    updateDataBase();
  }

  // Toggle task completion
  void toggleTaskCompletion(int index) {
    toDoList[index][1] = !toDoList[index][1];
    updateDataBase();
  }
}
