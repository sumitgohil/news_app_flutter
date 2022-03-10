import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:news_app/NewList/Screens/home_screen.dart';
import 'package:news_app/Utility/general_controllers/main_app_controller.dart';
import 'package:news_app/Utility/theme_service.dart';
import 'package:prefs/prefs.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  await GetStorage.init();
  await Prefs.init();
  await dotenv.load(fileName: "assets/.env");
  initRequiredThings();

  runApp(const MyApp());
}

initRequiredThings() async {
  // USED THIS METHOD TO INIT THINS LIKE ANALYTICS, FIREBASE, ONESIGNAL, DATABASE, PREFS ETC.. All the required things can be initialised insise the controller and disposed accordingly.

  Get.put(MainAppController());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'News',
      theme: Themes.light,
      darkTheme: Themes.dark,
      themeMode: ThemeService().theme,
      home: const HomeScreen(),
    );
  }
}
