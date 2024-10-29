import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/src/todo/domain/entities/task.dart';
import 'package:todo_app/src/todo/domain/usecases/add_task_usecase.dart';
import 'package:todo_app/src/todo/domain/usecases/get_task_usecase.dart';
import 'package:todo_app/src/todo/domain/usecases/update_task_usecase.dart';

part 'task_event.dart';
part 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final AddTaskUseCase addTaskUseCase;
  final GetTasksUsecase getTasksUseCase;
  final UpdateTaskStatusUsecase updateTaskStatusUseCase;

  TaskBloc(
      this.addTaskUseCase, this.getTasksUseCase, this.updateTaskStatusUseCase)
      : super(TaskInitial()) {
    on<AddTaskEvent>((event, emit) async {
      await addTaskUseCase(event.task);
    });

    on<LoadTasksEvent>((event, emit) async {
      emit(TaskLoading());
      await emit.forEach<List<Task>>(getTasksUseCase.call(), onData: (tasks) {
        return TaskLoaded(tasks);
      });
    });

    on<UpdateTaskStatusEvent>((event, emit) async {
      await updateTaskStatusUseCase(event.id, event.isComplete);
    });
  }
}
