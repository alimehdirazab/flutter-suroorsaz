import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:suroorsaz/pages/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SuroorSaz',
      theme: ThemeData(
        fontFamily: "Cookie",
        appBarTheme: const AppBarTheme(
            backgroundColor: Colors.transparent, elevation: 0),
        useMaterial3: true,
      ),
      home: const Home(),
    );
  }
}
