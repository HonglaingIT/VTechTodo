import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

import '../controller/todo_controller.dart';
import 'todo_list.dart';

class TodoScreen extends GetView<TodoController> {
  const TodoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        unFocus(context);
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          
          backgroundColor: Colors.blue,
          title: const Text(
            "VTech Todo",
            style: TextStyle(color: Colors.white),
          ),
          actions: [
            IconButton(
              onPressed: () {
                controller.changeSearch();
              },
              icon: const Icon(
                Icons.search,
                color: Colors.white,
              ),
            ),
          ],
        ),
        body: Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Obx(
                () => controller.isSearch.value
                    ? SizedBox(
                        height: 50,
                        child: TextFormField(
                          autofocus: false,
                          textInputAction: TextInputAction.done,
                          maxLines: 1,
                          onChanged: (value) {
                            controller.searchStr.value = value;
                          },
                          controller: controller.searchTextEditingController,
                          scrollPadding: EdgeInsets.only(
                              bottom: MediaQuery.of(context).viewInsets.bottom +
                                  50),
                          decoration: InputDecoration(
                            counterText: '',
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.grey.withOpacity(0.5),
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.grey.withOpacity(0.5),
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            labelText: "Search",
                            labelStyle: const TextStyle(
                                color: Colors.grey, fontSize: 14),
                          ),
                        ),
                      )
                    : const SizedBox(),
              ),
              const SizedBox(
                height: 10,
              ),
              const Expanded(child: TodoList()),
              SizedBox(
                height: 70,
                child: Row(
                  children: [
                    Expanded(
                      child: Form(
                        key: controller.formKey,
                        child: TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) {
                            if (controller.onUnfocused.value) {
                              return null;
                            }
                            if (value!.isEmpty) {
                              return 'Todo cannot be empty!';
                            }
                            return null;
                          },
                          autofocus: true,
                          textInputAction: TextInputAction.done,
                          onEditingComplete: () {},
                          maxLines: 1,
                          onChanged: (value) {
                            controller.onUnfocused.value = false;
                            controller.formKey.currentState?.validate();
                          },
                          onFieldSubmitted: (val) {
                            controller.addTodo();
                          },
                          controller: controller.textEditingController,
                          scrollPadding: EdgeInsets.only(
                              bottom: MediaQuery.of(context).viewInsets.bottom +
                                  50),
                          decoration: InputDecoration(
                            counterText: '',
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.grey.withOpacity(0.5),
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.grey.withOpacity(0.5),
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            labelText: "Enter Todo",
                            labelStyle: const TextStyle(
                                color: Colors.grey, fontSize: 14),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Obx(
                      () => ElevatedButton(
                          onPressed: () {
                            controller.pendingEditTodo.value == null
                                ? controller.addTodo()
                                : controller.editTodo();
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Text(
                              controller.pendingEditTodo.value == null
                                  ? "Add"
                                  : "Edit",
                              style: const TextStyle(
                                  fontSize: 18, color: Colors.blue),
                            ),
                          )),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void unFocus(BuildContext context) {
    final FocusScopeNode currentFocus = FocusScope.of(context);
    // if (!currentFocus.hasPrimaryFocus) {
    //   currentFocus.unfocus();
    // }
    if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
      FocusManager.instance.primaryFocus!.unfocus();
      controller.onUnfocused.value = true;
    }
  }
}
