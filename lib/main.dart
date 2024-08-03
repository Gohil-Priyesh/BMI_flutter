import 'package:bmi_flutter/Home/HomePage.dart';
import 'package:bmi_flutter/login_prototype/loginscreen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const myapp());
}
class myapp extends StatelessWidget {
  const myapp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginScreen(),
    );
  }
}
