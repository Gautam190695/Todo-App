import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/task_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final TextEditingController controller = TextEditingController();
  final ScrollController scroll = ScrollController();

  @override
  void initState() {
    super.initState();

    final provider = Provider.of<TaskProvider>(context, listen: false);
    provider.loadTasks();

    scroll.addListener(() {
      if (scroll.position.pixels == scroll.position.maxScrollExtent) {
        provider.loadMore();
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    scroll.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final tasks = Provider.of<TaskProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Todo App"),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {},
          )
        ],
      ),

      body: ListView.builder(
        controller: scroll,
        itemCount: tasks.tasks.length,
        itemBuilder: (context, index) {

          final t = tasks.tasks[index];

          return ListTile(
            title: Text(
              t.title,
              style: TextStyle(
                decoration:
                    t.completed ? TextDecoration.lineThrough : null,
              ),
            ),

            leading: Checkbox(
              value: t.completed,
              onChanged: (_) => tasks.toggle(t),
            ),

            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [

                // EDIT BUTTON
                IconButton(
                  icon: const Icon(Icons.edit, color: Colors.black),
                  onPressed: () {

                    controller.text = t.title;

                    showDialog(
                      context: context,
                      builder: (_) => AlertDialog(
                        title: const Text("Edit Task"),
                        content: TextField(
                          controller: controller,
                          decoration: const InputDecoration(
                            hintText: "Update task",
                          ),
                        ),
                        actions: [

                          TextButton(
                            onPressed: () {
                              controller.clear();
                              Navigator.pop(context);
                            },
                            child: const Text("Cancel"),
                          ),

                          TextButton(
                            onPressed: () {

                              t.title = controller.text;
                               tasks.updateTask(t);

                              controller.clear();
                              Navigator.pop(context);
                            },
                            child: const Text("Update"),
                          ),
                        ],
                      ),
                    );
                  },
                ),

                // DELETE BUTTON
                IconButton(
                  icon: const Icon(Icons.delete, color: Colors.black),
                  onPressed: () => tasks.delete(t.id),
                ),
              ],
            ),
          );
        },
      ),

      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),

        onPressed: () {

          showDialog(
            context: context,
            builder: (_) => AlertDialog(
              title: const Text("Add Task"),
              content: TextField(
                controller: controller,
                decoration: const InputDecoration(
                  hintText: "Enter task",
                ),
              ),
              actions: [

                TextButton(
                  onPressed: () {
                    controller.clear();
                    Navigator.pop(context);
                  },
                  child: const Text("Cancel"),
                ),

                TextButton(
                  onPressed: () {

                    tasks.addTask(controller.text);

                    controller.clear();
                    Navigator.pop(context);
                  },
                  child: const Text("Add"),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}