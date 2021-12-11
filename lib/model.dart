// To parse this JSON data, do
//
//     final model = modelFromJson(jsonString);

import 'dart:convert';

List<Model> modelFromJson(String str) => List<Model>.from(json.decode(str).map((x) => Model.fromJson(x)));

String modelToJson(List<Model> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Model {
    Model({
        required this.id,
        required this.author,
        required this.width,
        required this.height,
        required this.url,
        required this.downloadUrl,
    });

    String id;
    String author;
    int width;
    int height;
    String url;
    String downloadUrl;

    factory Model.fromJson(Map<String, dynamic> json) => Model(
        id: json["id"],
        author: json["author"],
        width: json["width"],
        height: json["height"],
        url: json["url"],
        downloadUrl: json["download_url"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "author": author,
        "width": width,
        "height": height,
        "url": url,
        "download_url": downloadUrl,
    };
}
