import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:get/get.dart';
import 'package:vpn_basic_project/widgets/count_down_timer.dart';
import 'package:vpn_basic_project/widgets/home_card.dart';
import '../main.dart';
import '../models/vpn_config.dart';
import '../models/vpn_status.dart';
import '../services/vpn_engine.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _vpnState = VpnEngine.vpnDisconnected;
  List<VpnConfig> _listVpn = [];
  VpnConfig? _selectedVpn;
 final RxBool _startTimer = false.obs;



  @override
  void initState() {
    super.initState();

    ///Add listener to update vpn state
    VpnEngine.vpnStageSnapshot().listen((event) {
      setState(() => _vpnState = event);
    });

    initVpn();
  }

  void initVpn() async {
    //sample vpn config file (you can get more from https://www.vpngate.net/)
    _listVpn.add(VpnConfig(
        config: await rootBundle.loadString('assets/vpn/japan.ovpn'),
        country: 'Japan',
        username: 'vpn',
        password: 'vpn'));

    _listVpn.add(VpnConfig(
        config: await rootBundle.loadString('assets/vpn/thailand.ovpn'),
        country: 'Thailand',
        username: 'vpn',
        password: 'vpn'));

    SchedulerBinding.instance.addPostFrameCallback(
        (t) => setState(() => _selectedVpn = _listVpn.first));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: Text('Free OpenVPN', style: TextStyle(
          color: Colors.white, fontWeight: FontWeight.w600
        ),),
        leading: Icon(CupertinoIcons.home),
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.brightness_medium,
                size: 28,
              )),
          IconButton(
              padding: EdgeInsets.only(
                top: 3,
              ),
              onPressed: () {},
              icon: Icon(
                CupertinoIcons.info,
                size: 26,
              )),
        ],
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.white),
      ),





      body: Column(
          // mainAxisSize: MainAxisSize.min,
          // crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // SizedBox(height: mq.height * 0.02, width: double.maxFinite,),
            //VPN Button
            _vpnButton(),

            
            // SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                HomeCard(
                    title: 'Country',
                    subtitle: 'INDIA',
                    icon: CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.blue,
                      child: Icon(Icons.vpn_lock_rounded,
                        size: 30,color: Colors.white,),),

                ),

                HomeCard(
                  title: '20ms',
                  subtitle: 'PING',
                  icon: CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.orange,
                    child: Icon(Icons.equalizer_rounded,
                      size: 30,color: Colors.white,),),

                )

              ],
            ),
            // SizedBox(height: mq.height* .02,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                HomeCard(
                  title: '0 Kbps',
                  subtitle: 'DOWNLOAD',
                  icon: CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.lightGreen,
                    child: Icon(Icons.arrow_downward,
                      size: 30,color: Colors.white,),),

                ),

                HomeCard(
                  title: '0 Kbps',
                  subtitle: 'UPLOAD',
                  icon: CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.yellow.shade600,
                    child: Icon(Icons.arrow_upward,
                      size: 30,color: Colors.white,),),

                )

              ],
            ),


           ]),
        bottomNavigationBar: _changeLocation(),
    );
  }

  void _connectClick() {
    ///Stop right here if user not select a vpn
    if (_selectedVpn == null) return;

    if (_vpnState == VpnEngine.vpnDisconnected) {
      ///Start if stage is disconnected
      VpnEngine.startVpn(_selectedVpn!);
    } else {
      ///Stop if stage is "not" disconnected
      VpnEngine.stopVpn();
    }
  }

  //VPN Button
  Widget _vpnButton() => Column(
    children: [

      //button
      Semantics(
            button: true,
            child: InkWell(
              onTap: (){
                _startTimer.value= !_startTimer.value;
              },
              borderRadius: BorderRadius.circular(100),
              child: Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                    color: Colors.blue.withOpacity(.2), shape: BoxShape.circle),
                child: Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                      color: Colors.blue.withOpacity(.3), shape: BoxShape.circle),
                  child: Container(
                    width: mq.height * .14,
                    height: mq.height * .14,
                    decoration:
                        BoxDecoration(color: Colors.blue, shape: BoxShape.circle),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.power_settings_new_rounded,
                          size: 28,
                          color: Colors.white,
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          "Tap to Connect",
                          style: TextStyle(
                              fontSize: 12.5,
                              color: Colors.white,
                              fontWeight: FontWeight.w600),
                        ),

                      ],

                    ),
                  ),

                ),

              ),
            ),
          ),
      //connection status label
      Container(
        margin: EdgeInsets.only(top: mq.height * 0.012, bottom: mq.height * 0.033),
        padding: EdgeInsets.symmetric(vertical: 6, horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(16)
        ),

        child: Padding(
          padding: const EdgeInsets.only(top: 2),
          child: Text(
            'Not Connected',
            style: TextStyle(
              fontSize: 12.5,
              color: Colors.white,
              fontWeight: FontWeight.w500
            ),
          ),
        ),
      ),

      Obx(() => CountDownTimer(startTimer: _startTimer.value)),
    ],
  );

  Widget _changeLocation() => SafeArea(
    child: Container(
      height: 60,
      color: Colors.blue,
      padding: EdgeInsets.symmetric(horizontal: mq.width * 0.04),
      child: Row(
        children: [
          
          Icon(CupertinoIcons.globe, color: Colors.white, size: 28,),
          SizedBox(width: 10,),
          Text("Change Location", style: TextStyle(color: Colors.white,fontSize: 16,
          fontWeight: FontWeight.w500
          ),),
          Spacer(),
          CircleAvatar(
             // Set the background to transparent
            child: Icon(
              Icons.keyboard_arrow_right,
              color: Colors.black54,
              size: 16,
            ),
          )

        ],
      ),
    ),
  );


}



//Previous code

//
// child: TextButton(
// style: TextButton.styleFrom(
// shape: StadiumBorder(),
// backgroundColor: Colors.blue,
// ),
// child: Text(
// _vpnState == VpnEngine.vpnDisconnected
// ? 'Connect VPN'
//     : _vpnState.replaceAll("_", " ").toUpperCase(),
// style: TextStyle(color: Colors.white),
// ),
// onPressed: _connectClick,
// ),
// ),
// StreamBuilder<VpnStatus?>(
// initialData: VpnStatus(),
// stream: VpnEngine.vpnStatusSnapshot(),
// builder: (context, snapshot) => Text(
// "${snapshot.data?.byteIn ?? ""}, ${snapshot.data?.byteOut ?? ""}",
// textAlign: TextAlign.center),
// ),
//
// //sample vpn list
// Column(
// children: _listVpn
//     .map(
// (e) => ListTile(
// title: Text(e.country),
// leading: SizedBox(
// height: 20,
// width: 20,
// child: Center(
// child: _selectedVpn == e
// ? CircleAvatar(
// backgroundColor: Colors.green)
//     : CircleAvatar(
// backgroundColor: Colors.grey)),
// ),
// onTap: () {
// log("${e.country} is selected");
// setState(() => _selectedVpn = e);
// },
// ),
// )
// .toList())