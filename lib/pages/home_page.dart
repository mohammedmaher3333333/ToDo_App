import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/data/database.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final toDoDataBase = Provider.of<ToDoDataBase>(context);

    return Scaffold(
      backgroundColor: Colors.blue.shade900,
      appBar: AppBar(
        backgroundColor: Colors.blue.shade800,
        foregroundColor: Colors.white,
        title: const Text(
          'TO DO App',
          style: TextStyle(fontSize: 25),
        ),
        elevation: 15,
      ),
      body: ListView.builder(
        itemCount: toDoDataBase.toDoList.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Container(
              color: Colors.blue.shade600,
              child: ListTile(
                title: Text(
                  toDoDataBase.toDoList[index][0],
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      decoration: toDoDataBase.toDoList[index][1]
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                  ),
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.edit,
                        color: Colors.white,
                      ),
                      onPressed: () => _editTaskDialog(context, index),
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.delete,
                        color: Colors.white,
                      ),
                      onPressed: () => toDoDataBase.deleteTask(index),
                    ),
                    Checkbox(
                      activeColor: Colors.blue,
                      value: toDoDataBase.toDoList[index][1],
                      onChanged: (value) {
                        toDoDataBase.toggleTaskCompletion(index);
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addTaskDialog(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _addTaskDialog(BuildContext context) {
    final toDoDataBase = Provider.of<ToDoDataBase>(context, listen: false);
    final TextEditingController controller = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.blue,
          title: const Text(
            'Add Task',
            style: TextStyle(color: Colors.white),
          ),
          content: TextField(
            style: const TextStyle(color: Colors.white),
            controller: controller,
            decoration: const InputDecoration(
                hintStyle: TextStyle(color: Colors.white),
                hintText: 'Task Name'),
          ),
          actions: [
            // buttons -> save + cancel
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // cancel button
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    controller.clear();
                  },
                  child: const Text(
                    'Cancel',
                    style: TextStyle(color: Colors.white),
                  ),
                ),

                const SizedBox(width: 8),

                // save button
                TextButton(
                  onPressed: () {
                    toDoDataBase.addTask(controller.text);
                    Navigator.of(context).pop();
                  },
                  child: const Text(
                    'Add',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  void _editTaskDialog(BuildContext context, int index) {
    final toDoDataBase = Provider.of<ToDoDataBase>(context, listen: false);
    final TextEditingController controller = TextEditingController(
      text: toDoDataBase.toDoList[index][0],
    );

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.blue,
          title: const Text(
            'Edit Task',
            style: TextStyle(color: Colors.white),
          ),
          content: TextField(
            style: const TextStyle(color: Colors.white),
            controller: controller,
            decoration: const InputDecoration(
              hintText: 'Task Name',
              hintStyle: TextStyle(color: Colors.white),
            ),
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // cancel button
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    controller.clear();
                  },
                  child: const Text(
                    'Cancel',
                    style: TextStyle(color: Colors.white),
                  ),
                ),

                const SizedBox(width: 8),

                // save button
                TextButton(
                  onPressed: () {
                    toDoDataBase.editTask(index, controller.text);
                    Navigator.of(context).pop();
                  },
                  child: const Text(
                    'Save',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
