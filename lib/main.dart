import 'screens/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';
import 'screens/pin_screen.dart';
import 'screens/theme/color_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  Future<String?> getPIN() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? PIN = prefs.getString('PIN');
    return PIN;
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
        fontFamily: 'Pretendard',
        primaryColor: AbColor.ABMainColor,
        colorScheme: const ColorScheme.light(
          background: Colors.white,
          brightness: Brightness.light,
          primary: AbColor.ABMainColor,
        ),
      ),
      home: FutureBuilder(
        future: getPIN(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else {
            if (snapshot.hasData) {
              return const PINScreen();
            } else {
              return const MainScreen();
            }
          }
        },
      ),
    );
  }
}
