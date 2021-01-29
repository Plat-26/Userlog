import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:user_log/controllers/service-users_controller.dart';
import 'display_users_screen.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    getUsers();
  }

  void getUsers()  async {
    await ServiceUsersController().getListOfUsers();
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
      return DisplayUsersScreen(allUsers: ServiceUsersController.listOfServiceUsers);
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
