import 'dart:convert';
import 'package:http/http.dart';

import '../modelclass/Streammodel.dart';
import 'api_client..dart';


class Streamapi {
  ApiClient apiClient = ApiClient();


  Future<List<Streammodel>> getstreammodel() async {
    String trendingpath = 'https://crypto-news16.p.rapidapi.com/news/top/5';
    var body = {

    };
    Response response = await apiClient.invokeAPI(trendingpath, 'GET', body);

    return Streammodel.listFromJson(json.decode(response.body))
    ;
  }
}