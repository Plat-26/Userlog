import 'package:cache_image/cache_image.dart';
import 'package:flutter/material.dart';
import 'package:user_log/constants.dart';
import 'package:user_log/controllers/single_user_controller.dart';
import '../models/service_users.dart';
import 'single_user_screen.dart';

class DisplayUsersScreen extends StatelessWidget {
  DisplayUsersScreen({this.allUsers});

  final List<ServiceUsers> allUsers;

  GestureDetector _buildItemsForListView(BuildContext context, int index) {
    return GestureDetector(
      onTap: () async {
        String userURl = '/user/${allUsers[index].id}';

        SingleUserController controller = SingleUserController(
            userID: '${allUsers[index].id}', userURL: userURl);

        await controller.getUserData();

        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return SingleUserScreen(user: controller.singleUser);
        }));
      },
      child: Card(
        child: ListTile(
          leading: Image.network(allUsers[index].urlToImage),
          // leading: CacheImage( 'allUsers[index].urlToImage'),
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
