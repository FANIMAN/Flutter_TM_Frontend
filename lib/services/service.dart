import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:taskmanager/utils/app_constants.dart';
// import 'package:http/http.dart' as http;

class DataService extends GetConnect implements GetxService {
  
  Future<Response> getData(String uri) async {
    if (kDebugMode) {
      print(AppConstants.BASE_URL + uri);
    }

    // http.Response response;
    Response response = await get(
        // "http://localhost:8080/gettasks",
        AppConstants.BASE_URL+ uri,
        // Uri.parse(AppConstants.BASE_URL + uri),
        headers: {'Content-Type': 'application/json; charset=UTF-8'});

    // if (response.statusCode == 200) {
    //   return response;
    // } else {
    //   return "Failed";
    // }
    
    return response;
  }

  Future<Response> postData(String uri, dynamic body) async {
    if (kDebugMode) {
      print(AppConstants.BASE_URL + uri);
    }

    Response response = await post(
        // "http://localhost:8080/create",
        AppConstants.BASE_URL + uri,
        body,
        headers: {'Content-Type': 'application/json; charset=UTF-8'});

    return response;
  }

  Future<Response> updateData(String uri, dynamic body) async {
    Response response = await put(
        // "http://localhost:8080/create",
        AppConstants.BASE_URL + uri,
        body,
        headers: {'Content-Type': 'application/json; charset=UTF-8'});

    return response;
  }

  Future<Response> deleteData(String uri) async {
    Response response = await delete(
        // "http://localhost:8080/create",
        AppConstants.BASE_URL + uri,
        headers: {'Content-Type': 'application/json; charset=UTF-8'});

    return response;
  }
}
