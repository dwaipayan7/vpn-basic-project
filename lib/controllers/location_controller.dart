import 'package:get/get.dart';


import '../api/api.dart';
import '../helper/pref.dart';
import '../models/vpn.dart';

class LocationController extends GetxController {
  List<Vpn> vpnList = Pref.vpnList;

  final RxBool isLoading = false.obs;

  Future<void> getVpnData() async {
    isLoading.value = true;
    vpnList.clear();
    vpnList = await API.getVPNServers();
    isLoading.value = false;
  }
}