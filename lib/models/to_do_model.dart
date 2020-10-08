import 'package:flutter/material.dart';

class ToDoModel with ChangeNotifier {
  final int id;
  final String title;
  final String description;

  ToDoModel(
      {@required this.id, @required this.title, @required this.description});

  //return instance of a class
  factory ToDoModel.fromJson(Map<String, dynamic> json) {
    return ToDoModel(
        id: json['id'] as int,
        title: json['title'] as String,
        description: json['description'] as String);
  }
}
