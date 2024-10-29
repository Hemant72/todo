import 'package:go_router/go_router.dart';
import 'package:todo_app/src/todo/presentation/pages/todo_page.dart';

final GoRouter router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (context, state) => const ToDoListScreen(),
    ),
  ],
);
