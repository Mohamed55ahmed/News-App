import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:mynewsapp/model/articles.dart';


class APIS {
  static String APIKEY = "f49a76cec755418390a8146af024b146";

  static fetchArticles() async {
    List<Articles> listArticles = [];
    var url = Uri.parse(
        "https://newsapi.org/v2/top-headlines?country=eg&apiKey=$APIKEY");
    var respons = await http.get(url);
    var responsBody = jsonDecode(respons.body)["articles"];
    for (var i in responsBody) {
      Articles x = Articles(
          description: i["description"],
          title: i["title"],
          url: i["url"],
          urlToImage: i["urlToImage"]);
      listArticles.add(x);
    }
    return listArticles;
  }
  static fetchCategoryArticles(String category) async {
    List<Articles> listArticles = [];
    var url = Uri.parse(
        "https://newsapi.org/v2/top-headlines?country=eg&category=$category&apiKey=$APIKEY");
    var respons = await http.get(url);
    var responsBody = jsonDecode(respons.body)["articles"];
    for (var i in responsBody) {
      Articles x = Articles(
          description: i["description"],
          title: i["title"],
          url: i["url"],
          urlToImage: i["urlToImage"]);
      listArticles.add(x);
    }
    return listArticles;
  }

}
