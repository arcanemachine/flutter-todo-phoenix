import 'package:shared_preferences/shared_preferences.dart';

// shared preferences
class SharedPrefs {
  late SharedPreferences? _sharedPrefs;

  init() async {
    _sharedPrefs = await SharedPreferences.getInstance();

    // clear ephemeral data on startup
    // _sharedPrefs?.remove('route_previous');

    // set default values
    if (_sharedPrefs?.getBool('is_authenticated') != true) {
      _sharedPrefs?.setBool('is_authenticated', false);
    }

    // if (_sharedPrefs?.getBool('has_play_services') != true) {
    //   _sharedPrefs?.setBool('has_play_services', false);
    // }
  }

  // utility
  void clearAll() {
    _sharedPrefs?.clear();
  }

  void clearSession() {
    logout();
    // _sharedPrefs?.remove('company_name_current');
  }

  // auth
  bool get userIsAuthenticated =>
      _sharedPrefs?.getBool('is_authenticated') ?? false;
  set userIsAuthenticated(bool val) {
    _sharedPrefs?.setBool('is_authenticated', val);
  }

  login() {
    _sharedPrefs?.setBool('is_authenticated', true);
  }

  logout() {
    _sharedPrefs?.setBool('is_authenticated', false);
  }

  // dark_mode
  String get darkMode => _sharedPrefs?.getString('dark_mode') ?? 'light';
  set darkMode(String val) {
    _sharedPrefs?.setString('dark_mode', val);
  }

  // // has_play_services
  // bool get hasPlayServices =>
  //     _sharedPrefs?.getBool('has_play_services') ?? false;
  // set hasPlayServices(bool val) {
  //   _sharedPrefs?.setBool('has_play_services', val);
  // }

  // // routes
  // String get routeCurrent => _sharedPrefs?.getString('route_current') ?? "";
  // set routeCurrent(String val) {
  //   _sharedPrefs?.setString('route_current', val);
  // }
}

final SharedPrefs sharedPrefs = SharedPrefs();
