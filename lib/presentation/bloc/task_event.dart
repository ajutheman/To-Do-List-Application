// part of 'task_bloc.dart';

// import 'package:equatable/equatable.dart';
// import 'package:todo_list_app/domain/entities/task_entity.dart';

// import 'package:equatable/equatable.dart';

import 'package:equatable/equatable.dart';

import '../../domain/entities/task_entity.dart';

abstract class TaskEvent extends Equatable {
  const TaskEvent();

  @override
  List<Object> get props => [];
}

class LoadTasks extends TaskEvent {}

class AddTask extends TaskEvent {
  final Task task;

  const AddTask(this.task);

  @override
  List<Object> get props => [task];
}

class DeleteTask extends TaskEvent {
  final String id;

  const DeleteTask(this.id);

  @override
  List<Object> get props => [id];
}

class MarkTaskAsCompleted extends TaskEvent {
  final String id;

  const MarkTaskAsCompleted(this.id);

  @override
  List<Object> get props => [id];
}

class MarkTaskAsPending extends TaskEvent {
  final String id;

  const MarkTaskAsPending(this.id);

  @override
  List<Object> get props => [id];
}

class FilterTasks extends TaskEvent {
  final TaskStatus status;

  const FilterTasks(this.status);

  @override
  List<Object> get props => [status];
}

enum TaskStatus { all, completed, pending }
