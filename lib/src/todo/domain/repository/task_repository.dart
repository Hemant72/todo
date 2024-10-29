import 'package:todo_app/src/todo/domain/entities/task.dart';

abstract class TaskRepository {
  const TaskRepository();

  Future<void> addTask({
    required Task task,
  });

  Stream<List<Task>> getTasks();

  Future<void> updateTaskStatus({
    required String id,
    required bool isComplete,
  });
}
