import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:weather_api_dio/model.dart';

class Service {
  Dio dio = Dio();

  Future<List<Model>?> apiyiGetir() async {
    String url = "https://picsum.photos/v2/list";
    Response response = await dio.get(url);
    if (response.statusCode == 200) {
      Iterable list = response.data;
      return list.map((e) => Model.fromJson(e)).toList();
    }
  }

  Future<List<Model>?> sayiliGetir(Object? sayi) async {
    String url = "https://picsum.photos/v2/list?limit=$sayi";
    Response response = await dio.get(url);
    if (response.statusCode == 200) {
      Iterable list = response.data;
      return list.map((e) => Model.fromJson(e)).toList();
    }
  }

  Future<Model?> detayGetir(String gelenid) async {
    String url = "https://picsum.photos/id/$gelenid/info";
    Response response = await dio.get(url);
    if (response.statusCode == 200) {
      return Model.fromJson(response.data);
    }
  }
}
