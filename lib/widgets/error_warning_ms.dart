import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taskmanager/utils/app_colors.dart';

class Message {
  static void taskErrorOrWarning(String taskname, String taskErrorOrWarning) {
    Get.snackbar(taskname, taskErrorOrWarning,
    backgroundColor: AppColors.mainColor,
    titleText: Text(
      taskname,
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    ),
      messageText: Text(
      taskErrorOrWarning,
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: Colors.amber,
      ),
    )
    );
  }
}
