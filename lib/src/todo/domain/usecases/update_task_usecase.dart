import 'package:todo_app/src/todo/domain/repository/task_repository.dart';

class UpdateTaskStatusUsecase {
  final TaskRepository repository;

  UpdateTaskStatusUsecase(this.repository);

  Future<void> call(String id, bool isComplete) async {
    await repository.updateTaskStatus(id: id, isComplete: isComplete);
  }
}
