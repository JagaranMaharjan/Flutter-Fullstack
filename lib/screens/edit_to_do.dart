import 'package:flutter/material.dart';
import 'package:flutter_django_fullstack/models/to_do_model.dart';
import 'package:flutter_django_fullstack/provider/to_do_provider.dart';
import 'package:provider/provider.dart';

class EditToDo extends StatefulWidget {
  final ToDoModel toDoModel;
  final int index;

  EditToDo({@required this.toDoModel, @required this.index});

  @override
  _EditToDoState createState() => _EditToDoState();
}

class _EditToDoState extends State<EditToDo> {
  //declaration of text field controller
  TextEditingController _title = TextEditingController();
  TextEditingController _description = TextEditingController();

  //add initial value
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _title = TextEditingController(text: widget.toDoModel.title);
    _description = TextEditingController(text: widget.toDoModel.description);
  }

//update data------------
  void onUpdate() {
    final String title = _title.text.toString();
    final String description = _description.text.toString();
    if (title.isNotEmpty && description.isNotEmpty) {
      Provider.of<ToDoProvider>(context, listen: false).updateToDoData(
          toDoModel: ToDoModel(
              id: widget.toDoModel.id, title: title, description: description),
          index: widget.index);
    }
  }

//------------------------------------UI--------------------------
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit To Do Data"),
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
                  onPressed: onUpdate,
                  icon: Icon(Icons.update),
                  label: Text("Update ToDo"),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
