import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vpn_basic_project/screens/home_screen.dart';

import '../main.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {



  @override
  void initState() {

    SystemChrome.setEnabledSystemUIMode(
        SystemUiMode.edgeToEdge
    );

    super.initState();

    Future.delayed(Duration(milliseconds: 3000), (){
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (_) => HomeScreen()));
    });

  }


  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            left: mq.width * .3,
            width: mq.width * 0.4,
            top: mq.height * 0.2,
            child: Image.asset('assets/images/logo.png')
        ),
          Positioned(
            bottom: mq.height* .45,
              width: mq.width,
              child: Text("Open VPN 🌎",
                textAlign: TextAlign.center,
                style: TextStyle(
                color: Colors.black87, letterSpacing: 1,
                  fontSize: 22, fontWeight: FontWeight.bold
              ),)
          ),
          Positioned(
              bottom: mq.height* .15,
              width: mq.width,
              child: Text("MADE IN INDIA ❤️",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.black87, letterSpacing: 1,

                ),)
          )
        ],
      ),
    );
  }
}
