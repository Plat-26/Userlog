import 'dart:collection';
import 'dart:convert';

import '../models/service_users.dart';
import '../service/networking.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String serviceUsersURL = '/user';

class ServiceUsersController {
  static List<ServiceUsers> listOfServiceUsers;


  Future getListOfUsers() async {
     _getFromNetwork();
      await _getFromCache();

    ///TODO: CHECK if phone is connected to the internet. 1. Try to get from network, if there's a prolonged delay, 2, check if cache contains data if yes getFromCache directly then continue to await getFromNetwork

    //tHe view page should listen for changes in this list while it has its own initial value.
  }

  Future _getFromNetwork() async {
    NetworkHelper networkHelper = NetworkHelper(url: serviceUsersURL);

    var serviceUsersData = await networkHelper.getUsers();

    final prefs  = await SharedPreferences.getInstance();
    bool isCached = await prefs.setString("cachedServiceUsers", jsonEncode(serviceUsersData));
    //or
    if (isCached) {
      _populateMap(serviceUsersData);
    }

  }

  Future _getFromCache() async {
    final preferences = await SharedPreferences.getInstance();
    var userData = preferences.getString("cachedServiceUsers");
    if (userData != null) {
      var serviceUsers = jsonDecode(userData) as LinkedHashMap<String, dynamic>;
      _populateMap(serviceUsers);
    }
  }

  void _populateMap(LinkedHashMap<String, dynamic> serviceUsers) {
    Iterable listOfUsers = serviceUsers['data'];
    listOfServiceUsers =
    listOfUsers.map((model) => ServiceUsers.fromJson(model)).toList();
  }
}


