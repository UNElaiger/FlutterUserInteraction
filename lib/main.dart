import 'package:flutter/material.dart';
import 'pages/reister_form_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Register Form Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: RegisterFormPage(),
    );
  }
}
