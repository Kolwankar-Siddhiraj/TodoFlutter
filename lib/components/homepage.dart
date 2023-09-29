// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print

import 'package:flutter/material.dart';
import 'package:todo_api/components/addtask.dart';
import 'package:todo_api/components/showtask.dart';
import 'package:todo_api/components/tasktile.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isAddingTask = false;
  bool isShowingTask = false;

  List todoList = [];
  dynamic displayTodo;

//   List todoList = [
//     {
//       "id": 408,
//       "title": "message new here",
//       "description": "i dont know task",
//       "due_date": "2023-07-21",
//       "status": "in-progress",
//       "created_at": "2023-09-28T18:41:22.901749Z",
//       "updated_at": "2023-09-28T18:41:22.901767Z"
//     },
//     {
//       "id": 407,
//       "title": "message new here",
//       "description": "i dont know task",
//       "due_date": "2023-07-21",
//       "status": "in-progress",
//       "created_at": "2023-09-28T18:41:20.809151Z",
//       "updated_at": "2023-09-28T18:41:20.809169Z"
//     },
//     {
//       "id": 406,
//       "title": "message new here",
//       "description": "i dont know task",
//       "due_date": "2023-07-21",
//       "status": "in-progress",
//       "created_at": "2023-09-28T18:41:17.939717Z",
//       "updated_at": "2023-09-28T18:41:17.939735Z"
//     },
//     {
//       "id": 405,
//       "title": "message new here",
//       "description": "i dont know task",
//       "due_date": "2023-07-21",
//       "status": "completed",
//       "created_at": "2023-09-28T18:41:15.658114Z",
//       "updated_at": "2023-09-28T18:41:15.658132Z"
//     },
//     {
//       "id": 404,
//       "title": "message new here",
//       "description": "i dont know task",
//       "due_date": "2023-07-21",
//       "status": "in-progress",
//       "created_at": "2023-09-28T18:41:12.677370Z",
//       "updated_at": "2023-09-28T18:41:12.677390Z"
//     },
//     {
//       "id": 403,
//       "title": "New Task 7",
//       "description": "my new task",
//       "due_date": "2023-07-21",
//       "status": "completed",
//       "created_at": "2023-09-28T18:40:50.679362Z",
//       "updated_at": "2023-09-28T18:40:50.679387Z"
//     },
//     {
//       "id": 402,
//       "title": "New Task 7",
//       "description": "my new task",
//       "due_date": "2023-07-21",
//       "status": "in-progress",
//       "created_at": "2023-09-28T18:40:47.525323Z",
//       "updated_at": "2023-09-28T18:40:47.525342Z"
//     },
//   ];

  @override
  void initState() {
    apiGetAllTodos();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ToDo App"),
      ),
      body: Stack(children: <Widget>[
        Container(
          color: Colors.grey[300],
          child: ListView(
            padding: EdgeInsets.symmetric(vertical: 18, horizontal: 10),
            children: [
              for (dynamic t in todoList)
                TaskTile(
                  todo: t,
                  taskDoneFunc: taskDone,
                  deleteTask: deleteExistingTask,
                  showTask: showTaskInfo,
                ),

              //   TaskTile(),
            ],
          ),
        ),

        // add task here

        isAddingTask
            ? AddTaskWidget(
                toggleAddTask: toggleAddTaskComponent, addTask: addNewTask)
            : SizedBox(height: 1),
        // AddTaskWidget(),
        // add task button

        isAddingTask
            ? SizedBox(height: 1)
            : Align(
                alignment: Alignment.bottomRight,
                child: Container(
                  margin: EdgeInsets.only(right: 21, bottom: 21),
                  child: ElevatedButton(
                    onPressed: () => {
                      setState(() => {isAddingTask = !isAddingTask}),
                      print("Add todo component!")
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red[300],
                      minimumSize: Size(61, 61),
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    child: Text(
                      "Add Task +",
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
              ),

        // show task info
        isShowingTask
            ? ShowTaskInfoWidget(
                todo: displayTodo,
                closeTask: closeDisplayTask,
                updateTask: updateTaskInfo)
            : SizedBox(height: 1),
      ]),
    );
  }

  void toggleAddTaskComponent() {
    setState(() => {isAddingTask = !isAddingTask});
  }

  void taskDone(int tid) {
    var temp = todoList.firstWhere((element) => element["id"] == tid);
    var status = temp["status"] == "in-progress" ? "completed" : "in-progress";
    apiUpdateTodo({"id": tid.toString(), "title": temp["title"], "description": temp["description"], "status": status}, tid, true);
  }

  void addNewTask(String title, String description) {
    if (title.isNotEmpty) {
      apiAddTodo({
        "title": title,
        "description": description,
        "due_date": "21-07-2023"
      });
    }

    toggleAddTaskComponent();
  }

  void deleteExistingTask(int tid) {
    apiDeleteTodo({"id": tid.toString()}, tid);
  }

  void showTaskInfo(tid) {
    setState(() {
      displayTodo = todoList.firstWhere((element) => element["id"] == tid);
      isShowingTask = true;
    });
  }

  void closeDisplayTask() {
    setState(() {
      isShowingTask = false;
    });
  }

  void updateTaskInfo(int tid, String title, String description) {
    if (title.isNotEmpty) {
      apiUpdateTodo({"id": tid.toString(), "title": title, "description": description}, tid, false);
    }

    // showTaskInfo(tid);
  }

  void apiAllTodos(allTodos) {
    setState(() {
      todoList = allTodos;
    });
  }

  // api

  Future apiGetAllTodos() async {
    final url =
        Uri.parse('https://todo-app-ten-neon.vercel.app/api/task/get/all');

    try {
      print("reqesting data !");
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        setState(() {
          todoList = jsonData["data"];
        });
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future apiAddTodo(Map<String, dynamic> bodyData) async {
    final url = Uri.parse('https://todo-app-ten-neon.vercel.app/api/task/add');

    try {
      print("adding data !");
      final response = await http.post(url, body: bodyData);

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        print("jsonData :: $jsonData");
        setState(() {
          todoList.insert(0, jsonData["data"]);
        });
      } else {
        print("resposne code :: ${response.statusCode} ");
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future apiUpdateTodo(Map bodyData, int tid, bool markComplete) async {
    final url =
        Uri.parse('https://todo-app-ten-neon.vercel.app/api/task/update');

    try {
      print("updating data !");
      final response = await http.post(url, body: bodyData);

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        setState(() {
          todoList[todoList.indexWhere((element) => element["id"] == tid)] =
              jsonData["data"];

            if (!markComplete) {
                showTaskInfo(tid);
            }
        });
      } else {
        print("resposne code :: ${response.statusCode} ");
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future apiDeleteTodo(Map bodyData, int tid) async {
    final url =
        Uri.parse('https://todo-app-ten-neon.vercel.app/api/task/delete');

    try {
      print("deleting data !");
      final response = await http.post(url, body: bodyData);

      if (response.statusCode == 200) {
        setState(() {
          todoList.removeWhere((item) => item["id"] == tid);
        });
      } else {
        print("resposne code :: ${response.statusCode} ");
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

}
