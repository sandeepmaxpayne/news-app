import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'package:news_app/News.dart';

Future<List<News>> comingNews() async {
  var url = 'https://www.mocky.io/v2/5ecfddf13200006600e3d6d0';
  http.Response response = await http.get(url);
  List<News> news = [];
  if (response.statusCode == 200) {
    var decodeJson = convert.jsonDecode(response.body);
    print('success');
    for (var n in decodeJson) {
      news.add(News.fromJson(n));
    }
  } else {
    print("error:${response.statusCode}");
  }
  return news;
}
