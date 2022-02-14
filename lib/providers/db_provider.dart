// Crearem en nostre propi "singleton" per a tenir una sola instància
// i la idea és que es igual d'on accedim, que accedirem a aquesta.

import 'dart:io';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

import 'package:qr_scan/models/scan_model.dart';
export 'package:qr_scan/models/scan_model.dart';

class DBProvider {
  static Database? _database;
  // Contructor privat del singleton
  static final DBProvider db = DBProvider._();

  DBProvider._();

  Future<Database> get database async {
    if (_database == null) _database = await initDB();

    return _database!;
  }

  Future<Database> initDB() async {
    // Path de la BBDD
    Directory documentsDirectory = await getApplicationDocumentsDirectory();

    final path = join(documentsDirectory.path, 'ScansDB.db');

    print(path);

    // Creació de la BBDD
    return await openDatabase(
      path,
      version: 1,
      onOpen: (db) {},
      onCreate: (Database db, int version) async {
        await db.execute('''
          CREATE TABLE Scans(
            id INTEGER PRIMARY KEY,
            tipo TEXT,
            valor TEXT
          );
        ''');
      },
    );
  }

  Future<int> insertRawScan(ScanModel nuevoScan) async {
    final id = nuevoScan.id;
    final tipo = nuevoScan.tipus;
    final valor = nuevoScan.valor;

    final db = await database;

    final res = await db.rawInsert('''
      INSERT INTO Scans( id, tipo, valor )
        VALUES( $id, $tipo, $valor )
    ''');

    return res;
  }

  Future<int> inserScan(ScanModel nuevoScan) async {
    final db = await database;

    final res = await db.insert('Scans', nuevoScan.toJson());

    // res = id de la tupla insertada
    return res;
  }

  Future<ScanModel?> getScanById(int id) async {
    final db = await database;
    final res = await db.query('Scans', where: 'id = ?', whereArgs: [id]);

    if (res.isNotEmpty) {
      return ScanModel.fromJson(res.first);
    } else {
      return null;
    }
  }

  Future<List<ScanModel>?> getAllScans() async {
    final db = await database;
    final res = await db.query('Scans');

    return res.isNotEmpty
        ? res.map((e) => ScanModel.fromJson(res.first)).toList()
        : [];
  }

  Future<List<ScanModel>?> getScansPerTipus(String tipus) async {
    final db = await database;
    final res = await db.rawQuery('''
      SELECT * FROM Scans WHERE tipo = '$tipus'
    ''');

    return res.isNotEmpty
        ? res.map((e) => ScanModel.fromJson(res.first)).toList()
        : [];
  }

  // També ho podem fer amb RawQuery però és més llarg
  Future<int> updateScan(ScanModel nuevoScan) async {
    final db = await database;
    final res = await db.update('Scans', nuevoScan.toJson(),
        where: 'id = ?', whereArgs: [nuevoScan.id]);

    return res;
  }

  // També ho podem fer amb RawQuery però és més llarg
  Future<int> deteleScan(int id) async {
    final db = await database;
    final res = await db.delete(
      'Scans',
      where: 'id = ?',
      whereArgs: [id],
    );

    return res;
  }

  Future<int> deteleAllScans() async {
    final db = await database;
    final res = await db.rawDelete('''
      DELETE FROM Scans
    ''');

    return res;
  }
}
