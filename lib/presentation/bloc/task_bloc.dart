import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list_app/domain/entities/task_entity.dart';
import 'package:todo_list_app/domain/entities/task_status.dart';
import 'package:todo_list_app/domain/repositories/task_repository.dart';

abstract class TaskEvent {}

class LoadTasks extends TaskEvent {}

class AddTask extends TaskEvent {
  final Task task;

  AddTask(this.task);
}

class DeleteTask extends TaskEvent {
  final String taskId;

  DeleteTask(this.taskId);
}

class MarkTaskAsCompleted extends TaskEvent {
  final String taskId;

  MarkTaskAsCompleted(this.taskId);
}

class MarkTaskAsPending extends TaskEvent {
  final String taskId;

  MarkTaskAsPending(this.taskId);
}

class FilterTasks extends TaskEvent {
  final TaskStatus status;

  FilterTasks(this.status);
}

abstract class TaskState {}

class TaskInitial extends TaskState {}

class TaskLoadSuccess extends TaskState {
  final List<Task> tasks;

  TaskLoadSuccess(this.tasks);
}

class TaskLoadFailure extends TaskState {}

class TaskFilterSuccess extends TaskState {
  final List<Task> tasks;

  TaskFilterSuccess(this.tasks);
}

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final TaskRepository taskRepository;

  TaskBloc({required this.taskRepository}) : super(TaskInitial()) {
    on<LoadTasks>((event, emit) {
      emit(TaskLoadSuccess(taskRepository.getTasks()));
    });
    on<AddTask>((event, emit) {
      taskRepository.addTask(event.task);
      emit(TaskLoadSuccess(taskRepository.getTasks()));
    });
    on<DeleteTask>((event, emit) {
      taskRepository.deleteTask(event.taskId);
      emit(TaskLoadSuccess(taskRepository.getTasks()));
    });
    on<MarkTaskAsCompleted>((event, emit) {
      taskRepository.markTaskAsCompleted(event.taskId);
      emit(TaskLoadSuccess(taskRepository.getTasks()));
    });
    on<MarkTaskAsPending>((event, emit) {
      taskRepository.markTaskAsPending(event.taskId);
      emit(TaskLoadSuccess(taskRepository.getTasks()));
    });
    on<FilterTasks>((event, emit) {
      final allTasks = taskRepository.getTasks();
      if (event.status == TaskStatus.all) {
        emit(TaskLoadSuccess(allTasks));
      } else {
        final filteredTasks = allTasks.where((task) {
          if (event.status == TaskStatus.completed) {
            return task.isCompleted;
          } else if (event.status == TaskStatus.pending) {
            return !task.isCompleted;
          } else if (event.status == TaskStatus.ongoing) {
            return !task.isCompleted && !task.isImportant;
          } else if (event.status == TaskStatus.important) {
            return task.isImportant;
          }
          return false;
        }).toList();
        emit(TaskFilterSuccess(filteredTasks));
      }
    });
  }
}
