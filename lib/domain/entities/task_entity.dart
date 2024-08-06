class Task {
  final String id;
  final String description;
  final bool isCompleted;
  final bool isImportant;
  final DateTime createdTime;
  final DateTime? completedTime;
  final Duration? estimatedTime;

  Task({
    required this.id,
    required this.description,
    this.isCompleted = false,
    this.isImportant = false,
    required this.createdTime,
    this.completedTime,
    this.estimatedTime,
  });
}
