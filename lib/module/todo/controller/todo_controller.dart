import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../model/todo_model.dart';

class TodoController extends GetxController {
  final textEditingController = TextEditingController();
  final searchTextEditingController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final pendingEditTodo = Rxn<TodoModel>();
  final onUnfocused = false.obs;
  final fireStore = FirebaseFirestore.instance;
  final searchStr = ''.obs;
  final isSearch = true.obs;

  final FocusNode focusNode = FocusNode();
  List<TodoModel> todos = [];

  void changeSearch() {
    isSearch.value = !isSearch.value;
    searchTextEditingController.clear();
    searchStr.value = '';
  }

  Future<void> restSearch() async {
    searchTextEditingController.clear();
    isSearch.value = false;
    searchStr.value = '';
  }

  void addTodo() async {
    onUnfocused(false);
    if (formKey.currentState?.validate() ?? false) {
      if (todos.any((e) =>
          e.description!.toLowerCase() ==
          textEditingController.text.toLowerCase().trim())) {
        ScaffoldMessenger.of(Get.context!).showSnackBar(
          const SnackBar(
              content: Text('Todo exists in the list!'),
              dismissDirection: DismissDirection.down,
              behavior: SnackBarBehavior.floating,
              showCloseIcon: true),
        );
      } else {
        DocumentReference docRef = await fireStore.collection('todos').add(
          {
            'description': textEditingController.text.trim(),
            'isComplete': false,
          },
        );
        clearText();

        String taskId = docRef.id;
        await fireStore.collection('todos').doc(taskId).update(
          {'id': taskId},
        );
      }
    }
  }

  void changeStatus(TodoModel todo) async {
    String taskId = todo.id!;
    await fireStore.collection('todos').doc(taskId).update(
      {'isComplete': !todo.isComplete!},
    );
  }

  void deleteTodo(TodoModel todo) async {
    String taskId = todo.id!;
    await fireStore.collection('todos').doc(taskId).delete();
    clearText();
  }

  void changeEditStatus(TodoModel todo) {
    if (pendingEditTodo.value == null) {
      pendingEditTodo.value = todo;
      textEditingController.text = todo.description!;
    } else {
      pendingEditTodo.value = null;
      textEditingController.clear();
    }
  }

  void editTodo() async {
    String taskId = pendingEditTodo.value!.id!;
    if (formKey.currentState?.validate() ?? false) {
      await fireStore.collection('todos').doc(taskId).update({
        'description': textEditingController.text.trim(),
      });
      clearText();
    }
  }

  void clearText() {
    textEditingController.clear();
    pendingEditTodo.value = null;
    searchStr('');
    onUnfocused(true);
  }
}
