# To-Do-List-Application
To-Do List Application
Flutter To-Do List Application
Introduction
This Flutter To-Do List application allows users to manage their tasks efficiently. Users can add tasks, mark them as complete, pending, or important, and categorize them with different colors. The app also displays the creation time, estimated completion time, and real-time updates.

Features
Add Tasks: Create new tasks with a description and categorize them.
Mark Tasks: Mark tasks as complete, pending, or important.
Categorization: Different colors for each category of tasks (Pending, Complete, Ongoing, Important).
Time Display: Show creation time, estimated time to complete, and completion time.
Real-time Updates: Real-time updates to the UI upon task changes.
Installation
Clone the repository:
git clone https://github.com/ajutheman/To-Do-List-Application
cd todo_list_app
Install dependencies:
flutter pub get
Run the app:
flutter run
Project Structure
lib/
├── data/
│   ├── models/
│   │   └── task_model.dart
│   ├── repositories/
│   │   └── task_repository_impl.dart
├── domain/
│   ├── entities/
│   │   └── task_entity.dart
│   ├── repositories/
│   │   └── task_repository.dart
├── presentation/
│   ├── bloc/
│   │   ├── task_bloc.dart
│   │   ├── task_event.dart
│   │   └── task_state.dart
│   ├── pages/
│   │   └── task_list.dart
│   └── widgets/
│       ├── add_task_dialog.dart
│       └── duration_picker_dialog.dart
├── main.dart



Usage
Adding a Task
Tap the "Add Task" button.
Enter the task description.
Select the category and estimated time to complete the task.
Tap "Save".
Marking a Task
Swipe left or right on the task item.
Choose the appropriate action (Complete, Pending, Important).
Viewing Task Details
Tap on a task to view its details.
The task details page shows the creation time, estimated time to complete, and completion time.
Screenshots
Add screenshots here if available.

Running Tests
To run the unit tests for the Bloc logic:

sh
Copy code
flutter test
Dependencies
flutter_bloc: For state management.
provider: For dependency injection.
intl: For date formatting.
duration_picker: For selecting task duration.
Contributing
If you want to contribute to this project, please follow these steps:

Fork the repository.
Create a new branch (git checkout -b feature/your-feature).
Commit your changes (git commit -am 'Add your feature').
Push to the branch (git push origin feature/your-feature).
Create a new Pull Request.

License
This project is licensed under the MIT License - see the LICENSE file for details.

Contact
If you have any questions or suggestions, please contact:

Your Name - https://github.com/ajutheman/To-Do-List-Application
GitHub: ajutheman
