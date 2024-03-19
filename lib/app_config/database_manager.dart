import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../model/resume_model.dart';
import '../model/work_experience_model.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper.internal();

  factory DatabaseHelper() => _instance;

  DatabaseHelper.internal();

  static Database? _database;

  static const _tableName = 'resumes';
  static const _columnId = 'id';
  static const _columnName = 'name';
  static const _columnEmail = 'email';
  static const _columnPhoneNumber = 'phoneNumber';
  static const _columnWorkExperience = 'workExperiences';
  static const _columnImagePath = 'imagePath';

  Future<Database?> get database async {
    if (_database != null) return _database;

    _database = await _initDatabase();
    return _database;
  }

  Future<Database> _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'resumes.db');
    return await openDatabase(path, version: 1, onCreate: _createDb);
  }

  void _createDb(Database db, int newVersion) async {
    await db.execute('''
       CREATE TABLE $_tableName (
        $_columnId INTEGER PRIMARY KEY,
        $_columnName TEXT,
        $_columnEmail TEXT,
        $_columnPhoneNumber TEXT,
        $_columnImagePath TEXT,
        $_columnWorkExperience TEXT
      )
    ''');
  }

  Future<void> clearDatabase() async {
    Database? db = await database;
    await db?.delete('resumes');
    // await db?.delete(workExperienceTable);
  }

  Future<int?> insertResume(Resume resume) async {
    Database? db = await database;
    return await db?.insert(_tableName, resume.toMap());
  }

  Future<List<Resume>> getResumes() async {
    Database? db = await database;
    List<Map<String, dynamic>>? maps = await db?.query(_tableName);
    return List.generate(maps!.length, (i) {
      return Resume(
        id: maps[i]['id'] as int,
        name: maps[i]['name'] as String,
        email: maps[i]['email'] as String,
        phoneNumber: maps[i]['phoneNumber'] as String,
        imagePath: maps[i]['imagePath'] as String,
        workExperiences:
            (jsonDecode(maps[i]['workExperiences']) as List<dynamic>)
                .map<WorkExperience>((e) => WorkExperience(
                      company: e['company'] as String,
                      position: e['position'] as String,
                      startDate: e['startDate'] as String,
                      endDate: e['endDate'] as String,
                    ))
                .toList(),
      );
    });
  }

  Future<void> updateResume(Resume resume) async {
    Database? db = await database;
    await db?.update(
      _tableName,
      resume.toMap(),
      where: '$_columnId = ?',
      whereArgs: [resume.id],
    );
  }

  Future<void> deleteResume(int id) async {
    Database? db = await database;
    await db?.delete(
      _tableName,
      where: '$_columnId = ?',
      whereArgs: [id],
    );
  }
}
