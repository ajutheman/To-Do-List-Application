import 'package:todo_list_app/domain/entities/task_entity.dart';
import 'package:todo_list_app/domain/repositories/task_repository.dart';

class TaskRepositoryImpl implements TaskRepository {
  final List<Task> _tasks = [];

  @override
  List<Task> getTasks() {
    return _tasks;
  }

  @override
  void addTask(Task task) {
    _tasks.add(task);
  }

  @override
  void deleteTask(String taskId) {
    _tasks.removeWhere((task) => task.id == taskId);
  }

  @override
  void markTaskAsCompleted(String taskId) {
    final taskIndex = _tasks.indexWhere((task) => task.id == taskId);
    if (taskIndex != -1) {
      _tasks[taskIndex] = Task(
        id: _tasks[taskIndex].id,
        description: _tasks[taskIndex].description,
        isCompleted: true,
        isImportant: _tasks[taskIndex].isImportant,
        createdTime: _tasks[taskIndex].createdTime,
        completedTime: DateTime.now(),
        estimatedTime: _tasks[taskIndex].estimatedTime,
      );
    }
  }

  @override
  void markTaskAsPending(String taskId) {
    final taskIndex = _tasks.indexWhere((task) => task.id == taskId);
    if (taskIndex != -1) {
      _tasks[taskIndex] = Task(
        id: _tasks[taskIndex].id,
        description: _tasks[taskIndex].description,
        isCompleted: false,
        isImportant: _tasks[taskIndex].isImportant,
        createdTime: _tasks[taskIndex].createdTime,
        estimatedTime: _tasks[taskIndex].estimatedTime,
      );
    }
  }
}
