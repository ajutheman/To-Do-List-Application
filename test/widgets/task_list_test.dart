import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:todo_list_app/presentation/pages/task_list.dart';

void main() {
  testWidgets('Add Task', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: TaskList()));

    // Verify that the app shows the task list
    expect(find.text('To-Do List'), findsOneWidget);

    // Tap the add button
    await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle();

    // Enter the task description
    await tester.enterText(find.byType(TextField), 'New Task');
    await tester.tap(find.text('Add'));
    await tester.pumpAndSettle();

    // Verify the new task appears in the list
    expect(find.text('New Task'), findsOneWidget);
  });
}
