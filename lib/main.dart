import 'package:flutter/material.dart';
import 'package:project_akhir_tpm_teori/Register.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Ptoject Akhir TPM',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: RegisterPage(),
    );
  }
}