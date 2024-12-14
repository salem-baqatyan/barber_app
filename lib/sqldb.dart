import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
//import 'package:provider/provider.dart';

class SqlDb extends ChangeNotifier{

  static Database? _db;
  Future<Database?> get db async{
    if(_db == null){
      _db = await intialDb();
      return _db;
    }
    else{
      return _db;
    }
  }

  intialDb() async{
    String databasepath = await getDatabasesPath();
    String path = join(databasepath,'barber.db');
    Database mydb = await openDatabase(path, onCreate: _onCreate ,version: 2 ,onUpgrade: _onUpgrade);
    return mydb;
  }
  _onCreate(Database db, int version)async{
    Batch batch = db.batch();
    batch.execute('''
      CREATE TABLE "queue" (
        "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, 
        "name" TEXT NOT NULL, 
        "phone" TEXT)
''');
    await batch.commit();
    print('Create Database and Table ====================');
  }

  _onUpgrade(Database db, int oldversion, int newversion)async{

  }

  mydeleteDatabase()async{
    String databasepath = await getDatabasesPath();
    String path = join(databasepath,'queue_barber.db');
    await deleteDatabase(path);
  }

  readData(String sql) async{
    Database? mydb = await db;
    List<Map> response = await mydb!.rawQuery(sql);
    notifyListeners();
    return response;
  }
  insertData(String sql) async{
    Database? mydb = await db;
    int response = await mydb!.rawInsert(sql);
    return response;
  }
  updateData(String sql) async{
    Database? mydb = await db;
    int response = await mydb!.rawUpdate(sql);
    return response;
  }
  deleteData(String sql) async{
    Database? mydb = await db;
    int response = await mydb!.rawDelete(sql);
    return response;
  }


}