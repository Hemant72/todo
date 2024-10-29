import 'package:todo_app/src/todo/domain/entities/task.dart';
import 'package:todo_app/src/todo/domain/repository/task_repository.dart';

class GetTasksUsecase {
  final TaskRepository repository;

  GetTasksUsecase(this.repository);

  Stream<List<Task>> call() {
    return repository.getTasks();
  }
}
