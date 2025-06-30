import 'package:flutter/material.dart';
import 'login_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CRUD Mahasiswa',
      theme: ThemeData(
        primaryColor: Color(0xFF711A75),
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: Color(0xFF711A75),
          secondary: Color(0xFFD09EE8),
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFF711A75), width: 2),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFF711A75), width: 1),
          ),
          labelStyle: TextStyle(color: Color(0xFF711A75)),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xFF711A75),
            foregroundColor: Colors.white,
          ),
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: Color(0xFFD09EE8),
          foregroundColor: Colors.white,
        ),
      ),
      home: LoginPage(),
    );
  }
}
