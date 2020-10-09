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

  //fetch all data from API
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

  //add new to do data through API
  Future<void> addToDoData({@required ToDoModel toDoModel}) async {
    //send post request
    final _httpResponse = await http.post(
      APIUrl.rootUrl,
      headers: {"Content-Type": "application/json"},
      body: json.encode(toDoModel),
    );
    //if post response status code is not 200 or 201 then
    if (_httpResponse.statusCode != 201 || _httpResponse.statusCode != 200) {
      return;
    }
    //if post response is fine add new data to list
    toDoModel.id = int.parse(json.decode(_httpResponse.body)['id'].toString());
    _toDoList.add(toDoModel);
    notifyListeners();
  }

  //update to do data according to id
  Future<void> updateToDoData({@required ToDoModel toDoModel, @required int index}) async {
    //send and get put http response
    final _httpResponse = await http.put(
      "${APIUrl.rootUrl}${toDoModel.id}/",
      headers: {"Content-Type": "application/json"},
      body: json.encode(toDoModel),
    );
    //if post response status code is not 200 or 201 then
    if (_httpResponse.statusCode != 201 || _httpResponse.statusCode != 200) {
      return;
    }
    //update value of list according to index and id
    _toDoList.insert(index, toDoModel);
    notifyListeners();
  }

  //delete to do data according to id
  Future<void> deleteToDoData({@required ToDoModel toDoModel}) async {
    //send and get delete response
    final _httpResponse =
        await http.delete("${APIUrl.rootUrl}${toDoModel.id}/");
    //if delete response status code is not 204 then
    if (_httpResponse.statusCode != 204) {
      return;
    }
    //if delete response status code is 204 0r 200 then remove data from list
    _toDoList.remove(toDoModel);
    notifyListeners();
  }
}
