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
  final isSearch = false.obs;

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
      DocumentReference docRef = await fireStore.collection('todos').add(
        {
          'description': textEditingController.text,
          'isComplete': false,
        },
      );
      _clearText();

      String taskId = docRef.id;
      await fireStore.collection('todos').doc(taskId).update(
        {'id': taskId},
      );
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
        'description': textEditingController.text,
      });
      _clearText();
    }
  }

  void _clearText() {
    textEditingController.clear();
    pendingEditTodo.value = null;
    onUnfocused(true);
  }
}
