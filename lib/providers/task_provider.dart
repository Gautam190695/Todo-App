import 'package:flutter/material.dart';
import '../models/task_model.dart';
import '../services/task_service.dart';

class TaskProvider extends ChangeNotifier {
  final TaskService _service = TaskService();

  List<Task> tasks = [];
  int page = 0;
  int limit = 20;

  Future<void> loadTasks() async {
    final data = await _service.fetchTasks();
    tasks = data.take((page + 1) * limit).toList();
    notifyListeners();
  }

  Future<void> loadMore() async {
    page++;
    await loadTasks();
  }

  Future<void> addTask(String title) async {
    await _service.addTask(title);
    await loadTasks();
  }

  Future<void> toggle(Task task) async {
    task.completed = !task.completed;
    await _service.updateTask(task);
    notifyListeners();
  }

  Future<void> delete(String id) async {
    await _service.deleteTask(id);
    await loadTasks();
  }

  Future<void> updateTask(Task task) async {
    await _service.updateTask(task);

    int index = tasks.indexWhere((t) => t.id == task.id);
    if (index != -1) {
      tasks[index] = task;
    }

    notifyListeners();
  }
}
