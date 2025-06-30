import 'package:flutter/material.dart';
import 'db_helper.dart';

class FormPage extends StatefulWidget {
  final Map<String, dynamic>? student;

  const FormPage({Key? key, this.student}) : super(key: key);

  @override
  _FormPageState createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _nimController = TextEditingController();
  final _majorController = TextEditingController();
  final dbHelper = DatabaseHelper.instance;

  @override
  void initState() {
    super.initState();
    if (widget.student != null) {
      _nameController.text = widget.student!['name'];
      _nimController.text = widget.student!['nim'];
      _majorController.text = widget.student!['major'];
    }
  }

  void _saveData() async {
    if (_formKey.currentState!.validate()) {
      final studentData = {
        'name': _nameController.text,
        'nim': _nimController.text,
        'major': _majorController.text,
      };
      if (widget.student == null) {
        await dbHelper.insertStudent(studentData);
      } else {
        await dbHelper.updateStudent(widget.student!['id'], studentData);
      }
      Navigator.pop(context, true);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.student != null;
    return Scaffold(
      appBar: AppBar(
        title: Text(isEdit ? 'Edit Mahasiswa' : 'Tambah Mahasiswa'),
        foregroundColor: Colors.white,
        backgroundColor: Color(0xFF711A75),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Nama'),
                validator: (value) => value!.isEmpty ? 'Wajib diisi' : null,
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _nimController,
                decoration: InputDecoration(labelText: 'NIM'),
                validator: (value) => value!.isEmpty ? 'Wajib diisi' : null,
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _majorController,
                decoration: InputDecoration(labelText: 'Jurusan'),
                validator: (value) => value!.isEmpty ? 'Wajib diisi' : null,
              ),
              SizedBox(height: 24),
              ElevatedButton(
                onPressed: _saveData,
                child: Text(isEdit ? 'Update' : 'Simpan'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
