import 'package:flutter/material.dart';
import 'package:flutter_django_fullstack/provider/to_do_provider.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _refresh = false;
  @override
  Widget build(BuildContext context) {
    final _toDoProvider = Provider.of<ToDoProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text("To Do App"),
        actions: [
          IconButton(
              icon: Icon(Icons.refresh),
              onPressed: () {
                setState(() {
                  _refresh=true;
                });
                _toDoProvider.fetchToDoData();
                setState(() {
                  _refresh=false;
                });
              })
        ],
      ),
      body: FutureBuilder(
        future: _toDoProvider.fetchToDoData(),
        builder: (fCtx, snapshotData) {
          return snapshotData.connectionState == ConnectionState.waiting || _refresh
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : ListView.builder(
                  itemCount: _toDoProvider.toDoList.length,
                  itemBuilder: (lCtx, index) {
                    return Card(
                      color: Colors.white,
                      elevation: 3,
                      shadowColor: Colors.blue,
                      child: Container(
                        child: ListTile(
                          leading:
                              Text(_toDoProvider.toDoList[index].id.toString()),
                          title: Text(
                              _toDoProvider.toDoList[index].title.toString()),
                          subtitle: Text(_toDoProvider
                              .toDoList[index].description
                              .toString()),
                        ),
                      ),
                    );
                  },
                );
        },
      ),
    );
  }
}
