import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:sample_api/models/newsinfo.dart';

class API_Manager{

  Future<NewsModel> getNews() async{

    var response = await http.get(Uri.parse("https://newsapi.org/v2/everything?domains=wsj.com&apiKey=6eabe6c2e0ed4d1c83d9f9c077ec7eb6"));

    var newsModel = null;
try {
  if (response.statusCode == 200) {
    var jsonString = response.body;
    var jsonMap = jsonDecode(jsonString);
    newsModel = NewsModel.fromJson(jsonMap);
    print(jsonString);
    print("Success");
  }
  else {
    print("Request failed");
  }
}catch(Exception){
  print("Exception");
}
    return newsModel;
  }
}