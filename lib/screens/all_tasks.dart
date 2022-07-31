import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:taskmanager/controllers/data_controller.dart';
import 'package:taskmanager/routes/routes.dart';
import 'package:taskmanager/screens/edit_task.dart';
import 'package:taskmanager/screens/view_task.dart';
import 'package:taskmanager/utils/app_colors.dart';
import 'package:taskmanager/widgets/button_widget.dart';
import 'package:taskmanager/widgets/task_widget.dart';

class AllTasks extends StatelessWidget {
  const AllTasks({Key? key}) : super(key: key);

  _loadData() async {
    await Get.find<DataController>().getData();
  }

  @override
  Widget build(BuildContext context) {
    print(Get.find<DataController>().myData.length);
    _loadData();
    // List myData = ["Task One", "Task Two"];
    List myData = ["Task One", "Task One"];
    final leftEditIcon = Container(
      margin: EdgeInsets.only(bottom: 10),
      color: Color(0xFF2e3253).withOpacity(0.5),
      child: Icon(
        Icons.edit,
        color: Colors.white,
      ),
      alignment: Alignment.centerLeft,
    );

    final rightDeleteIcon = Container(
      margin: EdgeInsets.only(bottom: 10),
      color: Colors.redAccent,
      child: Icon(
        Icons.delete,
        color: Colors.white,
      ),
      alignment: Alignment.centerRight,
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: GetBuilder<DataController>(builder: (controller) {
        return controller.isLoading == false
            ? Column(
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 20, top: 60),
                    alignment: Alignment.topLeft,
                    child: InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: Icon(
                        Icons.arrow_back,
                        color: AppColors.secondaryColor,
                      ),
                    ),
                    width: double.maxFinite,
                    height: MediaQuery.of(context).size.height / 3.2,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage("assets/header1.jpg"))),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 20, right: 20),
                    child: Row(
                      children: [
                        Icon(
                          Icons.home,
                          color: AppColors.secondaryColor,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Container(
                          child: Icon(
                            Icons.add,
                            color: Colors.white,
                            size: 20,
                          ),
                          width: 25,
                          height: 25,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12.5),
                              color: Colors.black),
                        ),
                        Expanded(child: Container()),
                        Icon(Icons.calendar_view_month_sharp,
                            color: AppColors.secondaryColor),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "2",
                          style: TextStyle(
                              fontSize: 20, color: AppColors.secondaryColor),
                        )
                      ],
                    ),
                  ),
                  Flexible(
                    child: ListView.builder(
                        itemCount: controller.myData.length,
                        itemBuilder: (context, index) {
                          return Dismissible(
                            background: leftEditIcon,
                            secondaryBackground: rightDeleteIcon,
                            onDismissed: (DismissDirection direction) {
                              print("after dismiss");
                            },
                            confirmDismiss: (DismissDirection direction) async {
                              if (direction == DismissDirection.startToEnd) {
                                showModalBottomSheet(
                                    backgroundColor: Colors.transparent,
                                    barrierColor: Colors.transparent,
                                    context: context,
                                    builder: (_) {
                                      return Container(
                                        height: 550,
                                        decoration: BoxDecoration(
                                            color: Color(0xFF2e3253)
                                                .withOpacity(0.4),
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(20),
                                              topRight: Radius.circular(20),
                                            )),
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 20, right: 20),
                                          child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                GestureDetector(
                                                  onTap: () {
                                                    print(controller.myData);
                                                    // Get.off(() => ViewTask(
                                                    //     id: int.parse(controller
                                                    //         .myData[index]["id"]
                                                    //         .toString())));

                                                    Get.toNamed(RouteClass
                                                        .getViewTaskRoute(
                                                            controller
                                                                .myData[index]
                                                                    ["id"]
                                                                .toString()));
                                                  },
                                                  child: ButtonWidget(
                                                      backgroundcolor:
                                                          AppColors.mainColor,
                                                      text: "View",
                                                      textColor: Colors.white),
                                                ),
                                                SizedBox(
                                                  height: 20,
                                                ),
                                                GestureDetector(
                                                  onTap: () {
                                                    // Get.off(() => EditTask(
                                                    //     id: int.parse(controller
                                                    //         .myData[index]["id"]
                                                    //         .toString())));

                                                    Get.toNamed(RouteClass
                                                        .getEditTaskRoute(
                                                            controller
                                                                .myData[index]
                                                                    ["id"]
                                                                .toString()));
                                                  },
                                                  child: ButtonWidget(
                                                      backgroundcolor:
                                                          AppColors.mainColor,
                                                      text: "Edit",
                                                      textColor: Colors.white),
                                                ),
                                              ]),
                                        ),
                                      );
                                    });
                                return false;
                              } else {
                                print(controller.singleData["id"]);
                                controller.deleteData(
                                    int.parse(controller.singleData["id"]));
                                return Future.delayed(Duration(seconds: 1),
                                    () async {
                                  await controller.getData();
                                  return direction ==
                                      DismissDirection.endToStart;
                                });
                              }
                            },
                            key: ObjectKey(index),
                            child: Container(
                              margin: EdgeInsets.only(
                                  left: 20, right: 20, bottom: 10),
                              child: TaskWidget(
                                // text: "This is Task One",
                                text: controller.myData[index]["task_name"],
                                color: Colors.grey,
                              ),
                            ),
                          );
                        }),
                  )
                ],
              )
            : SizedBox(
                width: double.maxFinite,
                height: double.maxFinite,
                child: SpinKitThreeInOut(
                    itemBuilder: (BuildContext context, int index) {
                  return DecoratedBox(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: index.isEven ? Colors.red : Colors.green,
                    ),
                  );
                }),
              );
      }),
    );
  }
}
