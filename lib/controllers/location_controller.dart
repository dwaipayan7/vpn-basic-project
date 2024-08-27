

import 'package:get/get.dart';
import 'package:vpn_basic_project/models/vpn.dart';

import '../api/api.dart';

class LocationController extends GetxController{
  List<Vpn> vpnList = [];

  final RxBool isLoading = false.obs;

  Future<void> getVpnData() async{
    isLoading.value = true;
    vpnList =  await API.getVPNServers();
    isLoading.value = false;
  }

}