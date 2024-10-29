part of 'task_bloc.dart';

sealed class TaskEvent extends Equatable {
  const TaskEvent();

  @override
  List<Object> get props => [];
}

final class AddTaskEvent extends TaskEvent {
  final Task task;

  const AddTaskEvent(this.task);
}

final class LoadTasksEvent extends TaskEvent {}

final class UpdateTaskStatusEvent extends TaskEvent {
  final String id;
  final bool isComplete;

  const UpdateTaskStatusEvent(this.id, this.isComplete);
}
