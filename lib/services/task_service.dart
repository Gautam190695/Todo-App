
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/task_model.dart';

class TaskService {
final String baseUrl ="https://robust-d89d2-default-rtdb.firebaseio.com/tasks";
  Future<List<Task>> fetchTasks() async {
    final res = await http.get(Uri.parse("$baseUrl.json"));
    print(res.body);
    if (res.body == "null") return [];

    final data = json.decode(res.body);
    List<Task> tasks = [];

    data.forEach((id, value) {
      tasks.add(Task.fromJson(id, value));
    });

    return tasks;
  }

  Future<void> addTask(String title) async {
    await http.post(
      Uri.parse("$baseUrl.json"),
      body: json.encode({
        "title": title,
        "completed": false,
      }),
    );
  }

  Future updateTask(Task task) async {
    await http.put(
      Uri.parse("$baseUrl/${task.id}.json"),
      body: json.encode(task.toJson()),
    );
  }

  Future<void> deleteTask(String id) async {
    await http.delete(Uri.parse("$baseUrl/$id.json"));
  }
}
