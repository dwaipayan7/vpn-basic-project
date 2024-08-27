
import 'dart:convert';
import 'dart:developer';

import 'package:csv/csv.dart';
import 'package:http/http.dart';
import 'package:vpn_basic_project/models/vpn.dart';

class API{
  static Future<List<Vpn>> getVPNServers() async{
    final List<Vpn> vpnList = [];

try{
  final res = await get(Uri.parse('https://www.vpngate.net/api/iphone/'));

  final csvString = res.body.split("#")[1].replaceAll('*', '');
  List<List<dynamic>> list = const CsvToListConverter().convert(csvString);
  final header = list[0];

  Map<String, dynamic> tempJson = {};
  for(int i = 1; i< list.length-1; i++){
    if(list[i].isNotEmpty){
      for(int j=0; j<header.length; j++){
        tempJson.addAll({header[j].toString() : list[i][j]});
      }
      vpnList.add(Vpn.fromJson(tempJson));
    }

  }
  // log(vpnList.first.hostname);
}catch(e){
  Exception(e);
}


    return vpnList;

    // log(res.body);
  }
}