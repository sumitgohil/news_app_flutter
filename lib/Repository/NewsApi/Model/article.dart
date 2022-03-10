import 'dart:convert';

import 'package:news_app/Repository/NewsApi/Model/source.dart';

String articlesToJson(List<Article> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

List<Article> articlesFromJson(String str) =>
    List<Article>.from(json.decode(str).map((x) => Article.fromJson(x)));

class Article {
  final Source source;
  final String? author, title, description, url, urlToImage, content;
  final DateTime? publishedAt;

  Article(
    this.source,
    this.author,
    this.title,
    this.description,
    this.url,
    this.urlToImage,
    this.publishedAt,
    this.content,
  );

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      Source.fromJson(json["source"]),
      json["author"],
      json["title"],
      json["description"],
      json["url"],
      json["urlToImage"],
      DateTime.parse(json["publishedAt"]),
      json["content"],
    );
  }

  Map<String, dynamic> toJson() => {
        "source": source.toJson(),
        "author": author ?? null,
        "title": title,
        "description": description,
        "url": url,
        "urlToImage": urlToImage,
        "publishedAt": publishedAt!.toIso8601String(),
        "content": content,
      };

  static List<Article> parseList(List<dynamic> list) {
    return list.map((e) => Article.fromJson(e)).toList();
  }
}
