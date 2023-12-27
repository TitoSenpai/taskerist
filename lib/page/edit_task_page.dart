import 'package:flutter/material.dart';
import '../db/task_database.dart';
import '../model/task.dart';
import '../widget/task_form.dart';

class AddEditTaskPage extends StatefulWidget {
  final Task? task;

  const AddEditTaskPage({
    super.key,
    this.task,
  });

  @override
  State<AddEditTaskPage> createState() => _AddEditTaskPageState();
}

class _AddEditTaskPageState extends State<AddEditTaskPage> {
  final _formKey = GlobalKey<FormState>();
  late String taskName;
  late String description;
  late String itemNum;
  late String createdTime;

  @override
  void initState() {
    super.initState();
    taskName = widget.task?.taskName ?? '';
    description = widget.task?.description ?? '';
    itemNum = widget.task?.itemNum ?? '';
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          actions: [buildButton()],
        ),
        body: Form(
          key: _formKey,
          child: TaskFormWidget(
            taskName: taskName,
            description: description,
            itemNum: itemNum,
            onChangedtaskName: (taskName) =>
                setState(() => this.taskName = taskName),
            onChangeddescription: (description) =>
                setState(() => this.description = description),
            onChangeditemNum: (itemNum) =>
                setState(() => this.itemNum = itemNum),
          ),
        ),
      );

  Widget buildButton() {
    final isFormValid = taskName.isNotEmpty && description.isNotEmpty;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: isFormValid ? null : Colors.grey.shade700,
        ),
        onPressed: addOrUpdateTask,
        child: const Text('Save'),
      ),
    );
  }

  void addOrUpdateTask() async {
    final isValid = _formKey.currentState!.validate();

    if (isValid) {
      final isUpdating = widget.task != null;

      if (isUpdating) {
        await updateTask();
      } else {
        await addTask();
      }
      if (mounted) {
        Navigator.of(context).pop();
      }
    }
  }

  Future updateTask() async {
    final task = widget.task!.copy(
      taskName: taskName,
      description: description,
    );

    await TaskDatabase.instance.update(task);
  }

  Future addTask() async {
    final task = Task(
      taskName: taskName,
      description: description,
      itemNum: itemNum,
      createdTime: DateTime.now(),
    );

    await TaskDatabase.instance.create(task);
  }
}
