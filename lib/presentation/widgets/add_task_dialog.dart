import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list_app/domain/entities/task_entity.dart';
import 'package:todo_list_app/presentation/bloc/task_bloc.dart';

import 'duration_picker_dialog.dart';

class AddTaskDialog extends StatefulWidget {
  @override
  _AddTaskDialogState createState() => _AddTaskDialogState();
}

class _AddTaskDialogState extends State<AddTaskDialog> {
  final TextEditingController _controller = TextEditingController();
  bool _isImportant = false;
  Duration? _estimatedTime;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Add Task'),
      content: SingleChildScrollView(
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(hintText: 'Enter task description'),
            ),
            Row(
              children: [
                Checkbox(
                  value: _isImportant,
                  onChanged: (value) {
                    setState(() {
                      _isImportant = value!;
                    });
                  },
                ),
                Text('Important'),
              ],
            ),
            Row(
              children: [
                Text('Estimated Time:'),
                IconButton(
                  icon: Icon(Icons.timer),
                  onPressed: () async {
                    final Duration? result = await showDurationPicker(
                      context: context,
                      initialTime: Duration(minutes: 30),
                    );
                    if (result != null) {
                      setState(() {
                        _estimatedTime = result;
                      });
                    }
                  },
                ),
              ],
            ),
            if (_estimatedTime != null)
              Text(
                  '${_estimatedTime!.inHours}h ${_estimatedTime!.inMinutes % 60}m'),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            if (_controller.text.isNotEmpty) {
              final task = Task(
                id: DateTime.now().toString(),
                description: _controller.text,
                isCompleted: false,
                isImportant: _isImportant,
                createdTime: DateTime.now(),
                estimatedTime: _estimatedTime,
              );
              context.read<TaskBloc>().add(AddTask(task));
              Navigator.of(context).pop();
            }
          },
          child: Text('Add'),
        ),
      ],
    );
  }
}
