import 'package:flutter/material.dart';
import './menu.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        extendBodyBehindAppBar: true,
        body: BottomNav(),
      ),
      debugShowCheckedModeBanner: false,
    ); //MaterialApp
  }
}
