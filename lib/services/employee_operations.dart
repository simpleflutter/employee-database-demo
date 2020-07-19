import 'package:sqflite/sqflite.dart';
import 'package:e_demo/model/employee.dart';
import 'database_helper.dart';

class EmployeeOperations {
  EmployeeOperations._();

  static final EmployeeOperations instance = EmployeeOperations._();

  Future<int> addEmployee(Employee employee) async {
    Database db = await DatabaesHelper.instance.database;
    return await db.insert('employees', employee.toMap());
  }

  Future<int> deleteEmployee(Employee employee) async {
    Database db = await DatabaesHelper.instance.database;
    return await db
        .delete('employees', where: 'id=?', whereArgs: [employee.id]);
  }

  Future<int> updateEmployee(Employee employee) async {
    Database db = await DatabaesHelper.instance.database;
    return await db.update('employees', employee.toMap(),
        where: 'id=?', whereArgs: [employee.id]);
  }

  Future<List<Employee>> getAllEmployees() async {
    Database db = await DatabaesHelper.instance.database;
    List<Map<String, dynamic>> maps = await db.query('employees');

    List<Employee> e = [];

    for (int i = 0; i < maps.length; i++) {
      e.add(Employee.fromMap(maps[i]));
    }

    return e;
  }
}
