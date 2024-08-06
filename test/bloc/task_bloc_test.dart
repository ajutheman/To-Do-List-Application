import 'package:flutter_test/flutter_test.dart';
import 'package:todo_list_app/data/repositories/task_repository_impl.dart';
import 'package:todo_list_app/domain/entities/task_entity.dart';
import 'package:todo_list_app/presentation/bloc/task_bloc.dart';

void main() {
  late TaskBloc taskBloc;
  late TaskRepositoryImpl taskRepository;

  setUp(() {
    taskRepository = TaskRepositoryImpl();
    taskBloc = TaskBloc(taskRepository: taskRepository);
  });

  test('initial state is TaskInitial', () {
    expect(taskBloc.state, TaskInitial());
  });

  test('load tasks', () {
    final task = Task(
      id: '1',
      description: 'Test Task',
      createdTime: DateTime.now(),
    );
    taskRepository.addTask(task);

    taskBloc.add(LoadTasks());

    expect(taskBloc.state, isA<TaskLoadSuccess>());
    final state = taskBloc.state as TaskLoadSuccess;
    expect(state.tasks.length, 1);
    expect(state.tasks.first.description, 'Test Task');
  });

  test('add task', () {
    final task = Task(
      id: '1',
      description: 'Test Task',
      createdTime: DateTime.now(),
    );

    taskBloc.add(AddTask(task));

    expect(taskBloc.state, isA<TaskLoadSuccess>());
    final state = taskBloc.state as TaskLoadSuccess;
    expect(state.tasks.length, 1);
    expect(state.tasks.first.description, 'Test Task');
  });

  test('mark task as completed', () {
    final task = Task(
      id: '1',
      description: 'Test Task',
      createdTime: DateTime.now(),
    );
    taskRepository.addTask(task);

    taskBloc.add(MarkTaskAsCompleted('1'));

    expect(taskBloc.state, isA<TaskLoadSuccess>());
    final state = taskBloc.state as TaskLoadSuccess;
    expect(state.tasks.first.isCompleted, true);
  });

  test('mark task as pending', () {
    final task = Task(
      id: '1',
      description: 'Test Task',
      isCompleted: true,
      createdTime: DateTime.now(),
    );
    taskRepository.addTask(task);

    taskBloc.add(MarkTaskAsPending('1'));

    expect(taskBloc.state, isA<TaskLoadSuccess>());
    final state = taskBloc.state as TaskLoadSuccess;
    expect(state.tasks.first.isCompleted, false);
  });
}
