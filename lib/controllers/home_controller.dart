

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vpn_basic_project/models/vpn.dart';

import '../api/api.dart';
import '../services/vpn_engine.dart';

class HomeController extends GetxController{

  final vpnState = VpnEngine.vpnDisconnected.obs;
  final RxBool startTimer = false.obs;

  Future<void> initialData() async{

  }

  //vpn buttons color
  Color get getButtonColor {
    switch(vpnState.value){
      case VpnEngine.vpnDisconnected:
        return Colors.blue;

      case VpnEngine.vpnConnected:
        return Colors.green;

      default:
        return Colors.orangeAccent;
    }
  }

  //vpn button text

  String get getButtonText{
    switch(vpnState.value){
      case VpnEngine.vpnDisconnected:
        return 'Tap to Connect';

      case VpnEngine.vpnConnected:
        return 'Disconnected';

      default:
        return 'Connecting...';
    }
  }

}