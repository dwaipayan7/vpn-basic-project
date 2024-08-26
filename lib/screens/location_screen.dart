import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:vpn_basic_project/api/api.dart';

import '../main.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({super.key});

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    API.getVPNServers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: Text('Free OpenVPN', style: TextStyle(
            color: Colors.white, fontWeight: FontWeight.w600
        ),),

        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: _loadingWidget(),
    );
  }


  _loadingWidget ()=> SizedBox(
    width: double.infinity,
    height: double.infinity,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        //Lottie Animation
        LottieBuilder.asset('assets/lottie/loading.json', width: mq.width*0.7,),
        Text("Loading VPN's...🙂\n", style: TextStyle(
          fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black54
        ),)
      ],
    ),
  );

  _noVpnFound(){
    Center(
      child: Text("No VPN's Found...😟\n", style: TextStyle(
          fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black54
      ),),
    );
  }

}
