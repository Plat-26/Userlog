import 'dart:collection';
import 'dart:convert';
import '../models/service_users.dart';
import '../service/networking.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String serviceUsersURL = '/user';

class ServiceUsersController {
  static List<ServiceUsers> listOfServiceUsers;

  Future getListOfUsers() async {
    Duration timeLimit = new Duration(minutes: 3);
     await _getFromNetwork().timeout(timeLimit, onTimeout: await _getFromCache());
     _getFromNetwork(); ///TODO: allow program to get from netwrk in the background and listenrs reload th service
  }

  Future _getFromNetwork() async {
    NetworkHelper networkHelper = NetworkHelper(url: serviceUsersURL);

    var serviceUsersData = await networkHelper.getUsers();

    final prefs  = await SharedPreferences.getInstance();
    bool isCached = await prefs.setString("cachedServiceUsers", jsonEncode(serviceUsersData));

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
    } else {
      await _getFromNetwork();
    }
  }

  void _populateMap(LinkedHashMap<String, dynamic> serviceUsers) {
    Iterable listOfUsers = serviceUsers['data'];
    listOfServiceUsers =
    listOfUsers.map((model) => ServiceUsers.fromJson(model)).toList();
  }
}


