import 'dart:async';

import 'package:todo_app/src/todo/domain/entities/task.dart';
import 'package:todo_app/src/todo/domain/repository/task_repository.dart';

class TaskRepositoryImpl implements TaskRepository {
  final List<Task> _tasks = [];
  final StreamController<List<Task>> _taskController =
      StreamController.broadcast();


  @override
  Future<void> addTask({required Task task}) async {
    _tasks.add(task);
    _taskController.add(List.from(_tasks));
  }

  @override
  Stream<List<Task>> getTasks() => _taskController.stream;

  @override
  Future<void> updateTaskStatus(
      {required String id, required bool isComplete}) async {
    final index = _tasks.indexWhere((task) => task.id == id);
    if (index != -1) {
      _tasks[index] = _tasks[index].copyWith(isComplete: isComplete);
      _taskController.add(List.from(_tasks));
    }
  }
}
