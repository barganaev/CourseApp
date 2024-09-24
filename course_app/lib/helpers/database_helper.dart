import 'package:course_app/models/course.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';


class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;

  static Database? _database;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'courses.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute(
          'CREATE TABLE courses(id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, subtitle TEXT, description TEXT)',
        );

        await db.insert('courses', Course('Flutter for Beginners', 'Learn the basics of Flutter.', 'Learn the basics of Flutter').toMap());
        await db.insert('courses', Course('Advanced Dart', 'Deep dive into Dart programming.', 'Learn the basics of Flutter').toMap());
        await db.insert('courses', Course('Web Development with Flutter', 'Build responsive web apps.', 'Learn the basics of Flutter').toMap());
      },
    );
  }

  Future<void> insertCourse(Course course) async {
    final db = await database;
    await db.insert(
      'courses',
      course.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Course>> getCourses() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('courses');

    return List.generate(maps.length, (i) {
      return Course(
        maps[i]['title'],
        maps[i]['subtitle'],
        maps[i]['description'],
        id: maps[i]['id']
      );
    });
  }

  Future<void> deleteCourse(int id) async {
    final db = await database;
    await db.delete(
      'courses',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}