import 'package:hive_flutter/hive_flutter.dart';

abstract class HiveConstants {
  static const String task = "tasks";
  static const String tasksBox = "tasksBox";
}

abstract class LocalStorage {
  Future<void> addToList(String newTask);
  Future<void> removeFromList(String newTask);
  Future<void> deleteAllTasks();
  Future<void> deleteTask(String taskToDelete);
  Future<List<String>> getAllTasks();
}

class LocalStorageImpl extends LocalStorage {
  final Box taskBox;
  LocalStorageImpl({required this.taskBox});

  @override
  Future<void> addToList(String newTask) async {
    await taskBox.add(newTask);
  }

  @override
  Future<void> removeFromList(String newTask) async {
    final List<String> tasks = await getAllTasks();
    final index = tasks.indexOf(newTask);
    if (index != -1) {
      await taskBox.deleteAt(index);
    }
  }

  @override
  Future<void> deleteAllTasks() async {
    await taskBox.clear();
  }

  @override
  Future<void> deleteTask(String taskToDelete) async {
    final List<String> tasks = await getAllTasks();
    final index = tasks.indexOf(taskToDelete);
    if (index != -1) {
      await taskBox.deleteAt(index);
    }
  }

  @override
  Future<List<String>> getAllTasks() async {
    return taskBox.values.cast<String>().toList();
  }

  static Future<LocalStorage> init() async {
    return LocalStorageImpl(
      taskBox: await Hive.openBox(HiveConstants.tasksBox),
    );
  }
}
