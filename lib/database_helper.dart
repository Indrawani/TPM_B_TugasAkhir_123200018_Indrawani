import 'dart:async';
import 'package:path/path.dart';
import 'package:project_akhir_tpm_teori/user_model.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static Database? _database;
  static const String _dbName = 'my_database.db';
  static const String _userTable = 'user';

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    _database = await initializeDatabase();
    return _database!;
  }

  Future<Database> initializeDatabase() async {
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, _dbName);

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute(
          '''
          CREATE TABLE $_userTable(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            username TEXT,
            password TEXT
          )
          ''',
        );
      },
    );
  }

  Future<void> insertUser(User user) async {
    final db = await database;
    await db.insert(
      _userTable,
      user.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<User>> getUsers() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(_userTable);
    return List.generate(maps.length, (index) {
      return User(
        id: maps[index]['id'],
        username: maps[index]['username'],
        password: maps[index]['password'],
      );
    });
  }
}
