
import 'package:flutter/material.dart';
import 'package:flutter_app_favourite_cmbntn/model/fav_photo.dart';
import 'package:flutter_app_favourite_cmbntn/model/photo.dart';
import 'package:flutter_app_favourite_cmbntn/utils/utility.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:io' as io;
import 'package:path/path.dart';

class DBHelper {
  static Database _db;
  static const String ID = 'id';
  static const String NAME = 'photo_name';
  static const String TOPNAME = 'topphoto_name';
  static const String BTMNAME = 'btmphoto_name';
  static const String WEAR = 'wear';
  static const String SAVED = 'saved';
  static const String TABLE = 'PhotosTable';
  static const String RANDOMTABLE = 'RandomPhotosTable';
  static const String FAVTABLE = 'favPhotosTable';
  static const String DB_NAME = 'photos.db';


  Future<Database> get db async {
    if (null != _db) {
      return _db;
    }
    _db = await initDb();
    return _db;
  }

  initDb() async {
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, DB_NAME);
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  _onCreate(Database db, int version) async {
    await db.execute("CREATE TABLE $TABLE ($ID INTEGER PRIMARY KEY AUTOINCREMENT, $NAME TEXT, $SAVED TEXT, $WEAR TEXT)");
    await db.execute("CREATE TABLE $FAVTABLE ($ID INTEGER PRIMARY KEY AUTOINCREMENT, $TOPNAME TEXT, $BTMNAME TEXT, $SAVED TEXT, $WEAR TEXT)");
    await db.execute("CREATE TABLE $RANDOMTABLE ($ID INTEGER PRIMARY KEY AUTOINCREMENT, $TOPNAME TEXT, $BTMNAME TEXT, $SAVED TEXT, $WEAR TEXT)");
  }

  Future<Photo> save(Photo employee) async {
    var dbClient = await db;
    employee.id = await dbClient.insert(TABLE, employee.toMap());
    print("Photo.toMap${employee.saved}");
    return employee;
  }

  Future<FavPhoto> saveFav(FavPhoto employee) async {
    var dbClient = await db;
    employee.id = await dbClient.insert(FAVTABLE, employee.toMap());
    print("Photo.toMap${employee.saved}");
    return employee;
  }


  Future<FavPhoto> saveRandom(FavPhoto employee) async {
    var dbClient = await db;
    employee.id = await dbClient.insert(RANDOMTABLE, employee.toMap());
    print("Photo.toMap${employee.saved}");
    return employee;
  }

  Future<int> update(Photo employe) async {
    print("isSaved${employe.saved}");
    var dbClient = await db;
    print("Photo.update${employe.saved}");
    return await dbClient
        .update(TABLE, employe.toMap(), where: '$ID = ?', whereArgs: [employe.id]);
  }

  Future<int> delete(int id) async {
    var dbClient = await db;
    return await dbClient.delete(TABLE, where: '$ID = ?', whereArgs: [id]);
  }

  Future<List<Photo>> getPhotos() async {
    var dbClient = await db;
    List<Map> maps = await dbClient.query(TABLE, columns: [ID, NAME,SAVED,WEAR]);
    List<Photo> employees = [];
    if (maps.length > 0) {
      for (int i = 0; i < maps.length; i++) {
        employees.add(Photo.fromMap(maps[i]));
        print("Photo.fromMap${Photo.fromMap(maps[i]).saved}");
      }
    }
    return employees;
  }


  Future<List<FavPhoto>> getfavPhotos() async {
    var dbClient = await db;
    List<Map> maps = await dbClient.query(FAVTABLE, columns: [ID, TOPNAME,BTMNAME,SAVED,WEAR]);
    List<FavPhoto> employees = [];
    if (maps.length > 0) {
      for (int i = 0; i < maps.length; i++) {
        employees.add(FavPhoto.fromMap(maps[i]));
        print("Photo.fromMap${FavPhoto.fromMap(maps[i]).saved}");
      }
    }
    return employees;
  }


  Future<List<FavPhoto>> getRandomPhotos() async {
    var dbClient = await db;
    List<Map> maps = await dbClient.query(RANDOMTABLE, columns: [ID, TOPNAME,BTMNAME,SAVED,WEAR]);
    List<FavPhoto> employees = [];
    if (maps.length > 0) {
      for (int i = 0; i < maps.length; i++) {
        employees.add(FavPhoto.fromMap(maps[i]));
        print("Photo.fromMap${FavPhoto.fromMap(maps[i]).saved}");
      }
    }
    return employees;
  }

  Future close() async {
    var dbClient = await db;
    dbClient.close();
  }
}
