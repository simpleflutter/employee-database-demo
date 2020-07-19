import 'package:flutter/material.dart';
import 'package:e_demo/model/employee.dart';
import 'package:e_demo/services/employee_operations.dart';

class AddEmployee extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController postController = TextEditingController();
  final TextEditingController salaryController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Employee')),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: <Widget>[
          TextField(
            controller: nameController,
            textCapitalization: TextCapitalization.words,
            decoration: InputDecoration(hintText: 'Name'),
          ),
          SizedBox(height: 16),
          TextField(
            controller: postController,
            textCapitalization: TextCapitalization.words,
            decoration: InputDecoration(hintText: 'Post'),
          ),
          SizedBox(height: 16),
          TextField(
            controller: salaryController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(hintText: 'Salary'),
          ),
          SizedBox(height: 16),
          RaisedButton(
            child: Text('Add Employee'),
            onPressed: () {
              addEmployeeToDatabase(context);
            },
          )
        ],
      ),
    );
  }

  void addEmployeeToDatabase(BuildContext context) async {
    String n = nameController.text;
    String p = postController.text;
    int s = int.parse(salaryController.text);

    Employee e = Employee(name: n, post: p, salary: s);

    await EmployeeOperations.instance.addEmployee(e);
    Navigator.pop(context);
  }
}
