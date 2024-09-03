// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../helper/my_dialog.dart';
// import '../helper/pref.dart';
// import '../models/vpn.dart';
// import '../models/vpn_config.dart';
// import '../services/vpn_engine.dart';
//
// class HomeController extends GetxController {
//   final Rx<Vpn> vpn = Pref.vpn.obs;
//   final vpnState = VpnEngine.vpnDisconnected.obs;
//
//   void connectToVpn() async {
//     if (vpn.value.openVPNConfigDataBase64.isEmpty) {
//       MyDialogs.info(msg: 'Select a Location by clicking \'Change Location\'');
//       return;
//     }
//
//     if (vpnState.value == VpnEngine.vpnDisconnected) {
//       final data = base64.decode(vpn.value.openVPNConfigDataBase64);
//       final config = utf8.decode(data);
//       final vpnConfig = VpnConfig(
//         country: vpn.value.countryLong,
//         username: 'vpn',
//         password: 'vpn',
//         config: config,
//       );
//
//       // Code to initiate the VPN connection with vpnConfig
//       Color get getButtonColor {
//         switch (vpnState.value) {
//           case VpnEngine.vpnDisconnected:
//             return Colors.blue;
//           case VpnEngine.vpnConnected:
//             return Colors.green;
//           default:
//             return Colors.orangeAccent;
//         }
//       }
//
//       // VPN button text based on state
//       String get getButtonText {
//         switch (vpnState.value) {
//           case VpnEngine.vpnDisconnected:
//             return 'Tap to Connect';
//           case VpnEngine.vpnConnected:
//             return 'Disconnect';
//           default:
//             return 'Connecting...';
//         }
//       }
//       await VpnEngine.startVpn(vpnConfig);
//
//     } else {
//       // await VpnEngine.stopVpn();
//     }
//
//     // Code to show interstitial ad and then connect to VPN
//   }
//
//   // VPN button color based on state
//
// }


import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../helper/my_dialog.dart';
import '../helper/pref.dart';
import '../models/vpn.dart';
import '../models/vpn_config.dart';
import '../services/vpn_engine.dart';

class HomeController extends GetxController {
  final Rx<Vpn> vpn = Pref.vpn.obs;
  final vpnState = VpnEngine.vpnDisconnected.obs;

  void connectToVpn() async {
    if (vpn.value.openVPNConfigDataBase64.isEmpty) {
      MyDialogs.info(msg: 'Select a Location by clicking \'Change Location\'');
      return;
    }

    if (vpnState.value == VpnEngine.vpnDisconnected) {
      final data = base64.decode(vpn.value.openVPNConfigDataBase64);
      final config = utf8.decode(data);
      final vpnConfig = VpnConfig(
        country: vpn.value.countryLong,
        username: 'vpn',
        password: 'vpn',
        config: config,
      );

      vpnState.value = VpnEngine.vpnConnecting;
      await VpnEngine.startVpn(vpnConfig);
      vpnState.value = VpnEngine.vpnConnected;

    } else {
      // vpnState.value = VpnEngine.vpnDisconnecting;
      await VpnEngine.stopVpn();
      vpnState.value = VpnEngine.vpnDisconnected;
    }

    // Code to show interstitial ad and then connect to VPN

  }

  // vpn buttons color
  Color get getButtonColor {
    switch (vpnState.value) {
      case VpnEngine.vpnDisconnected:
        return Colors.blue;

      case VpnEngine.vpnConnected:
        return Colors.green;

      default:
        return Colors.orangeAccent;
    }
  }

  // vpn button text
  String get getButtonText {
    switch (vpnState.value) {
      case VpnEngine.vpnDisconnected:
        return 'Tap to Connect';

      case VpnEngine.vpnConnected:
        return 'Disconnect';

      default:
        return 'Connecting...';
    }
  }
}
