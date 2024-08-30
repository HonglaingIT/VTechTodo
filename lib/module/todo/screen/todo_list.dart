import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vtech_todo/module/todo/model/todo_model.dart';

import '../controller/todo_controller.dart';

class TodoList extends GetView<TodoController> {
  const TodoList({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: controller.fireStore.collection('todos').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
              child: CircularProgressIndicator(
            color: Colors.blue,
          ));
        }

        return Obx(() {
          var documents = snapshot.data!.docs
              .map((DocumentSnapshot document) {
                return TodoModel.fromJson(
                    document.data()! as Map<String, dynamic>);
              })
              .where((e) => e.description!.contains(controller.searchStr.value))
              .toList();
          if (documents.isEmpty) {
            return Center(
                child:controller.searchStr.value != '' 
                    ? const Text('No result. Create a new one instead')
                    : const Text('Empty todo list!'));
          } else {
            return ListView(
              children: documents.map((e) {
                return Container(
                  margin: const EdgeInsets.only(bottom: 15.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    color: Colors.white,
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 5.0,
                        offset: Offset(0, 2), // shadow direction: bottom right
                      ),
                    ],
                  ),
                  child: Obx(
                    () => ListTile(
                        selected: controller.pendingEditTodo.value?.id == e.id,
                        dense: false,
                        contentPadding: const EdgeInsets.all(5),
                        leading: IconButton(
                            onPressed: () {
                              controller.changeStatus(e);
                            },
                            icon: e.isComplete ?? false
                                ? const Icon(
                                    Icons.check_circle,
                                    color: Colors.green,
                                  )
                                : const Icon(Icons.circle_outlined)),
                        title: Text(
                          e.description ?? "",
                          style: TextStyle(
                            decoration: e.isComplete ?? false
                                ? TextDecoration.lineThrough
                                : null,
                          ),
                        ),
                        trailing: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                                onPressed: () {
                                  controller.changeEditStatus(e);
                                },
                                icon: const Icon(
                                  Icons.edit_outlined,
                                  color: Colors.blue,
                                )),
                            IconButton(
                                onPressed: () {
                                  controller.deleteTodo(e);
                                },
                                icon: const Icon(
                                  Icons.delete_outline,
                                  color: Colors.red,
                                )),
                          ],
                        )),
                  ),
                );
              }).toList(),
            );
          }
        });
      },
    );
  }
}
