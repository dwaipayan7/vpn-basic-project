import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vpn_basic_project/api/api.dart';

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
      // body: ,
    );
  }
}
