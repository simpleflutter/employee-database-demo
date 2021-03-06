import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaesHelper {
  DatabaesHelper._();

  static final DatabaesHelper instance = DatabaesHelper._();

  static Database _db;

  Future<Database> get database async {
    if (_db != null) return _db;

    _db = await initDatabase();
    return _db;
  }

  Future<Database> initDatabase() async {
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, 'emp.db');
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute(
        'create table employees (id integer primary key autoincrement, name text, post text, salary integer)');
  }
}
