import 'package:flutter/material.dart';
import 'package:flutter_django_fullstack/provider/to_do_provider.dart';
import 'package:flutter_django_fullstack/screens/add_to_do.dart';
import 'package:flutter_django_fullstack/screens/edit_to_do.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //declaration of boolean variable
  bool _refresh = false;

  @override
  Widget build(BuildContext context) {
    //nothing value to be update in ToDoProvider so listen/listener is false
    final _toDoProvider = Provider.of<ToDoProvider>(context, listen: false);
    //--------------UI----------------------------
    return Scaffold(
      //------------------app bar---------------------------
      appBar: AppBar(
        title: Text("To Do App"),
        actions: [
          //---------Icon button of app bar-----------------
          //------this button refresh the list-------------
          IconButton(
              icon: Icon(Icons.refresh),
              onPressed: () {
                setState(() {
                  _refresh = true;
                });
                //to the refresh the data
                _toDoProvider.fetchToDoData();
                setState(() {
                  _refresh = false;
                });
              })
        ],
      ),
      //------------------- Fetch data from server ----------------
      body: FutureBuilder(
        future: _toDoProvider.fetchToDoData(),
        builder: (fCtx, snapshotData) {
          return snapshotData.connectionState == ConnectionState.waiting ||
                  _refresh
              //----until and unless data fetch from server, display a circular progress indicator--
              ? Center(
                  child: CircularProgressIndicator(),
                )
              //-------------------Display All Fetched Data In ListView----------------
              : ListView.builder(
                  itemCount: _toDoProvider.toDoList.length,
                  itemBuilder: (lCtx, index) {
                    return Dismissible(
                      direction: DismissDirection.endToStart,
                      onDismissed: (direction) {
                        _toDoProvider.deleteToDoData(
                            toDoModel: _toDoProvider.toDoList[index]);
                      },
                      key: ValueKey(DateTime.now()),
                      background: Container(
                        color: Colors.red,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsets.all(10),
                              child: Icon(
                                Icons.delete_forever,
                                color: Colors.white,
                                size: 30,
                              ),
                            ),
                          ],
                        ),
                      ),
                      child: Card(
                        color: Colors.white,
                        elevation: 3,
                        shadowColor: Colors.blue,
                        child: Container(
                          child: ListTile(
                            leading: Text(
                                _toDoProvider.toDoList[index].id.toString()),
                            title: Text(
                                _toDoProvider.toDoList[index].title.toString()),
                            subtitle: Text(_toDoProvider
                                .toDoList[index].description
                                .toString()),
                            //----Edit Icon button------------------
                            trailing: IconButton(
                              onPressed: () {
                                Navigator.of(context)
                                    .push(MaterialPageRoute(builder: (context) {
                                  return EditToDo(
                                    toDoModel: _toDoProvider.toDoList[index],
                                    index: index,
                                  );
                                }));
                              },
                              icon: Icon(
                                Icons.edit,
                                color: Colors.blueGrey,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
        },
      ),
      //-----------------------floating action button---------------------------
      //---this button is used to add new to do things------------------------
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
            return AddToDo();
          }));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
