import 'package:mvc_categories/database/db_provider.dart';
import 'package:mvc_categories/helpers/helpers.dart';
import 'package:sqflite/sqflite.dart';

class CategoryModel {
  static const String table = 'categories';
  static const String columnId = 'id';
  static const String columnName = 'name';

  static Future<void> createTable(Database db) async {
    await db.execute('DROP TABLE IF EXISTS $table');
    await db.execute('''
    CREATE TABLE $table ( 
      $columnId INTEGER PRIMARY KEY AUTOINCREMENT, 
      $columnName TEXT NOT NULL)
    ''');
  }

  static Future<Categoria?> getCategory(int id) async {
    final db = await DBProvider.db.database;
    List<Map<String, dynamic>> resp = await db.query(
      table,
      where: '$columnId = ?',
      whereArgs: [id],
    );
    if (resp.isEmpty) return null;
    return Categoria.fromMap(resp.first);
  }

  static Future<List<Categoria>> getAllCategories() async {
    final db = await DBProvider.db.database;
    List<Categoria> list = [];
    List<Map<String, dynamic>> resp = await db.query(table);
    if (resp.isEmpty) return list;
    list = resp.map((category) => Categoria.fromMap(category)).toList();

    return list;
  }

  static Future<Categoria?> createCategory({required String name}) async {
    final db = await DBProvider.db.database;
    final id = await db.insert(table, {'name': name});
    if (id == 0) return null;
    return await getCategory(id);
  }

  static Future<bool> editCategory({
    required int id,
    required String name,
  }) async {
    final db = await DBProvider.db.database;
    final res = await db.update(
      table,
      {'name': name},
      where: '$columnId = ?',
      whereArgs: [id],
    );
    if (res == 0) return false;
    return true;
  }

  static Future<bool> deleteCategory({required int id}) async {
    final db = await DBProvider.db.database;
    final res = await db.delete(
      table,
      where: '$columnId = ?',
      whereArgs: [id],
    );
    if (res == 0) return false;
    return true;
  }
}
