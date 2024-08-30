import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

import '../controller/todo_controller.dart';

class TodoScreen extends GetView<TodoController> {
  const TodoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          "VTech Todo",
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.search,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: Obx(
          () => Column(
            children: [
              SizedBox(
                height: 50,
                child: TextFormField(
                  autofocus: false,
                  textInputAction: TextInputAction.done,
                  onEditingComplete: () {},
                  maxLines: 1,
                  onChanged: ((value) {}),
                  controller: controller.searchTextEditingController,
                  scrollPadding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom + 50),
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
                    labelStyle:
                        const TextStyle(color: Colors.grey, fontSize: 14),
                  ),
                ),
              ),
              Expanded(child: Container()),
              Container(
                height: 80,
                padding: const EdgeInsets.all(10),
                child: Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        autofocus: false,
                        textInputAction: TextInputAction.done,
                        onEditingComplete: () {},
                        maxLines: 1,
                        onChanged: ((value) {}),
                        controller: TextEditingController(),
                        scrollPadding: EdgeInsets.only(
                            bottom:
                                MediaQuery.of(context).viewInsets.bottom + 50),
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
                          labelStyle:
                              const TextStyle(color: Colors.grey, fontSize: 14),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    ElevatedButton(
                        onPressed: () {},
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: const Text(
                            "Add",
                            style: TextStyle(fontSize: 18, color: Colors.blue),
                          ),
                        ))
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
