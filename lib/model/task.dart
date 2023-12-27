const String tableTask = 'task';

class TaskFields {
  static final List<String> values = [
    /// Add all fields
    id, taskName, description, itemNum,
    //status
  ];

  static const String id = '_id';
  static const String taskName = 'taskName';
  static const String description = 'description';
  static const String itemNum = 'itemNum';
  static const String time = 'time';
  //static const String status = 'status';
}

class Task {
  final int? id;
  final String taskName;

  // final String status;
  final String itemNum;
  final String description;
   final DateTime createdTime;

  const Task({
    this.id,
    required this.taskName,
    required this.description,
    required this.createdTime,
    required this.itemNum,
    //required this.status,
  });

  Task copy({
    int? id,
    String? taskName,
    String? description,
    String? itemNum,
    //String? status,
    //bool? isImportant,
    // int? number,
     DateTime? createdTime,
  }) =>
      Task(
        id: id ?? this.id,
        taskName: taskName ?? this.taskName,

        itemNum: itemNum ?? this.itemNum,
        //status: status ?? this.status,
        //  isImportant: isImportant ?? this.isImportant,

          description: description ?? this.description,
          createdTime: createdTime ?? this.createdTime,
      );

  static Task fromJson(Map<String, Object?> json) => Task(
        id: json[TaskFields.id] as int?,
        taskName: json[TaskFields.taskName] as String,
    description: json[TaskFields.description] as String,
        itemNum: json[TaskFields.itemNum] as String,

         createdTime: DateTime.parse(json[TaskFields.time] as String),
      );

  Map<String, Object?> toJson() => {
    TaskFields.id: id,
    TaskFields.taskName: taskName,
    TaskFields.description: description,
    TaskFields.itemNum: itemNum,
    TaskFields.time: createdTime.toIso8601String(),
      };
}
