import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:try_understand_me/screens/home_screen.dart';

import 'controller/change_theme.dart';

void main() async {
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    final controller = Get.put(ThemeController());
    return SimpleBuilder(builder: (context) {
      return MaterialApp(
        title: 'Try to understand me',
        theme: controller.theme,
        home: const HomeScreen(),
      );
    });
  }
}
