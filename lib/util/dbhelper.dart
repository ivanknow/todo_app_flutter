import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:todo_app/model/todo.dart';

class DBHelper {
  String dbTableName = "tb_todo";
  String colId = "id";
  String colTitile = "title";
  String colDesc = "description";
  String colPriority = "priority";
  String colDate = "date";

  static final DBHelper _dbHelper = new DBHelper._internal();
  DBHelper._internal();

  factory DBHelper() {
    return _dbHelper;
  }

  Future<Database> initDB() async {
    Directory dir = await getApplicationDocumentsDirectory();
    String path = dir.path + "todo.db";
    var dbTodos = await openDatabase(path, version: 1, onCreate: _createDB);
    return dbTodos;
  }

  void _createDB(Database db, int newVersion) async {
    await db.execute("CREATE TABLE IF NOT EXISTS  $dbTableName(" +
        "$colId INTEGER PRIMARY KEY," +
        "$colTitile TEXT," +
        "$colDesc TEXT," +
        "$colPriority INTEGER," +
        "$colDate TEXT)");
  }

  static Database _db;

  Future<Database> get db async {
    if (_db == null) _db = await initDB();

    return _db;
  }

  Future<int> insert(Todo todo) async {
    Database db = await this.db;
    var result = await db.insert(dbTableName, todo.toMap());
    return result;
  }

  Future<List> getTodoItems() async {
    Database db = await this.db;
    var result =
        await db.rawQuery("select * from $dbTableName order by $colPriority");
    return result;
  }

  Future<int> getCount() async {
    Database db = await this.db;
    var result = await Sqflite.firstIntValue(
        await db.rawQuery("select count(*) from $dbTableName"));
    return result;
  }

  Future<int> update(Todo todo) async {
    Database db = await this.db;
    var result = await db.update(dbTableName, todo.toMap(),
        where: "$colId = ?", whereArgs: [todo.id]);
    return result;
  }

  Future<int> delete(int id) async {
    Database db = await this.db;
    var result =
        await db.rawDelete("delete from $dbTableName where $colId = $id");
    return result;
  }
}
