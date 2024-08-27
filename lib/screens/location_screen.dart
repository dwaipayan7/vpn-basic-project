import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_common/get_reset.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:lottie/lottie.dart';
import 'package:vpn_basic_project/api/api.dart';
import 'package:vpn_basic_project/controllers/location_controller.dart';

import '../main.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({super.key});

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  final _controller = LocationController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller.getVpnData();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      ()=> Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blueAccent,
          title: Text(
            'VPN Locations(${_controller.vpnList.length})',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
          ),
          centerTitle: true,
          iconTheme: IconThemeData(color: Colors.white),
        ),
        body: _controller.isLoading.value
            ? _loadingWidget() ?? _defaultWidget()
            : _controller.vpnList.isEmpty
            ? _noVpnFound() ?? _defaultWidget()
            : _vpnData() ?? _defaultWidget()),

    );
  }

  Widget _defaultWidget() {
    return Container(); // or any other widget as a fallback
  }

  _vpnData() => ListView.builder(
      itemCount: _controller.vpnList.length,
      itemBuilder: (context, index) =>Text(_controller.vpnList[index].hostname)
  );

  _loadingWidget() => SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //Lottie Animation
            LottieBuilder.asset(
              'assets/lottie/loading.json',
              width: mq.width * 0.7,
            ),
            Text(
              "Loading VPN's...🙂\n",
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black54),
            )
          ],
        ),
      );

  _noVpnFound() {
    Center(
      child: Text(
        "No VPN's Found...😟\n",
        style: TextStyle(
            fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black54),
      ),
    );
  }
}
