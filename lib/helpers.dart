// import 'firebase_options.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

// import 'package:flutter_todo_phoenix/state.dart';

class _Helpers {
  // _ExampleHelpers get example => _ExampleHelpers();

  bool canPop(BuildContext context) {
    final NavigatorState? navigator = Navigator.maybeOf(context);
    return navigator != null && navigator.canPop();
  }

  dynamic get templates => _TemplateHelpers();
  dynamic get widgets => _WidgetHelpers;
  // _ExampleHelpers get example => _ExampleHelpers();

  // Future<void> initializeFcm() async {
  //   // initialize firebase
  //   await Firebase.initializeApp(
  //     options: DefaultFirebaseOptions.currentPlatform,
  //   );

  //   // get FCM token
  //   final String? fcmToken = await FirebaseMessaging.instance.getToken();
  //   debugPrint("FCM Token: $fcmToken");

  //   // // To be notified whenever the token is updated, subscribe to the
  //   // // onTokenRefresh stream:
  //   // FirebaseMessaging.instance.onTokenRefresh
  //   // .listen((fcmToken) {
  //   //   // todo: If necessary send token to application server.

  //   //   // Note: This callback is fired at each app startup and whenever a new
  //   //   // token is generated.
  //   // })
  //   // .onError((err) {
  //   //   // Error getting token.
  //   // });

  //   // platform-specific code
  //   if (kIsWeb) {
  //     // because flutter web crashes when checking for other platforms, check
  //     // for it before checking for other platforms
  //   } else if (Platform.isAndroid) {
  //     // // handle background messages
  //     // @pragma('vm:entry-point')
  //     // Future<void> firebaseMessagingBackgroundHandler(
  //     //   RemoteMessage message,
  //     // ) async {
  //     //   debugPrint("Handling a background message: ${message.messageId}");
  //     // }

  //     // FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  //   } else if (Platform.isIOS) {
  //     // get notification permissions on iOS
  //     FirebaseMessaging messaging = FirebaseMessaging.instance;

  //     NotificationSettings settings = await messaging.requestPermission(
  //       alert: true,
  //       announcement: false,
  //       badge: true,
  //       carPlay: false,
  //       criticalAlert: false,
  //       provisional: false,
  //       sound: true,
  //     );

  //     debugPrint('User granted permission: ${settings.authorizationStatus}');
  //   }

  //   // handle foreground messages
  //   // On Android, you must create a "High Priority" notification channel.
  //   // On iOS, you can update the presentation options for the application.
  //   FirebaseMessaging.onMessage.listen((RemoteMessage message) {
  //     debugPrint('Got a message while in the foreground!');
  //     debugPrint('Message data: ${message.data}');

  //     if (message.notification != null) {
  //       debugPrint(
  //         'Message also contained a notification: ${message.notification}',
  //       );
  //     }
  //   });

  //   // sharedPrefs.hasPlayServices = true;
  // }

  // Future confirmAuthStatusOrLogout() async {}

  // String? routesLoginRequired() {
  //   if (!sharedPrefs.userIsAuthenticated) {
  //     return "/"; // redirect to login
  //   } else {
  //     return null; // continue to route
  //   }
  // }

  // Widget saveRoute(GoRouterState state, Widget widget) {
  //   /** Save incoming route to shared preferences so that it will be seen
  //     * first when first opening the app.
  //     */
  //   sharedPrefs.routeCurrent = state.location;
  //   return widget;
  // }
}

final helpers = _Helpers();

class _TemplateHelpers {
  String renderPageLoadError(WebUri url) {
    return """
<section
  style="height: 100vh;
         width: 100vw;
         display: flex;
         flex-direction: column;
         justify-content: center;
         align-items: center;"
>
  <h1 style="font-size: 3.5rem; margin-bottom: 1.25rem">
    Error: Not Connected
  </h1>
  <h2 style="font-size: 2.75rem">
    Check your connection and try again.
  </h2>
  <div
    id="reload-button"
    style="width: 100%;
           max-width: 90vw;
           padding: 5rem;
           font-size: 2.75rem;
           color: blue;
           text-align: center;"
  >
    Click here to reload
  </div>
</section>

<script>
  const reloadButtonElt = document.querySelector("#reload-button");

  // when reload button clicked, show loading text and reload
  reloadButtonElt.addEventListener("click", () => {
    reloadButtonElt.textContent = "Loading...";

    // reload after a brief delay so the user can see the loading text
    setTimeout(() => {
      location.href = '$url';
    }, 500);
  });
</script>

    """;
  }
}

// final _templateHelpers = _TemplateHelpers();

// widgets
class _WidgetHelpers {
  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> snackBarShow(
      BuildContext context, String message,
      [SnackBarAction? customAction]) {
    /** Hide existing snackbars and show a new one. */
    final scaffoldMessenger = ScaffoldMessenger.of(context);

    // hide existing snackbars
    scaffoldMessenger.clearSnackBars();

    return scaffoldMessenger.showSnackBar(
      SnackBar(
        content: Text(message),
        action: customAction ??
            SnackBarAction(
              label: 'OK',
              onPressed: () {},
            ),
      ),
    );
  }
}

// final _widgetHelpers = _WidgetHelpers();
