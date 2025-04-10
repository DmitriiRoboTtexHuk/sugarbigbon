import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:modal_progress_indicator/modal_progress_indicator.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: WebViewWithLoader(),
    );
  }
}



class WebViewWithLoader extends StatefulWidget {
  @override
  _WebViewWithLoaderState createState() => _WebViewWithLoaderState();
}

class _WebViewWithLoaderState extends State<WebViewWithLoader> {
  late InAppWebViewController webViewController;
  bool isLoading = true; // Отслеживание состояния загрузки

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Stack(
        children: [
          // WebView
          InAppWebView(
            initialUrlRequest: URLRequest(
              url: WebUri("https://sugar-big-bang.online/sbb-ios/"),
            ),
            onWebViewCreated: (controller) {
              webViewController = controller;
            },
            onLoadStart: (controller, url) {
              setState(() {
                isLoading = true; // Показываем загрузчик
              });
            },
            onLoadStop: (controller, url) async {
              setState(() {
                isLoading = false; // Скрываем загрузчик
              });
            },
          ),

          // Индикатор загрузки
          if (isLoading)
            Center(
              child: ModalProgressIndicator(
                visible: true,
                indicator: CircularProgressIndicator(),
                options: BackgroundOptions(
                  color: Colors.black,
                  opacity: 0.5,
                  blurEffect: BlurEffect(
                    sigmaX: 1.5,
                    sigmaY: 1.5,
                  ),
                ),
                child: CircularProgressIndicator(),
              ),
            )
        ],
      ),
    );
  }
}