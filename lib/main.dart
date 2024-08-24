import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:vpn_basic_project/screens/splashScreen.dart';

// Global object for accessing screen size
late Size mq;

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // Enter full screen
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);

  // Set preferred orientations to portrait mode
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((_) {
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'OpenVpn Application',
      home: const SplashScreen(),
    );
  }
}
