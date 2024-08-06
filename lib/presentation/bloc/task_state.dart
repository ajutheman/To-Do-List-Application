// part of 'task_bloc.dart';

import 'package:equatable/equatable.dart';

import '../../domain/entities/task_entity.dart';

abstract class TaskState extends Equatable {
  const TaskState();

  @override
  List<Object> get props => [];
}

class TaskInitial extends TaskState {}

class TaskLoadSuccess extends TaskState {
  final List<Task> tasks;

  const TaskLoadSuccess({required this.tasks});

  @override
  List<Object> get props => [tasks];
}

class TaskLoadFailure extends TaskState {}

class TaskFilterSuccess extends TaskState {
  final List<Task> tasks;

  const TaskFilterSuccess({required this.tasks});

  @override
  List<Object> get props => [tasks];
}
