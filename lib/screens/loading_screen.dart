import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:user_log/service/networking.dart';

import '../models/service_users.dart';
import 'display_users_screen.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    getUserData();
  }

  void cacheData() {
    final String listOfUsers = "CachedListOfUsers.json";
  }

  void getUserData() async {
    NetworkHelper networkHelper = NetworkHelper(url: '/user');

    var responseBody = await networkHelper.getUsers();
    Iterable listOfUsers = responseBody['data'];

    List<ServiceUsers> serviceUsers =
        listOfUsers.map((model) => ServiceUsers.fromJson(model)).toList();

    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
      return DisplayUsersScreen(allUsers: serviceUsers);
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SpinKitDoubleBounce(
          color: Colors.white,
          size: 100,
        ),
      ),
    );
  }
}
