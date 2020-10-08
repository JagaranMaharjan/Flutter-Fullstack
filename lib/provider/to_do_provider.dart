import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_django_fullstack/api_services/api_url.dart';
import 'package:flutter_django_fullstack/models/to_do_model.dart';
import 'package:http/http.dart' as http;

class ToDoProvider with ChangeNotifier {
  //created empty list
  List<ToDoModel> _toDoList = [];

  //return list values
  List<ToDoModel> get toDoList {
    return [..._toDoList];
  }

  Future<void> fetchToDoData() async {
    //get root url of API
    final _url = APIUrl.rootUrl;
    //get response
    final _httpResponse = await http.get(_url);
    //check connection
    if (_httpResponse.statusCode == 200) {
      try {
        var _extractedData = json.decode(_httpResponse.body) as List;
        //if _extracted data does not contain any value then
        if (_extractedData == null) {
          return;
        }
        //if extracted data has value then add extracted value to list
        _toDoList = _extractedData
            .map<ToDoModel>((json) => ToDoModel.fromJson(json))
            .toList();
        notifyListeners();
      } catch (e) {
        throw e;
      }
    }
  }
}
