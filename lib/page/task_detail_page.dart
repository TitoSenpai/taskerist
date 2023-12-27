import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
import '../db/task_database.dart';
import '../model/task.dart';
import '../page/edit_task_page.dart';

class TaskDetailPage extends StatefulWidget {
  final int taskId;

  const TaskDetailPage({
    super.key,
    required this.taskId,
  });

  @override
  State<TaskDetailPage> createState() => _TaskDetailPageState();
}

class _TaskDetailPageState extends State<TaskDetailPage> {
  late Task task;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    refreshTask();
  }

  Future refreshTask() async {
    setState(() => isLoading = true);

    task = await TaskDatabase.instance.readTask(widget.taskId);

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          actions: [reportButton(), editButton(), deleteButton()],
        ),
        body: isLoading
            ? const Center(child: CircularProgressIndicator())
            : Padding(
                padding: const EdgeInsets.all(12),
                child: ListView(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  children: [
                    Text(
                      task.taskName,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    // Text(
                    //   DateFormat.yMMMd().format(task.createdTime),
                    //    style: const TextStyle(color: Colors.white38),
                    //  ),
                    const SizedBox(height: 8),
                    Text(
                      task.description,
                      style: const TextStyle(color: Colors.white, fontSize: 18),
                    )
                  ],
                ),
              ),
      );

  Widget editButton() => IconButton(
      icon: const Icon(Icons.edit_outlined),
      onPressed: () async {
        if (isLoading) return;

        await Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => AddEditTaskPage(task: task),
        ));

        refreshTask();
      });

  Widget reportButton() => IconButton(
        icon: const Icon(Icons.add),
        onPressed: () async {},
      );

  Widget deleteButton() => IconButton(
        icon: const Icon(Icons.delete),
        onPressed: () async {
          await TaskDatabase.instance.delete(widget.taskId);

          if (mounted) {
            Navigator.of(context).pop();
          }
        },
      );
}
