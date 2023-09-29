// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print

import 'package:flutter/material.dart';

class AddTaskWidget extends StatelessWidget {
  final toggleAddTask;
  final addTask;


  const AddTaskWidget({super.key, required this.toggleAddTask, required this.addTask});


  @override
  Widget build(BuildContext context) {

    final todoTitleController = TextEditingController();
    final todoDescriptionController = TextEditingController();
    
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        // margin: EdgeInsets.symmetric(vertical: 50, horizontal: 10),
        padding: EdgeInsets.symmetric(vertical: 41, horizontal: 1),
        decoration: BoxDecoration(
            color: Colors.amber[100], borderRadius: BorderRadius.circular(12)),

        child: Column(
          children: <Widget>[
            Text(
              "Add new Todo",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 32,
                  fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 25),
            Container(
              margin: EdgeInsets.only(bottom: 21, right: 21, left: 21),
              padding: EdgeInsets.symmetric(horizontal: 18, vertical: 5),
              decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey,
                        offset: Offset(0.0, 0.0),
                        blurRadius: 10.0,
                        spreadRadius: 0.0),
                  ],
                  borderRadius: BorderRadius.circular(14)),
              child: TextField(
                controller: todoTitleController,
                decoration: InputDecoration(
                  hintText: "Title",
                  border: InputBorder.none,
                  hintStyle: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: 19),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 21, right: 21, left: 21),
              padding: EdgeInsets.symmetric(horizontal: 18, vertical: 5),
              decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey,
                        offset: Offset(0.0, 0.0),
                        blurRadius: 10.0,
                        spreadRadius: 0.0),
                  ],
                  borderRadius: BorderRadius.circular(14)),
              child: TextField(
                controller: todoDescriptionController,
                maxLines: 7,
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(
                  hintText: "Description",
                  // contentPadding: EdgeInsets.symmetric(vertical: 41),
                  border: InputBorder.none,
                  hintStyle: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: 19),
                ),
              ),
            ),
            Container(
                margin: EdgeInsets.only(bottom: 21, right: 21, left: 21),
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(14)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Expanded(
                      child: ElevatedButton(
                        onPressed: toggleAddTask,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red[300],
                          minimumSize: Size(61, 61),
                          elevation: 10,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                        child: Text(
                          "Cancel",
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () => {
                            print("Adding new task!"),
                            // print(todoDescriptionController.text)
                            addTask(todoTitleController.text, todoDescriptionController.text)
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green[300],
                          minimumSize: Size(61, 61),
                          elevation: 10,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                        child: Text(
                          "Add",
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
