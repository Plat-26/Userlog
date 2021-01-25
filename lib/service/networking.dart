import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

const String baseURL = 'https://dummyapi.io/data/api';
const String appID = '600b0bd83d25dc3489466ee1';

class NetworkHelper {
  var client = http.Client();
  final String url;

  NetworkHelper({@required this.url});

  Future getUsers() async {
    http.Response response =
        await client.get('$baseURL$url', headers: {'app-id': appID});

    if (response.statusCode == 200) {
      client.close();
      return jsonDecode(response.body);

    } else {
      throw Exception('Failed to load data ${response.statusCode}');
    }
  }
}

