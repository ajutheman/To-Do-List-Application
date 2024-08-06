import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:todo_list_app/domain/entities/task_status.dart';
import 'package:todo_list_app/presentation/bloc/task_bloc.dart';
import 'package:todo_list_app/presentation/widgets/add_task_dialog.dart';

class TaskList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('To-Do List'),
        actions: [
          PopupMenuButton<TaskStatus>(
            onSelected: (status) {
              context.read<TaskBloc>().add(FilterTasks(status));
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                value: TaskStatus.all,
                child: Text('All'),
              ),
              PopupMenuItem(
                value: TaskStatus.completed,
                child: Text('Completed'),
              ),
              PopupMenuItem(
                value: TaskStatus.pending,
                child: Text('Pending'),
              ),
              PopupMenuItem(
                value: TaskStatus.ongoing,
                child: Text('Ongoing'),
              ),
              PopupMenuItem(
                value: TaskStatus.important,
                child: Text('Important'),
              ),
            ],
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<TaskBloc, TaskState>(
          builder: (context, state) {
            if (state is TaskLoadSuccess || state is TaskFilterSuccess) {
              final tasks = state is TaskLoadSuccess
                  ? state.tasks
                  : (state as TaskFilterSuccess).tasks;

              return ListView.builder(
                itemCount: tasks.length,
                itemBuilder: (context, index) {
                  final task = tasks[index];

                  Color taskColor;
                  if (task.isImportant) {
                    taskColor = Colors.red;
                  } else if (task.isCompleted) {
                    taskColor = Colors.green;
                  } else if (task.estimatedTime != null &&
                      DateTime.now().difference(task.createdTime) >
                          task.estimatedTime!) {
                    taskColor = Colors.orange;
                  } else {
                    taskColor = Colors.blue;
                  }

                  return Card(
                    color: taskColor.withOpacity(0.2),
                    margin: EdgeInsets.symmetric(vertical: 8.0),
                    child: ListTile(
                      title: Text(task.description),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(task.isCompleted
                              ? 'Completed on: ${DateFormat.yMMMd().add_jm().format(task.completedTime!)}'
                              : 'Created on: ${DateFormat.yMMMd().add_jm().format(task.createdTime)}'),
                          if (task.estimatedTime != null)
                            Text(
                                'Estimated Time: ${task.estimatedTime!.inHours}h ${task.estimatedTime!.inMinutes % 60}m'),
                        ],
                      ),
                      trailing: Checkbox(
                        value: task.isCompleted,
                        onChanged: (_) {
                          if (task.isCompleted) {
                            context
                                .read<TaskBloc>()
                                .add(MarkTaskAsPending(task.id));
                          } else {
                            context
                                .read<TaskBloc>()
                                .add(MarkTaskAsCompleted(task.id));
                          }
                        },
                      ),
                      onLongPress: () {
                        context.read<TaskBloc>().add(DeleteTask(task.id));
                      },
                    ),
                  );
                },
              );
            } else if (state is TaskLoadFailure) {
              return Center(child: Text('Failed to load tasks'));
            }

            return Center(child: CircularProgressIndicator());
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return BlocProvider.value(
                value: context.read<TaskBloc>(),
                child: AddTaskDialog(),
              );
            },
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
