import 'package:get_it/get_it.dart';
import 'package:todo_app/src/todo/data/repositiory/auth_repositiory_impl.dart';
import 'package:todo_app/src/todo/domain/repository/task_repository.dart';
import 'package:todo_app/src/todo/domain/usecases/add_task_usecase.dart';
import 'package:todo_app/src/todo/domain/usecases/get_task_usecase.dart';
import 'package:todo_app/src/todo/domain/usecases/update_task_usecase.dart';
import 'package:todo_app/src/todo/presentation/bloc/task_bloc.dart';

final getIt = GetIt.instance;

void setup() {
  getIt.registerLazySingleton<TaskRepository>(() => TaskRepositoryImpl());

  // Register use cases
  getIt.registerLazySingleton(() => AddTaskUseCase(getIt<TaskRepository>()));
  getIt.registerLazySingleton(() => GetTasksUsecase(getIt<TaskRepository>()));
  getIt.registerLazySingleton(
      () => UpdateTaskStatusUsecase(getIt<TaskRepository>()));

  // Register BLoC
  getIt.registerFactory(() => TaskBloc(
        getIt<AddTaskUseCase>(),
        getIt<GetTasksUsecase>(),
        getIt<UpdateTaskStatusUsecase>(),
      ));
}
