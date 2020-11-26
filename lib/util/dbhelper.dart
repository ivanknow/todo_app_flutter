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
    var dbTodos = await openDatabase(path, version: 1, onCreate: _createDB;
    return dbTodos;
  }

  void _createDB(Database db, int newVersion) async {
    await db.execute("create database $dbTableName("
    +"$colId INTEGER PRIMARY KEY,"
    +"$colTitile TEXT,"
    +"$colTitile TEXT,"
    +"$colPriority INTEGER,"
    +"$colDate TEXT"
    +";"
    );
  }

  static Database _db;

  Future<Database> get db async{
    if(_db == null)
    _db = await initDB();

    return _db;
  }
}
