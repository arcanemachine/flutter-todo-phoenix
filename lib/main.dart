import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter_todo_phoenix/constants.dart';
// import 'package:flutter_todo_phoenix/helpers.dart';
import 'package:flutter_todo_phoenix/routes.dart';
import 'package:flutter_todo_phoenix/screens/web_view.dart';
import 'package:flutter_todo_phoenix/state.dart';
import 'package:flutter_todo_phoenix/providers.dart';
import 'package:flutter_todo_phoenix/styles.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // enable webview debugging on android
  if (defaultTargetPlatform == TargetPlatform.android) {
    await InAppWebViewController.setWebContentsDebuggingEnabled(true);
  }

  // load persistent data
  await sharedPrefs.init();

  // // attempt to initialize firebase
  // try {
  //   await helpers.initializeFcm();
  // } catch (err) {
  //   debugPrint("Could not initialize FCM.");
  //   // sharedPrefs.hasPlayServices = false;
  // }

  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // theme
    final defaultTheme = ThemeData(
      primarySwatch:
          styles.colors.generateMaterialColor(colors.palette.primary),
    );

    return MaterialApp.router(
      routerConfig: router,
      title: constants.projectName,
      theme: defaultTheme,
      darkTheme: ThemeData.dark(),
      themeMode: ref.watch(themeProvider) == 'light'
          ? ThemeMode.light
          : ref.watch(themeProvider) == 'dark'
              ? ThemeMode.dark
              : ThemeMode.system,
      debugShowCheckedModeBanner: false,
    );
  }
}

class InitScreen extends ConsumerWidget {
  const InitScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const WebViewScreen();
  }
}
