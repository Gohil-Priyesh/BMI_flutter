import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart' as sql;

class SQLHelper {
  // For creating Table
  static Future<void> createTable(sql.Database database) async {
    await database.execute("""CREATE TABLE item(
      id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      Username TEXT,
      Password TEXT,
      Email TEXT,
      createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
    )""");
  }

  static Future<sql.Database> db() async {
    return sql.openDatabase(
      'dbAuth.db',
      version: 1,
      onCreate: (sql.Database database, int version) async {
        await createTable(database);
      },
    );
  }

  // For creating an item in the database
  static Future<int> createItem(String Username, String? Password, String? Email) async {
    final db = await SQLHelper.db();
    final data = {'Username': Username, 'Password': Password, 'Email': Email};
    final id = await db.insert('item', data, conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }

  // For getting all items from the database
  static Future<List<Map<String, dynamic>>> getItems() async {
    final db = await SQLHelper.db();
    return db.query('item', orderBy: "id");
  }

  // For getting specific data from the database using id
  static Future<List<Map<String, dynamic>>> getItem(int id) async {
    final db = await SQLHelper.db();
    return db.query('item', where: "id = ?", whereArgs: [id], limit: 1);
  }

  // Update an item by id
  static Future<int> updateItem(int id, String Username, String? Password, String? Email) async {
    final db = await SQLHelper.db();

    final data = {
      'Email': Email,
      'Username': Username,
      'Password': Password,
      'createdAt': DateTime.now().toString()
    };

    final result = await db.update('item', data, where: "id = ?", whereArgs: [id]);
    return result;
  }

  // Delete an item by id
  static Future<void> deleteItem(int id) async {
    final db = await SQLHelper.db();
    try {
      await db.delete("item", where: "id = ?", whereArgs: [id]);
    } catch (err) {
      debugPrint("Something went wrong when deleting an item: $err");
    }
  }

  // Authentication
  static Future<bool> authenticate(String Username, String Password) async {
    final db = await SQLHelper.db();
    final List<Map<String, dynamic>> result = await db.query(
      'item',
      where: 'Username = ? AND Password = ?',
      whereArgs: [Username, Password],
    );
    return result.isNotEmpty;
  }

}
