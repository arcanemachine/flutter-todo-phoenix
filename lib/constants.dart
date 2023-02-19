// import 'package:flutter/foundation.dart';

class _Constants {
  String get projectName => "Todo List";
  String get serverUrl => "http://192.168.1.100:4002";
  String get urlPathBase => "$serverUrl/todos/live";
  String get urlPathSettings => "$serverUrl/users/settings";
  //     kDebugMode ? "http://192.168.1.100:4002" : "https://your-domain.com";
}

final constants = _Constants();
