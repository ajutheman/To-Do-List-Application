import 'package:todo_list_app/domain/entities/task_entity.dart';

abstract class TaskRepository {
  List<Task> getTasks();
  void addTask(Task task);
  void deleteTask(String taskId);
  void markTaskAsCompleted(String taskId);
  void markTaskAsPending(String taskId);
}
