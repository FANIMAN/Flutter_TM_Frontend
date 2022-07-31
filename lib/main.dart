import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taskmanager/controllers/data_controller.dart';
import 'package:taskmanager/routes/routes.dart';
import 'package:taskmanager/screens/home_screen.dart';
import 'package:flutter/cupertino.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  loadData() async {
    await Get.find<DataController>().getData();
  }

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => DataController());   //Inject Our Data Controller
    loadData();
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),   
      initialRoute: RouteClass.getHomeRoute(), 
      getPages: RouteClass.routes,                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              
      // home: HomeScreen(),
    );
  }
}
