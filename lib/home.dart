import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:weather_api_dio/detay.dart';
import 'package:weather_api_dio/model.dart';
import 'package:weather_api_dio/service.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Model> listem = [];
  bool yukleniyorMu = false;

  @override
  void initState() {
    setState(() {
      yukleniyorMu = true;
    });
    Service().apiyiGetir().then((value) {
      setState(() {
        listem = value!;
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
          title: Text("Photo Gallery ( ${listem.length.toString()})"),
          centerTitle: true,
          actions: [
            PopupMenuButton(
                color: Colors.green,
                onSelected: (value) {
                  Service().sayiliGetir(value).then((value) {
                    setState(() {
                      listem = value!;
                    });
                  });
                },
                itemBuilder: (context) => [
                      const PopupMenuItem(value: 10, child: Text("10")),
                      const PopupMenuItem(value: 50, child: Text("50")),
                      const PopupMenuItem(value: 100, child: Text("100"))
                    ])
          ],
        ),
        body: yukleniyorMu
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                itemCount: listem.length,
                itemBuilder: (context, index) {
                  var item = listem[index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Detay(
                                      id: item.id,
                                    )));
                      },
                      child: Container(
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        width: double.infinity,
                        height: 250.0,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [BoxShadow(blurRadius: 10.0)],
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: Stack(
                          children: [
                            Positioned.fill(
                                child: CachedNetworkImage(
                              placeholder: (context, url) => const Center(
                                  child: CircularProgressIndicator(
                                color: Colors.black,
                              )),
                              imageUrl: item.downloadUrl,
                              fit: BoxFit.cover,
                            )),
                            Align(
                              alignment: Alignment.topRight,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  alignment: Alignment.center,
                                  width: 200.0,
                                  height: 30.0,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.0),
                                    color: Colors.green,
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Icon(
                                        Icons.camera_alt,
                                        color: Colors.white,
                                      ),
                                      Text(
                                        item.author,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                }));
  }
}
