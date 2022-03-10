import 'package:get/get.dart';
import 'package:prefs/prefs.dart';

import '../../NewList/Controllers/news_list_controller.dart';

class MainAppController extends GetxController {
  @override
  void onInit() async {
    Get.put(NewsListController());

    super.onInit();
  }

  @override
  void dispose() {
    Prefs.dispose();
    super.dispose();
  }
}
