import 'package:sqflite/sqflite.dart';

class database {
  static Future<void> createData(Database database) async {
    await database.execute('''CREATE TABLE data(
      id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      title TEXT,
      desc TEXT,
      date DateTime DEFAULT CURRENT_TIMESTAMP
    )''');
  }

  static Future<Database> db() async {
    return openDatabase(
      "database_name.db",
      version: 1,
      onCreate: (Database database, int version) async {
        await createData(database);
      },
    );
  }

  static Future<int> records(String title, String? desc) async {
    final db = await database.db();
    final data = {
      "title": title,
      "desc": desc,
      "date": DateTime.now().toString(),
    };
    final id = await db.insert("data", data,
        conflictAlgorithm: ConflictAlgorithm.replace);

    return id;
  }

  static Future<List<Map<String, dynamic>>> getData() async {
    final db = await database.db();

    return db.query("data", orderBy: "id");
  }

  static Future<List<Map<String, dynamic>>> singleData(int id) async {
    final db = await database.db();

    return db.query("data", where: "id=?", whereArgs: [id], limit: 1);
  }

  static Future<int> update_record(int id, String title, String? desc) async {
    final db = await database.db();
    final data = {
      "title": title,
      "desc": desc,
      "date": DateTime.now().toString(),
    };
    final result =
        await db.update("data", data, where: "id=?", whereArgs: [id]);

    return result;
  }

  static Future<void> delete_record(int id) async {
    final db = await database.db();
    try {
      await db.delete("data", where: "id=?", whereArgs: [id]);
    } catch (e) {
      print(e);
    }
  }
}
