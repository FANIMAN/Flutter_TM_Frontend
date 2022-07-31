import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:taskmanager/routes/routes.dart';
import 'package:taskmanager/screens/add_task.dart';
import 'package:taskmanager/screens/all_tasks.dart';
import 'package:taskmanager/utils/app_colors.dart';
import 'package:taskmanager/widgets/button_widget.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.maxFinite,
        height: double.maxFinite,
        padding: const EdgeInsets.only(left: 25, right: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
              text: TextSpan(
                  // text: "Hello",
                  text: "ሠላም",
                  style: TextStyle(
                      color: AppColors.mainColor,
                      fontSize: 60,
                      fontWeight: FontWeight.bold),
                  children: [
                    TextSpan(
                        // text: "\nStart Your Day",
                        text: "\nቀኖን ይጀምሩ",
                        style: TextStyle(
                          color: AppColors.smallTextColor,
                          fontSize: 14,
                          // fontWeight: FontWeight.bold
                        ))
                  ]),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 2.5,
            ),
            InkWell(
              onTap: () {
                Get.to(() => AddTask(),
                    transition: Transition.zoom,
                    duration: Duration(milliseconds: 500));
              },
              child: ButtonWidget(
                  backgroundcolor: AppColors.mainColor,
                  text: "ተግባር ጨምር",
                  // text: "Add Task",
                  textColor: Colors.white),
            ),
            SizedBox(height: 20),
            InkWell(
              onTap: () {
                // Get.to(() => AllTasks(),
                //     transition: Transition.fade,
                //     duration: Duration(seconds: 1));
                Get.toNamed(RouteClass.getAllTasksRoute());
              },
              child: ButtonWidget(
                  backgroundcolor: Colors.white,
                  text: "ሁሉንም ይዩ",
                  // text: "View All",
                  textColor: AppColors.smallTextColor),
            ),
          ],
        ),
        decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover, image: AssetImage("assets/welcome.jpg"))),
      ),
    );
  }
}
