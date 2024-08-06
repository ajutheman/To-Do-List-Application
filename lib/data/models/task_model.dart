import 'package:todo_list_app/domain/entities/task_entity.dart';

class TaskModel extends Task {
  TaskModel({
    required String id,
    required String description,
    bool isCompleted = false,
    bool isImportant = false,
    required DateTime createdTime,
    DateTime? completedTime,
    Duration? estimatedTime,
  }) : super(
          id: id,
          description: description,
          isCompleted: isCompleted,
          isImportant: isImportant,
          createdTime: createdTime,
          completedTime: completedTime,
          estimatedTime: estimatedTime,
        );

  factory TaskModel.fromEntity(Task task) {
    return TaskModel(
      id: task.id,
      description: task.description,
      isCompleted: task.isCompleted,
      isImportant: task.isImportant,
      createdTime: task.createdTime,
      completedTime: task.completedTime,
      estimatedTime: task.estimatedTime,
    );
  }

  Task toEntity() {
    return Task(
      id: id,
      description: description,
      isCompleted: isCompleted,
      isImportant: isImportant,
      createdTime: createdTime,
      completedTime: completedTime,
      estimatedTime: estimatedTime,
    );
  }
}
