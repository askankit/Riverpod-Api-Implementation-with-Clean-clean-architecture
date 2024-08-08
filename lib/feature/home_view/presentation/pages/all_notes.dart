import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:to_do_application/core/routing/routes.dart';

import '../providers/tasks_provider.dart';

class AllListScreen extends ConsumerWidget {
  const AllListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localStorage = ref.watch(localStorageProvider);
    final getTasks = ref.watch(getTasksProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Task List'),
        centerTitle: true,
      ),
      bottomNavigationBar: GestureDetector(
        onTap: (){
          context.push(Routes.photos);
        },
        child: Container(
          height:60,
          decoration: BoxDecoration(
            color: Colors.yellow
          ),
          child: Center(child: Text("GO TO API PAGE")),
        ),
      ),

      body: getTasks.when(
          data: (tasks) => ListView.builder(
                itemCount: tasks.length,
                itemBuilder: (context, index) {
                  final task = tasks[index];
                  return ListTile(
                    title: Text(task),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () async {
                        await localStorage.deleteTask(task);
                        ref.refresh(getTasksProvider.future);
                      },
                    ),
                  );
                },
              ),
          error: (e, s) => Center(child: Text('Error: $e')),
          loading: () => const Center(child: CircularProgressIndicator())),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final res = await showDialog(
            context: context,
            builder: (context) => const MultiLineTextFieldDialog(),
          );
          if (res != null) {
            await localStorage.addToList(res);
            ref.refresh(getTasksProvider.future);
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class MultiLineTextFieldDialog extends StatelessWidget {
  const MultiLineTextFieldDialog({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController();

    return AlertDialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 30),
      title: const Text('Enter your text'),
      content: TextField(
        controller: controller,
        maxLines: 5,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          hintText: 'Enter your text here',
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            // Handle save or submit action
            print(controller.text);
            Navigator.of(context).pop(controller.text.trim());
          },
          child: const Text('Submit'),
        ),
      ],
    );
  }
}
