import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_todo_phoenix/globals.dart';
import 'package:flutter_todo_phoenix/state.dart';

final isLoadingProvider = StateProvider<bool>((ref) => false);
final themeProvider = StateProvider<String>((ref) => sharedPrefs.darkMode);

final urlProvider = StateProvider<String>((ref) => globals.basePath);
final navigationIndexProvider = StateProvider<int>((ref) => 0);
