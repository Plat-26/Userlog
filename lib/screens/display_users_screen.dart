import 'package:cache_image/cache_image.dart';
import 'package:flutter/material.dart';
import 'package:user_log/constants.dart';
import 'package:user_log/models/single_user.dart';
import 'package:user_log/service/networking.dart';

import '../models/service_users.dart';
import 'single_user_screen.dart';

class DisplayUsersScreen extends StatelessWidget {
  DisplayUsersScreen({this.allUsers});

  final List<ServiceUsers> allUsers;

  GestureDetector _buildItemsForListView(BuildContext context, int index) {
    return GestureDetector(
      onTap: () async {
        String userURl = '/user/${allUsers[index].id}';
        NetworkHelper networkHelper = NetworkHelper(url: userURl);

        var userData = await networkHelper.getUsers();
        SingleUser singleUser = SingleUser.fromJson(userData);

        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return SingleUserScreen(user: singleUser);
        }));
      },
      child: Card(
        child: ListTile(
          leading: Image.network(allUsers[index].urlToImage),
          // leading: CacheImage('allUsers[index].urlToImage'),
          title:
              Text('${allUsers[index].firstName} ${allUsers[index].lastName}'),
          subtitle: Text('${allUsers[index].email}'),
          isThreeLine: true,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Users', style: kAppBarTextStyle),
      ),
      body: ListView.separated(
        itemBuilder: _buildItemsForListView,
        separatorBuilder: (BuildContext context, int index) => const Divider(),
        itemCount: allUsers.length,
      ),
    );
  }
}
