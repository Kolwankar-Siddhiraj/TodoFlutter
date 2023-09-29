// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_typing_uninitialized_variables, avoid_print

import 'package:flutter/material.dart';

class TaskTile extends StatelessWidget {
  final todo;
  final taskDoneFunc;
  final deleteTask;
  final showTask;

  const TaskTile({super.key, required this.todo, required this.taskDoneFunc, required this.deleteTask, required this.showTask});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 7),
      margin: EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        onTap: () => {
            showTask(todo["id"]),
            print("Todo clicked !")
        },
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(21)),
        hoverColor: Colors.blue[300],
        leading: todo["status"] == "completed"
            ? IconButton(
                onPressed: () => {taskDoneFunc(todo["id"])}, 
                icon: Icon(Icons.check_box, size: 30, color: Colors.green)
            )
            : IconButton(
                onPressed: () => {taskDoneFunc(todo["id"])}, 
                icon: Icon(Icons.check_box_outline_blank, size: 30, color: Colors.green)
            ),
        title: Text(
          todo["title"],
          style: TextStyle(
              fontSize: 21,
              fontWeight: FontWeight.w500,
              decoration: todo["status"] == "completed"
                  ? TextDecoration.lineThrough
                  : null),
        ),
        trailing: IconButton(
            onPressed:() => {
              deleteTask(todo["id"])
            },
            icon: Icon(
                Icons.delete,
                size: 34,
                color: Colors.red,
            ),
        ),
        
      ),
    );
  }
}
