import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list_app/data/repositories/task_repository_impl.dart';
import 'package:todo_list_app/presentation/bloc/task_bloc.dart';
import 'package:todo_list_app/presentation/pages/task_list.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<TaskBloc>(
          create: (context) =>
              TaskBloc(taskRepository: TaskRepositoryImpl())..add(LoadTasks()),
        ),
      ],
      child: MaterialApp(
        title: 'To-Do List App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: TaskList(),
      ),
    );
  }
}
