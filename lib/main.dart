import 'package:flutter/material.dart';
import 'package:post_api_app_flutter/pages/post_register.dart';
import 'package:post_api_app_flutter/without%20model/getmethodpage_without_model.dart';

import 'pages/post_login.dart';
import 'pages/post_update.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const GetmethodpageWithoutModel(),
    );
  }
}

// to check the api manually enter the page name 