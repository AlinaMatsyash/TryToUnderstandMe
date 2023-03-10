import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../theme/app_theme.dart';

class ThemeController extends GetxController {
  final box = GetStorage();

  bool get isDark => box.read('darkmode') ?? false;

  ThemeData get theme => isDark ? AppTheme.darkTheme : AppTheme.lightTheme;

  void changeTheme(bool val) => box.write('darkmode', val);
}
