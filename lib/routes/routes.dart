import 'package:get/get.dart';
import 'package:taskmanager/screens/add_task.dart';
import 'package:taskmanager/screens/all_tasks.dart';
import 'package:taskmanager/screens/edit_task.dart';
import 'package:taskmanager/screens/home_screen.dart';
import 'package:taskmanager/screens/view_task.dart';

class RouteClass {
  static String home = "/";
  static String allTasks = "/allTasks";
  static String addTask = "/addTask";
  static String editTask = "/editTask";
  static String viewTask = "/viewTask";

  static String getHomeRoute() => home;
  static String getAllTasksRoute() => allTasks;
  static String getAddTaskRoute() => addTask;
  static String getEditTaskRoute(String id) => '$editTask?id=$id';
  static String getViewTaskRoute(String id) => '$viewTask?id=$id';

  static List<GetPage> routes = [
    GetPage(page: () => HomeScreen(), name: home),
    GetPage(
        page: () => AllTasks(),
        name: allTasks,
        transition: Transition.fade,
        transitionDuration: Duration(seconds: 1)),
    GetPage(
        page: () => AddTask(),
        name: addTask,
        transition: Transition.zoom,
        transitionDuration: Duration(microseconds: 500)),
    GetPage(
        page: () {
          var id = Get.parameters['id'];
          return EditTask(id: int.parse(id!));
        },
        name: editTask,
        transition: Transition.zoom,
        transitionDuration: Duration(microseconds: 500)),

    GetPage(
        page: () {
          var id = Get.parameters['id'];
          return ViewTask(id: int.parse(id!));
        },
        name: viewTask,
        transition: Transition.zoom,
        transitionDuration: Duration(microseconds: 500)),
  ];
}
