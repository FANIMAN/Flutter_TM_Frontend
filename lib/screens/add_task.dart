import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taskmanager/controllers/data_controller.dart';
import 'package:taskmanager/routes/routes.dart';
import 'package:taskmanager/screens/all_tasks.dart';
import 'package:taskmanager/utils/app_colors.dart';
import 'package:taskmanager/widgets/button_widget.dart';
import 'package:taskmanager/widgets/error_warning_ms.dart';
import 'package:taskmanager/widgets/textfield_widget.dart';

class AddTask extends StatelessWidget {
  const AddTask({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController detailController = TextEditingController();

    bool _dataValidation() {
      if (nameController.text.trim() == '') {
        Message.taskErrorOrWarning("Task name", "Your task name is empty");
        // Get.snackbar("Task name", "Task name is empty");
        return false;
      } else if (detailController.text.trim() == '') {
        Message.taskErrorOrWarning("Task detail", "Your task detail is empty");
        // Get.snackbar("Task detail", "Task detail is empty");
        return false;
      } else if (nameController.text.length <= 6) {
        Message.taskErrorOrWarning(
            "Task name", "Your task name should be atleast 6 characters");
        return false;
      } else if (detailController.text.length <= 10) {
        Message.taskErrorOrWarning(
            "Task detail", "Your task detail should be atleast 10 characters");
        return false;
      }
      return true;
    }

    return Scaffold(
      body: Container(
        width: double.maxFinite,
        height: double.maxFinite,
        padding: EdgeInsets.only(left: 20, right: 20),
        decoration: BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.cover, image: AssetImage("assets/addtask1.jpg")),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                SizedBox(
                  height: 60,
                ),
                IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    padding: EdgeInsets.zero,
                    constraints: BoxConstraints(),
                    icon: Icon(
                      Icons.arrow_back,
                      color: AppColors.secondaryColor,
                    ))
              ],
            ),
            Column(
              children: [
                 SizedBox(
                  height: 20,
                ),
                TextFiledWidget(
                    textController: nameController, 
                    hintText: "የሥራዉ ስም",
                    // hintText: "Task name",
                    ),
                SizedBox(
                  height: 20,
                ),
                TextFiledWidget(
                  textController: detailController,
                 hintText: "የሥራዉ ዝርዝር",
                  // hintText: "Task Detail",
                  borderRadius: 15,
                  maxLines: 3,
                ),
                SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () {
                    if (_dataValidation()) {
                      print(nameController.text);
                      print(detailController.text);
                      Get.find<DataController>().postData(
                          nameController.text.trim(),
                          detailController.text.trim());

                      // Get.to(
                      //   () => AllTasks(),
                      //   transition: Transition.fadeIn,
                      //   // transition: Transition.circularReveal,
                      // );
                      Get.offNamed(RouteClass.getAllTasksRoute());
                    }
                  },
                  child: ButtonWidget(
                      backgroundcolor: AppColors.mainColor,
                      // text: "Add",
                      text: "ጨምር",
                      textColor: Colors.white),
                )
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 6,
            ),
          ],
        ),
      ),
    );
  }
}
