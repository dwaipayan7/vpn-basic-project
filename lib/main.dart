import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vpn_basic_project/screens/splashScreen.dart';
import 'screens/home_screen.dart';


//global object for accessing
late Size mq;

void main() {

  WidgetsFlutterBinding.ensureInitialized();
//Enter full screen
  SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.immersive
  );
//for setting orientation
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown]).then((value){

    runApp(const MyApp());
  });


}


class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'OpenVpn Application',
      home: SplashScreen(),
    );
  }
}
