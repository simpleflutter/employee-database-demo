import 'package:e_demo/screens/add_employee.dart';
import 'package:e_demo/screens/edit_employee.dart';
import 'package:flutter/material.dart';
import 'package:e_demo/model/employee.dart';
import 'package:e_demo/services/employee_operations.dart';
import 'package:e_demo/services/jump_to_page.dart';
import 'package:path/path.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Employee> employeeList = [];
  EmployeeOperations employeeOperations = EmployeeOperations.instance;

  void getEmployeeData() async {
    List<Employee> temp = await employeeOperations.getAllEmployees();

    setState(() {
      employeeList = temp;
    });
  }

  @override
  void initState() {
    getEmployeeData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Employee Demo')),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          jumpToAddEmployee(context);
        },
      ),
      body: employeeList.length == 0 ? showNoEmployee() : displayEmployees(),
    );
  }

  void jumpToAddEmployee(BuildContext context) async {
    await JumpToPage.push(context, AddEmployee());
    getEmployeeData();
  }

  Widget showNoEmployee() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text('No Employee to display'),
          SizedBox(height: 16),
          CircularProgressIndicator(),
        ],
      ),
    );
  }

  Widget displayEmployees() {
    return ListView.builder(
      itemCount: employeeList.length,
      itemBuilder: (BuildContext context, int index) {
        Employee employee = employeeList[index];
        return ListTile(
          isThreeLine: true,
          leading: CircleAvatar(child: Text(employee.name[0])),
          title: Text(employee.name),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('${employee.post}  (ID:${employee.id})'),
              Text('\u20B9 ${employee.salary}'),
            ],
          ),
          trailing: IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              deleteEmployeeFormDatabase(context, employee);
            },
          ),
          onTap: () {
            jumpToEditEmployee(context, employee);
          },
        );
      },
    );
  }

  void jumpToEditEmployee(BuildContext context, Employee employee) async {
    await JumpToPage.push(context, EditEmployee(employee: employee));
    getEmployeeData();
  }

  void deleteEmployeeFormDatabase(
      BuildContext context, Employee employee) async {
    AlertDialog alertDialog = AlertDialog(
      title: Text('Employee Demo'),
      content: Text('Are you sure to delete ${employee.name}?'),
      actions: <Widget>[
        FlatButton(
          child: Text('Yes'),
          onPressed: () async{
            await employeeOperations.deleteEmployee(employee);
            getEmployeeData();
            Navigator.pop(context);
          },
        ),
        FlatButton(
          child: Text('No'),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) => alertDialog,
    );
  }
}
