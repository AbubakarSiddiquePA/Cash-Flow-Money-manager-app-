import 'dart:developer';

import 'package:cash_flow/models/category/category_model.dart';

oneTimeScreen() {
  final box = Splashscreens.getdata();
  final data = Splashscreens(screens: 1);
  box.put(0, data);
  data.save();
  log("${box.get(0)!.screens} value added");
}
