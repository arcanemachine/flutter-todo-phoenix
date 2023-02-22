import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_todo_phoenix/providers.dart';
import 'package:flutter_todo_phoenix/state.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:flutter_todo_phoenix/constants.dart';
import 'package:flutter_todo_phoenix/styles.dart';

class WebViewScreen extends ConsumerStatefulWidget {
  const WebViewScreen({Key? key}) : super(key: key);

  @override
  WebViewScreenState createState() => WebViewScreenState();
}

class WebViewScreenState extends ConsumerState<WebViewScreen> {
  final GlobalKey webViewKey = GlobalKey();

  double loadingProgress = 0;
  int bottomBarSelectedIndex = 0;

  String url = constants.urlPathBase;
  final urlController = TextEditingController();

  InAppWebViewController? webViewController;
  PullToRefreshController? pullToRefreshController;

  @override
  void initState() {
    super.initState();

    pullToRefreshController = kIsWeb
        ? null
        : PullToRefreshController(
            settings: PullToRefreshSettings(
              color: Colors.blue,
            ),
            onRefresh: () async {
              if (defaultTargetPlatform == TargetPlatform.android) {
                webViewController?.reload();
              } else if (defaultTargetPlatform == TargetPlatform.iOS) {
                webViewController?.loadUrl(
                    urlRequest:
                        URLRequest(url: await webViewController?.getUrl()));
              }
            },
          );
  }

  @override
  Widget build(BuildContext context) {
    BottomNavigationBar bottomNavigationBar(BuildContext context) {
      void onItemTapped(int index) {
        setState(() {
          bottomBarSelectedIndex = index;

          if (bottomBarSelectedIndex == 0) {
            // ignore repeated taps on the same item
            if (url != constants.urlPathBase) {
              // if the item isn't already selected, navigate to URL
              url = constants.urlPathBase;
            } else {
              // on repeated taps, refresh the page
              webViewController?.reload();
            }
          } else if (bottomBarSelectedIndex == 1) {
            if (url != constants.urlPathSettings) {
              // if the item isn't already selected, navigate to URL
              url = constants.urlPathSettings;
            } else {
              // on repeated taps, refresh the page
              webViewController?.reload();
            }
          }
        });

        webViewController?.loadUrl(
          urlRequest: URLRequest(
            url: WebUri(url),
            headers: {"x-platform": "flutter"},
          ),
        );
      }

      return BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.task),
            label: 'Items',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
        currentIndex: bottomBarSelectedIndex,
        selectedItemColor: colors.palette.primary,
        onTap: onItemTapped,
      );
    }

    return WillPopScope(
      onWillPop: () async {
        final controller = webViewController;

        if (controller != null) {
          if (url == constants.urlPathBase) {
            // if the back button is pressed while we are at the base URL,
            // then close the app
            SystemChannels.platform.invokeMethod('SystemNavigator.pop');
          } else if (url == constants.urlPathSettings) {
            // if the back button is pressed while we are at the settings URL,
            // then clear history, return to base URL, and set index to 0
            controller.clearHistory();

            // select bottom bar icon: 'items'
            setState(() {
              bottomBarSelectedIndex = 0;
            });

            controller.loadUrl(
              urlRequest: URLRequest(
                url: WebUri(constants.urlPathBase),
                headers: {"x-platform": "flutter"},
              ),
            );

            return false;
          }

          if (await controller.canGoBack()) {
            controller.goBack();
            return false;
          }
        }

        return true;
      },
      child: SafeArea(
        child: Scaffold(
          body: bodyContainer(),
          bottomNavigationBar: bottomNavigationBar(context),
        ),
      ),
    );
  }

  Widget bodyContainer() {
    return Column(
      children: <Widget>[
        Expanded(
          child: Stack(
            children: [
              inAppWebView(),
              loadingProgress < 1.0
                  ? LinearProgressIndicator(value: loadingProgress)
                  : Container(),
            ],
          ),
        ),
      ],
    );
  }

  InAppWebView inAppWebView() {
    return InAppWebView(
      key: webViewKey,
      initialUrlRequest: URLRequest(
        url: WebUri(url),
        headers: {"x-platform": "flutter"},
      ),
      initialSettings: InAppWebViewSettings(
        useShouldOverrideUrlLoading: true,
        mediaPlaybackRequiresUserGesture: false,
        allowsInlineMediaPlayback: true,
        iframeAllow: "camera; microphone",
        iframeAllowFullscreen: true,
      ),
      pullToRefreshController: pullToRefreshController,
      onWebViewCreated: (controller) {
        webViewController = controller;

        /* javascript handlers */
        // dark mode - set
        controller.addJavaScriptHandler(
          handlerName: "darkModeSet",
          callback: (args) {
            final String darkModeEnabled = args[0];

            ref.read(themeProvider.notifier).state =
                darkModeEnabled; // update theme
            sharedPrefs.theme = darkModeEnabled; // save theme in preferences

            setState(() {}); // update the widget even if the theme is the same
          },
        );

        // selected index - set
        controller.addJavaScriptHandler(
          handlerName: "bottomBarSelectedIndexSet",
          callback: (args) {
            setState(() {
              bottomBarSelectedIndex = args[0];
            }); // update the widget even if the theme is the same
          },
        );
      },
      onLoadStart: (controller, url) {
        setState(() {
          this.url = url.toString();
          urlController.text = this.url;
        });
      },
      onPermissionRequest: (controller, request) async {
        return PermissionResponse(
            resources: request.resources,
            action: PermissionResponseAction.GRANT);
      },
      shouldOverrideUrlLoading: (controller, navigationAction) async {
        var uri = navigationAction.request.url!;

        if (Platform.isAndroid) {
          if (navigationAction.request.headers?["x-platform"] != "flutter") {
            // add flutter identification header
            controller.loadUrl(
              urlRequest: URLRequest(
                url: WebUri(navigationAction.request.url.toString()),
                headers: {
                  "x-platform": "flutter",
                },
              ),
            );
            return NavigationActionPolicy.CANCEL;
          }
        }

        if (!["http", "https", "file", "chrome", "data", "javascript", "about"]
            .contains(uri.scheme)) {
          if (await canLaunchUrl(uri)) {
            // Launch the App
            await launchUrl(
              uri,
            );
            // and cancel the request
            return NavigationActionPolicy.CANCEL;
          }
        }

        return NavigationActionPolicy.ALLOW;
      },
      onLoadStop: (controller, url) async {
        pullToRefreshController?.endRefreshing();
        setState(() {
          this.url = url.toString();
          urlController.text = this.url;
        });
      },
      onReceivedError: (controller, request, error) {
        pullToRefreshController?.endRefreshing();
      },
      onProgressChanged: (controller, progress) {
        if (progress == 100) {
          pullToRefreshController?.endRefreshing();
        }
        setState(() {
          loadingProgress = progress / 100;
          urlController.text = url;
        });
      },
      onUpdateVisitedHistory: (controller, url, androidIsReload) {
        setState(() {
          this.url = url.toString();
          urlController.text = this.url;
        });
      },
      onConsoleMessage: (controller, consoleMessage) {
        debugPrint(consoleMessage.toString());
      },
    );
  }
}
