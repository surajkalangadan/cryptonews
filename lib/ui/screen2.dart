import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
class screen2 extends StatefulWidget {
  final String url;
  const screen2({super.key,required this.url});

  @override
  State<screen2> createState() => _screen2State();
}

class _screen2State extends State<screen2> {
    WebViewController _controller=WebViewController();

  @override
  Widget build(BuildContext context) {
      _controller = WebViewController()
        ..setJavaScriptMode(JavaScriptMode.unrestricted)
        ..setBackgroundColor(const Color(0x00000000))
        ..setNavigationDelegate(
          NavigationDelegate(
            onProgress: (int progress) {
              // Update loading bar.
            },
            onPageStarted: (String url) {},
            onPageFinished: (String url) {},
            onWebResourceError: (WebResourceError error) {},
            onNavigationRequest: (NavigationRequest request) {
              if (request.url.startsWith('https://www.youtube.com/')) {
                return NavigationDecision.prevent;
              }
              return NavigationDecision.navigate;
            },
          ),
        )
        ..loadRequest(Uri.parse(widget.url));
    return Scaffold(body: WebViewWidget(controller: _controller),);
  }
}
