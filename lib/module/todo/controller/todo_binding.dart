import 'package:get/get.dart';

import 'todo_controller.dart';

class TodoBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => TodoController(),
    );
  }
}
