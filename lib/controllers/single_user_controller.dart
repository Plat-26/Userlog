import 'dart:async';
import 'dart:collection';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:user_log/models/single_user.dart';
import 'package:user_log/service/networking.dart';

class SingleUserController {
  String userID;
  String userURL;
  SingleUser singleUser;
  SingleUserController({@required this.userID, @required this.userURL});

  Future getUserData() async {
    Duration timeLimit = new Duration(seconds: 1);
    try {
      await _getFromNetwork().timeout(timeLimit, onTimeout: await _getFromCache());

    } on TimeoutException catch (e) {
      print("TimeOut: ${e.message}");

    } on Error catch(e) {
      print("ERROR: ${e.stackTrace}");
    }
    _getFromNetwork(); ///TODO: ALLow listners update data;
  }

  Future _getFromNetwork() async {
    NetworkHelper networkHelper = NetworkHelper(url: userURL);

    var userData = await networkHelper.getUsers();

    final prefs = await SharedPreferences.getInstance();
    bool isCached = await prefs.setString(userID, jsonEncode(userData));

    if (isCached) {
      this.singleUser = SingleUser.fromJson(userData);
    }
  }

  Future _getFromCache() async {
    final prefs = await SharedPreferences.getInstance();
    var userData = prefs.getString(userID);

    if (userData != null) {
      var user = jsonDecode(userData) as LinkedHashMap<String, dynamic>;
      this.singleUser = SingleUser.fromJson(user);

    } else {
      await _getFromNetwork();
    }
  }
}
