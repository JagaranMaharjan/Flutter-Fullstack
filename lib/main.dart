import 'package:flutter/material.dart';
import 'package:flutter_django_fullstack/provider/to_do_provider.dart';
import 'package:flutter_django_fullstack/screens/home_screen.dart';
import 'package:provider/provider.dart';
//main method
void main() {
  runApp(MyApp());
}
//root widget
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ToDoProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Full Stack To Do App",
        home: HomeScreen(),
      ),
    );
  }
}
