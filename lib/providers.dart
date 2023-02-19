import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_todo_phoenix/constants.dart';
import 'package:flutter_todo_phoenix/state.dart';

import 'package:flutter/widgets.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

// class InAppWebViewControllerNotifier
//     extends StateNotifier<InAppWebViewController?> {
//   InAppWebViewControllerNotifier() : super(InAppWebViewController());
// }

final isLoadingProvider = StateProvider<bool>((ref) => false);
final themeProvider = StateProvider<String>((ref) => sharedPrefs.darkMode);

final webViewControllerProvider =
    StateProvider<InAppWebViewController?>((ref) => null);

final urlControllerProvider =
    StateProvider<TextEditingController>((ref) => TextEditingController());

final selectedIndexProvider = StateProvider<int>((ref) => 0);

final urlProvider =
    StateProvider<String>((ref) => "${constants.serverUrl}/todos/live");
