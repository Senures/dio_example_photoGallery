import 'dart:io';

import 'package:flutter/material.dart';
import 'package:weather_api_dio/model.dart';
import 'package:weather_api_dio/service.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Detay extends StatefulWidget {
  final String id;
  Detay({Key? key, required this.id}) : super(key: key);

  @override
  _DetayState createState() => _DetayState();
}

class _DetayState extends State<Detay> {
  Model? mapdetay;
  bool yukleniyorMu = false;

  @override
  void initState() {
    if (Platform.isAndroid) WebView.platform = AndroidWebView();
    setState(() {
      yukleniyorMu = true;
    });
    Service().detayGetir(widget.id).then((value) {
      setState(() {
        mapdetay = value;
        yukleniyorMu = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xff1b1b1b),
          title: const Text(
            "Detay",
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: yukleniyorMu
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : WebView(
                initialUrl: mapdetay!.url,
                javascriptMode: JavascriptMode.unrestricted,
                backgroundColor: Colors.grey,
              ));
  }
}
