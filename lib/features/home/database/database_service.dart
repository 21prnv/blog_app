import 'package:sqflite/sqflite.dart';

import '../../../model/blog.dart';

class BlogDatabase {
  static const String databaseName = 'blogs.db';
  static const int databaseVersion = 1;

  Database? _database;

  Future<void> open() async {
    if (_database != null) {
      return;
    }

    _database = await openDatabase(
      databaseName,
      version: databaseVersion,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE blogs (
            id TEXT PRIMARY KEY,
            imageUrl TEXT,
            title TEXT
          )
        ''');
      },
    );
  }

  Future<void> close() async {
    if (_database != null) {
      await _database!.close();
      _database = null;
    }
  }

  Future<void> insertBlog(Blog blog) async {
    await _database!.insert('blogs', blog.toJson());
  }

  Future<List<Blog>> getBlogs() async {
    final List<Map<String, dynamic>> maps = await _database!.query('blogs');
    return maps.map((map) => Blog.fromJson(map)).toList();
  }
}
