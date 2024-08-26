
import 'dart:developer';

import 'package:http/http.dart';

class API{
  static Future<void> getVPNServers() async{
    
    final res = await get(Uri.parse('https://www.vpngate.net/api/iphone/'));
    log(res.body);
  }
}