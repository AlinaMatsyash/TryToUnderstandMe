import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:try_understand_me/screens/select_mode_screen.dart';

import '../controller/change_theme.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ThemeController>();
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  icon: const Icon(Icons.palette_outlined),
                  onPressed: () {
                    controller.isDark
                        ? controller.changeTheme(false)
                        : controller.changeTheme(true);
                  },
                ),
              ],
            ),
            Column(
              children: [
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: SizedBox(
                      height: 300,
                      width: 300,
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.asset("assets/images/logo.png")),
                    ),
                  ),
                ),
                const Text(
                  'Попробуй меня понять',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 25),
                ),
              ],
            ),
            SizedBox(
              height: 50,
              width: 200,
              child: FloatingActionButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) {
                        return SelectModeScreen();
                      },
                    ));
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  child: Text(
                    'Начать'.toUpperCase(),
                    style: const TextStyle(color: Colors.white),
                  )),
            ),
            const SizedBox(height: 0)
          ],
        ),
      ),
    );
  }
}
