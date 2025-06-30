import 'package:flutter/material.dart';
import 'db_helper.dart';
import 'form_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Map<String, dynamic>> _students = [];
  final dbHelper = DatabaseHelper.instance;

  @override
  void initState() {
    super.initState();
    _refreshStudents();
  }

  void _refreshStudents() async {
    final data = await dbHelper.getStudents();
    setState(() {
      _students = data;
    });
  }

  void _navigateToAdd() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => FormPage()),
    );
    if (result == true) _refreshStudents();
  }

  void _navigateToEdit(Map<String, dynamic> student) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => FormPage(student: student)),
    );
    if (result == true) _refreshStudents();
  }

  void _deleteStudent(int id) async {
    await dbHelper.deleteStudent(id);
    _refreshStudents();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Data Mahasiswa'),
        foregroundColor: Colors.white,
        backgroundColor: Color(0xFF711A75),
      ),
      body:
          _students.isEmpty
              ? Center(child: Text('Belum ada data'))
              : ListView.builder(
                itemCount: _students.length,
                itemBuilder: (context, index) {
                  final student = _students[index];
                  return Card(
                    child: ListTile(
                      title: Text(student['name'] ?? ''),
                      subtitle: Text('${student['nim']} - ${student['major']}'),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(Icons.edit, color: Color(0xFF711A75)),
                            onPressed: () => _navigateToEdit(student),
                          ),
                          IconButton(
                            icon: Icon(Icons.delete, color: Colors.red),
                            onPressed: () => _deleteStudent(student['id']),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
      floatingActionButton: FloatingActionButton(
        onPressed: _navigateToAdd,
        backgroundColor: Color(0xFFD09EE8),
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
