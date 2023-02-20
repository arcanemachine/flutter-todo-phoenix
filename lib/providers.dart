import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_todo_phoenix/state.dart';

final themeProvider = StateProvider<String>((ref) => sharedPrefs.theme);
