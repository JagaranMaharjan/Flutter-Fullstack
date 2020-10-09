import 'package:flutter/material.dart';
import 'package:flutter_django_fullstack/models/to_do_model.dart';
import 'package:flutter_django_fullstack/provider/to_do_provider.dart';
import 'package:provider/provider.dart';

class AddToDo extends StatefulWidget {
  @override
  _AddToDoState createState() => _AddToDoState();
}

class _AddToDoState extends State<AddToDo> {
  //--------------declaration of text editing controller--------------------
  TextEditingController _title = TextEditingController();
  TextEditingController _description = TextEditingController();

  //-------------------------add users added new to do to the server-------------
  void onAdd() {
    final String title = _title.text.toString();
    final String description = _description.text.toString();
    if (title.isNotEmpty && description.isNotEmpty) {
      Provider.of<ToDoProvider>(context, listen: false).addToDoData(
          toDoModel: ToDoModel(title: title, description: description));
    }
  }

  //-------------------------------UI-------------------------------------
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add New ToDo"),
      ),
      body: ListView(
        children: [
          Container(
            child: Column(
              children: [
                TextField(
                  controller: _title,
                ),
                TextField(
                  controller: _description,
                ),
                RaisedButton.icon(
                  onPressed: onAdd,
                  icon: Icon(Icons.add),
                  label: Text("Add New ToDo"),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
