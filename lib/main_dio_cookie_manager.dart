import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart' as dioCookieManager;
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart' as inAppWebView;
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final dio = Dio();
  final cookieJar = CookieJar();
  bool isFetchedCookie;

  @override
  void initState() {
    super.initState();
    setState(() => isFetchedCookie = false);
    dio.interceptors.add(dioCookieManager.CookieManager(cookieJar));
  }

  @override
  Widget build(BuildContext context) {
    final mediaSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Container(
            alignment: Alignment.center,
            child: ElevatedButton(
              child: Text('get cookie'),
              onPressed: () async {
                await dio.get('https://www.google.com/');
                var cookies = cookieJar.loadForRequest(
                  Uri.parse('https://www.google.com/'),
                );
                print(cookies);

                final webViewCookieManager =
                    inAppWebView.CookieManager.instance();
                cookies.forEach((c) {
                  print('url=${c.domain}. name=${c.name}. value=${c.value}');
                  webViewCookieManager.setCookie(
                      url: 'https://${c.domain}', name: c.name, value: c.value);
                });

                setState(() => isFetchedCookie = true);
              },
            ),
          ),
          if (isFetchedCookie)
            Container(
              width: mediaSize.width,
              height: mediaSize.height * 0.5,
              child: inAppWebView.InAppWebView(
                initialUrl: 'https://www.google.com/',
                onWebViewCreated: (controller) {
                  controller.setOptions(
                    options: InAppWebViewGroupOptions(
                        crossPlatform: InAppWebViewOptions(
                          debuggingEnabled: true,
                          clearCache: false,
                          useShouldOverrideUrlLoading: true,
                          javaScriptCanOpenWindowsAutomatically: true,
                        ),
                        ios: IOSInAppWebViewOptions(),
                        android: AndroidInAppWebViewOptions(
                            supportMultipleWindows: true)),
                  );
                },
                onCreateWindow: (controller, createWindowRequest) async {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) {
                      return LinkPage(
                        url: createWindowRequest.url,
                        windowId: createWindowRequest.windowId,
                      );
                    },
                  ));
                  // iOSでは、return trueにすると、クラッシュしてしまった
                  return false;
                },
              ),
            ),
        ],
      ),
    );
  }
}

class LinkPage extends StatelessWidget {
  final String url;
  final int windowId;

  const LinkPage({Key key, this.url, this.windowId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: inAppWebView.InAppWebView(
          // https://medium.com/flutter-community/inappwebview-the-real-power-of-webviews-in-flutter-c6d52374209dには、windowIdで実施する方法が記載されているが動作しなかった
          // windowId: windowId,
          initialUrl: url,
        ),
      ),
    );
  }
}
