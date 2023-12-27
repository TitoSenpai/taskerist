import 'package:flutter/material.dart';

const List<String> list = <String>['Ongoing', 'Ready', 'Finished'];

class TaskFormWidget extends StatelessWidget {
  // final bool? isImportant;
  // final int? number;
  final String? taskName;
  final String? description;
  final String? itemNum;
// final ValueChanged<bool> onChangedImportant;
//  final ValueChanged<int> onChangedNumber;
  final ValueChanged<String> onChangedtaskName;
  final ValueChanged<String> onChangeddescription;
  final ValueChanged<String> onChangeditemNum;

  const TaskFormWidget({
    super.key,
    //this.isImportant = false,
    //   this.number = 0,
    this.taskName = '',
    this.description = '',
    this.itemNum = '',
    // required this.onChangedImportant,
    // required this.onChangedNumber,
    required this.onChangedtaskName,
    required this.onChangeddescription,
    required this.onChangeditemNum,
  });

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Row(
                children: [
                  //  const DropdownMenuExample(),
                  //  Switch(
                  //    value: isImportant ?? false,
                  //    onChanged: onChangedImportant,
                  //  ),
                  //Expanded(
                  //  child: Slider(
                  //    value: (number ?? 0).toDouble(),
                  //    min: 0,
                  //    max: 5,
                  //    divisions: 5,
                  //    onChanged: (number) => onChangedNumber(number.toInt()),
                  //  ),
                  //)
                ],
              ),
              buildTitle(),
              const SizedBox(height: 4),
              buildConstNum(),
              const SizedBox(height: 16),
            ],
          ),
        ),
      );

  Widget buildTitle() => TextFormField(
        maxLines: 1,
        initialValue: taskName,
        style: const TextStyle(
          color: Colors.white70,
          fontWeight: FontWeight.bold,
          fontSize: 24,
        ),
        decoration: const InputDecoration(
          // border: InputBorder.none,
          border: OutlineInputBorder(),
          hintText: 'Task',
          hintStyle: TextStyle(color: Colors.white70),
        ),
        validator: (taskName) => taskName != null && taskName.isEmpty
            ? 'Task cannot be empty'
            : null,
        onChanged: onChangedtaskName,
      );

  Widget buildConstNum() => TextFormField(
        maxLines: 5,
        initialValue: description,
        style: const TextStyle(color: Colors.white60, fontSize: 18),
        decoration: const InputDecoration(
          border: InputBorder.none,
          hintText: 'Type something...',
          hintStyle: TextStyle(color: Colors.white60),
        ),
        validator: (description) => description != null && description.isEmpty
            ? 'The description cannot be empty'
            : null,
        onChanged: onChangeddescription,
      );
}

class DropdownMenuExample extends StatefulWidget {
  const DropdownMenuExample({super.key});

  @override
  State<DropdownMenuExample> createState() => _DropdownMenuExampleState();
}

class _DropdownMenuExampleState extends State<DropdownMenuExample> {
  String dropdownValue = list.first;

  @override
  Widget build(BuildContext context) {
    return DropdownMenu<String>(
      initialSelection: list.first,
      onSelected: (String? value) {
        // This is called when the user selects an item.
        setState(() {
          dropdownValue = value!;
        });
      },
      dropdownMenuEntries: list.map<DropdownMenuEntry<String>>((String value) {
        return DropdownMenuEntry<String>(value: value, label: value);
      }).toList(),
    );
  }
}
