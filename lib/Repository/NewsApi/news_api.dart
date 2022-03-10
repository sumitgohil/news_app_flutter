import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

import 'Model/article.dart';
import 'Model/error.dart';

const String BASE_URL = "https://newsapi.org/v2/";

class NewsAPI {
  final String apiKey;
  int? totalResult;
  NewsAPI(this.apiKey);

  Future<dynamic> _call(String url, String key) async {
    url = "$url&apiKey=$apiKey";
    log("NEWS API URL " + url);
    try {
      var response = await http.get(Uri.parse(url));
      Map<String, dynamic> responseJson = json.decode(response.body);
      if (responseJson["status"].toString().toLowerCase() == "ok") {
        if (totalResult != null) {
          totalResult = responseJson["totalResults"] as int;
        }
        return responseJson[key];
      }
      return Future.error(
        NewsApiError(
          responseJson["code"],
          responseJson["message"],
        ),
      );
    } catch (e) {
      return Future.error(NewsApiError("unknown", e.toString()));
    }
  }

  Future<List<Article>> getTopHeadlines({
    String? country,
    String? category,
    String? sources,
    String? query,
    int? pageSize,
    int? page,
  }) async {
    String url = "${BASE_URL}top-headlines?true=true";
    if (country != null) url = "$url&country=$country";
    if (category != null) url = "$url&category=$category";
    if (sources != null) url = "$url&sources=$sources";
    if (query != null) url = "$url&q=$query";
    if (pageSize != null) url = "$url&pageSize=$pageSize";
    if (page != null) url = "$url&page=$page";
    return Article.parseList(await (_call(
      url,
      "articles",
    )));
  }
}
