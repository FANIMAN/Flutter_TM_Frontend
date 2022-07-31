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

class EditTask extends StatelessWidget {
  final int id;
  const EditTask({Key? key, required this.id}) : super(key: key);

  _loadSingleTask() async {
    await Get.find<DataController>().getSingleData(id.toString());
  }

  @override
  Widget build(BuildContext context) {
    _loadSingleTask();
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
        return true;
      } else if (nameController.text.length <= 6) {
        Message.taskErrorOrWarning(
            "Task name", "Your task name should be atleast 6 characters");
      } else if (detailController.text.length <= 10) {
        Message.taskErrorOrWarning(
            "Task detail", "Your task detail should be atleast 10 characters");
      }
      return true;
    }

    return Scaffold(body: GetBuilder<DataController>(builder: (controller) {
      nameController.text =
          controller.singleData["task_name"] ?? "Task name not found";
      detailController.text =
          controller.singleData["task_detail"] ?? "Task detail not found";
      return Container(
        width: double.maxFinite,
        height: double.maxFinite,
        padding: EdgeInsets.only(left: 20, right: 20),
        decoration: BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.cover, image: AssetImage("assets/addtask2.jpg")),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                SizedBox(
                  height: 40,
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
                TextFiledWidget(
                  textController: nameController,
                  hintText: "Task name",
                  readOnly: false,
                ),
                SizedBox(
                  height: 20,
                ),
                TextFiledWidget(
                  textController: detailController,
                  hintText: "Task Detail",
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
                      Get.find<DataController>().updateData(
                          nameController.text.trim(),
                          detailController.text.trim(),
                          int.parse(controller.singleData["id"]));

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
                      text: "Add",
                      textColor: Colors.white),
                )
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 6,
            ),
          ],
        ),
      );
    }));
  }
}
