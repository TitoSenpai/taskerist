import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../model/task.dart';

class TaskDatabase {
  static final TaskDatabase instance = TaskDatabase._init();

  static Database? _database;

  TaskDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('task.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
      onConfigure: (db) => db.execute('PRAGMA foreign_keys = ON'),
      onUpgrade: (db, oldVersion, newVersion) {
        // Add migration logic here
      },
    );
  }

  Future _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT NOT NULL';

    await db.execute('''
CREATE TABLE $tableTask ( 
  ${TaskFields.id} $idType, 
  ${TaskFields.taskName} $textType,
  ${TaskFields.description} $textType,
  ${TaskFields.itemNum} $textType,
  ${TaskFields.time} $textType
  
  )
''');
  }

  Future<Task> create(Task task) async {
    final db = await instance.database;
    try {
      final id = await db.insert(tableTask, task.toJson());
      return task.copy(id: id);
    } catch (e) {
      throw Exception('Failed to insert task: $e');
    }
  }

  Future<Task> readTask(int id) async {
    final db = await instance.database;

    try {
      final maps = await db.query(
        tableTask,
        columns: TaskFields.values,
        where: '${TaskFields.id} = ?',
        whereArgs: [id],
      );

      if (maps.isNotEmpty) {
        return Task.fromJson(maps.first);
      } else {
        throw Exception('ID $id not found');
      }
    } catch (e) {
      throw Exception('Failed to read task: $e');
    }
  }

  Future<List<Task>> readAllTask() async {
    final db = await instance.database;
    try {
      const orderBy = '${TaskFields.time} ASC';
      final result = await db.query(tableTask, orderBy: orderBy);
      return result.map((json) => Task.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Failed to read all tasks: $e');
    }
  }

  Future<int> update(Task task) async {
    final db = await instance.database;
    try {
      return db.update(
        tableTask,
        task.toJson(),
        where: '${TaskFields.id} = ?',
        whereArgs: [task.id],
      );
    } catch (e) {
      throw Exception('Failed to update task: $e');
    }
  }

  Future<int> delete(int id) async {
    final db = await instance.database;
    try {
      return await db.delete(
        tableTask,
        where: '${TaskFields.id} = ?',
        whereArgs: [id],
      );
    } catch (e) {
      throw Exception('Failed to delete task: $e');
    }
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}