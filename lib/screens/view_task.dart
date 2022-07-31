import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taskmanager/controllers/data_controller.dart';
import 'package:taskmanager/utils/app_colors.dart';
import 'package:taskmanager/widgets/textfield_widget.dart';

class ViewTask extends StatelessWidget {
  final int id;
  const ViewTask({Key? key, required this.id}) : super(key: key);

  _loadSingleTask() async {
    await Get.find<DataController>().getSingleData(id.toString());
  }

  @override
  Widget build(BuildContext context) {
    _loadSingleTask();
    TextEditingController nameController = TextEditingController();
    TextEditingController detailController = TextEditingController();

    return Scaffold(body: GetBuilder<DataController>(
      builder: (controller) {
        nameController.text =
          controller.singleData["task_name"] ?? "Task name not found";
      detailController.text =
          controller.singleData["task_detail"] ?? "Task detail not found";
        return Container(
          width: double.maxFinite,
          height: double.maxFinite,
          padding: EdgeInsets.only(left: 20, right: 20),
          decoration: BoxDecoration(
              image: DecorationImage(image: AssetImage("assets/addtask1.jpg"))),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  SizedBox(height: 40),
                  IconButton(
                    padding: EdgeInsets.zero,
                    constraints: BoxConstraints(),
                      onPressed: () {
                        Get.back();
                      },
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
                       hintText: "task name",
                      // hintText: '${controller.singleData["task_name"]}', 
                      readOnly: true,
                      ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFiledWidget(
                    textController: detailController,
                    // hintText: '${controller.singleData["task_detail"]}',
                    hintText: "task detail",
                    readOnly: true,
                    borderRadius: 15,
                    maxLines: 3,
                  )
                ],
              ),
            ],
          ),
        );
      },
    ));
  }
}
