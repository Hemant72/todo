import 'package:equatable/equatable.dart';

class Task extends Equatable {
  final String id;
  final String title;
  final bool isComplete;

  const Task({required this.id, required this.title, this.isComplete = false});

  @override
  List<Object> get props => [id, title, isComplete];

  Task copyWith({bool? isComplete}) {
    return Task(
      id: id,
      title: title,
      isComplete: isComplete ?? this.isComplete,
    );
  }
}
