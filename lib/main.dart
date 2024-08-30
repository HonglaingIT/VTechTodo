import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vtech_todo/module/todo/controller/todo_binding.dart';
import 'package:vtech_todo/module/todo/screen/todo_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
    apiKey: 'AIzaSyAbUu_wuP14Wwbm1gpvTqKMXOANCcC0cFI',
    appId: 'vtechtodo',
    messagingSenderId: 'sendid',
    projectId: 'vtechtodo',
    storageBucket: 'vtechtodo.appspot.com',
  ));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: const TodoScreen(),
      initialBinding: TodoBinding(),
    );
  }
}
