// ignore_for_file: avoid_print

import 'package:http/http.dart' as http;
import 'dart:convert';

Future apiGetAllTodos() async {
  final url = Uri.parse('https://todo-app-ten-neon.vercel.app/api/task/get/all');

  try {
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      print("Received data from API Request.");
      print(jsonData["data"]);
      List<dynamic> data = jsonData["data"];
      return data;
    } else {
      throw Exception('Failed to load data');
    }
  } catch (e) {
    print('Error: $e');
  }
}
