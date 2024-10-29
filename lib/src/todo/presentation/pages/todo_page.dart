import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/src/todo/domain/entities/task.dart';
import 'package:todo_app/src/todo/presentation/bloc/task_bloc.dart';
import 'package:uuid/uuid.dart';

class ToDoListScreen extends StatelessWidget {
  final _uuid = const Uuid();

  const ToDoListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "My To-Do List",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 4,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocBuilder<TaskBloc, TaskState>(
          builder: (context, state) {
            if (state is TaskLoading) {
              // When the loading state occurs only for the first time
              return const Center(child: CircularProgressIndicator());
            } else if (state is TaskLoaded) {
              // Check if the task list is empty
              if (state.tasks.isEmpty) {
                return Center(
                  child: Text(
                    "No tasks available right now.\nPress the button below to add a new task!",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18, color: Colors.grey[600]),
                  ),
                );
              } else {
                // Show the list of tasks if available
                return ListView.builder(
                  itemCount: state.tasks.length,
                  itemBuilder: (context, index) {
                    final task = state.tasks[index];
                    return TaskCard(task: task);
                  },
                );
              }
            }
            return const Center(child: Text("Error loading tasks"));
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddTaskDialog(context),
        tooltip: "Add a new task",
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showAddTaskDialog(BuildContext context) {
    final TextEditingController taskTitleController = TextEditingController();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Add New Task"),
          content: TextField(
            controller: taskTitleController,
            decoration: const InputDecoration(
              hintText: "Enter task title",
            ),
          ),
          actions: [
            TextButton(
              child: const Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: const Text("Add"),
              onPressed: () {
                final taskTitle = taskTitleController.text.trim();
                if (taskTitle.isNotEmpty) {
                  final newTask = Task(id: _uuid.v4(), title: taskTitle);
                  context.read<TaskBloc>().add(AddTaskEvent(newTask));
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        );
      },
    );
  }
}

class TaskCard extends StatelessWidget {
  final Task task;

  const TaskCard({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                task.title,
                style: TextStyle(
                  fontSize: 18,
                  decoration:
                      task.isComplete ? TextDecoration.lineThrough : null,
                ),
              ),
            ),
            AnimatedCheckbox(
              value: task.isComplete,
              onChanged: (isChecked) {
                context
                    .read<TaskBloc>()
                    .add(UpdateTaskStatusEvent(task.id, isChecked));
              },
            ),
          ],
        ),
      ),
    );
  }
}

class AnimatedCheckbox extends StatefulWidget {
  final bool value;
  final ValueChanged<bool> onChanged;

  const AnimatedCheckbox(
      {super.key, required this.value, required this.onChanged});

  @override
  State<AnimatedCheckbox> createState() => _AnimatedCheckboxState();
}

class _AnimatedCheckboxState extends State<AnimatedCheckbox>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    if (widget.value) {
      _controller.forward();
    }
  }

  @override
  void didUpdateWidget(covariant AnimatedCheckbox oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onChanged(!widget.value);
      },
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Icon(
            _controller.value > 0.5
                ? Icons.check_box
                : Icons.check_box_outline_blank,
            color: _controller.value > 0.5 ? Colors.blue : Colors.grey,
            size: 28,
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
