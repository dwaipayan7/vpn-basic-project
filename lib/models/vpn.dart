class Vpn {
  Vpn({
    required this.hostname,
    required this.IP,
    required this.Score,
    required this.Ping,
    required this.Speed,
    required this.CountryLong,
    required this.CountryShort,
    required this.NumVpnSessions,
    required this.Uptime,
    required this.TotalUsers,
    required this.TotalTraffic,
    required this.LogType,
    required this.Operator,
    required this.Message,
    required this.OpenVPNConfigDataBase64,
  });
  late final String hostname;
  late final String IP;
  late final int Score;
  late final String Ping;
  late final int Speed;
  late final String CountryLong;
  late final String CountryShort;
  late final int NumVpnSessions;
  late final int Uptime;
  late final int TotalUsers;
  late final int TotalTraffic;
  late final String LogType;
  late final String Operator;
  late final String Message;
  late final String OpenVPNConfigDataBase64;

  Vpn.fromJson(Map<String, dynamic> json){
    hostname = json['HostName'] ?? '';
    IP = json['IP']?? '';
    Score = json['Score']?? '';
    Ping = json['Ping'].toString();
    Speed = json['Speed'] ?? 0;
    CountryLong = json['CountryLong']?? '';
    CountryShort = json['CountryShort']?? '';
    NumVpnSessions = json['NumVpnSessions']?? '';
    Uptime = json['Uptime']?? '';
    TotalUsers = json['TotalUsers']?? '';
    TotalTraffic = json['TotalTraffic']?? '';
    LogType = json['LogType']?? '';
    Operator = json['Operator']?? '';
    Message = json['Message']?? '';
    OpenVPNConfigDataBase64 = json['OpenVPN_ConfigData_Base64']?? '';
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['hostname'] = hostname;
    _data['IP'] = IP;
    _data['Score'] = Score;
    _data['Ping'] = Ping;
    _data['Speed'] = Speed;
    _data['CountryLong'] = CountryLong;
    _data['CountryShort'] = CountryShort;
    _data['NumVpnSessions'] = NumVpnSessions;
    _data['Uptime'] = Uptime;
    _data['TotalUsers'] = TotalUsers;
    _data['TotalTraffic'] = TotalTraffic;
    _data['LogType'] = LogType;
    _data['Operator'] = Operator;
    _data['Message'] = Message;
    _data['OpenVPN_ConfigData_Base64'] = OpenVPNConfigDataBase64;
    return _data;
  }
}