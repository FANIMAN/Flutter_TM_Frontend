import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:taskmanager/services/service.dart';
import 'package:taskmanager/utils/app_constants.dart';

class DataController extends GetxController {
//     Future<void> getData() async {
//       DataService service = DataService();
//     _isLoading = true;
//     Response response = await service.getData(AppConstants.GET_TASKS);
//     if(response.statusCode==200){
//       _myData=response.body['data'];
//       print("we got the data");

//     }else{
//       print("we did not get any data");
//     }
//     _isLoading = false;
//     update()

  DataService service = DataService();
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  List<dynamic> _myData = [];
  List<dynamic> get myData => _myData;
  Map<String, dynamic> _singleData = {};
  Map<String, dynamic> get singleData => _singleData;

  Future<void> getData() async {
    _isLoading = true;
    Response response = await service.getData(AppConstants.GET_TASKS);
    print(response.body);
    if (response.statusCode == 200) {
      _myData = response.body;
      print("we got the data");
    } else {
      print("we did not get method any data");
    }
    _isLoading = false;
    update();

  }

  Future<void> getSingleData(String id) async {
    _isLoading = true;
    Response response =
        await service.getData('${AppConstants.GET_TASK}' '?id=$id');
    if (response.statusCode == 200) {
      // _myData = response.body;
      // print("we got the single  data");
      if (kDebugMode) {
        print("We go the single data" + jsonEncode(response.body));
      }
      _singleData = response.body;
    } else {
      print("we did not get any data");
    }
    _isLoading = false;
    update();

  }

  Future<void> postData(String task, String taskDetail) async {
    _isLoading = true;
    Response response = await service.postData(
        AppConstants.POST_TASK, {"task_name": task, "task_detail": taskDetail});
    print(response);
    print(task);
    print(taskDetail);
    print(response.statusCode);
    print(response.statusCode);

    if (response.statusCode == 200) {
      // update();
      // _myData = response.body['data'];
      // print(_myData);
      print("Data Post Successfully");
    } else {
      print("Data post failed");
    }
    // _isLoading = false;
    update();
  }

  Future<void> updateData(String task, String taskDetail, int id) async {
    _isLoading = true;
    Response response = await service.updateData(
        '${AppConstants.UPDATE_TASK}' '?id=$id',
        {"task_name": task, "task_detail": taskDetail});
    print(response);
    print(response.statusCode);
    print(response.statusCode);

    if (response.statusCode == 200) {
      // update();
      // _myData = response.body['data'];
      // print(_myData);
      print("Data Post Successfully");
    } else {
      print("Data post failed");
    }
    // _isLoading = false;
    update();
  }

  Future<void> deleteData(int id) async {
    _isLoading = true;
    update();
    Response response = await service.deleteData(
      '${AppConstants.DELETE_TASK}' '?id=$id',
    );
    print(response);
    print(response.statusCode);
    print(response.statusCode);

    if (response.statusCode == 200) {
      // update();
      // _myData = response.body['data'];
      // print(_myData);
      print("Data Post Successfully");
    } else {
      print("Data post failed");
    }

    Future.delayed(Duration(seconds: 1), () {
      _isLoading = false;
      update();
    });
    // _isLoading = false;
    //update()
  }
}
