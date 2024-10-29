import 'package:todo_app/src/todo/domain/entities/task.dart';
import 'package:todo_app/src/todo/domain/repository/task_repository.dart';

class AddTaskUseCase {
  final TaskRepository _repository;

  AddTaskUseCase(this._repository);

  Future<void> call(Task task) async {
    await _repository.addTask(task: task);
  }
}
