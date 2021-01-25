import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:user_log/constants.dart';
import 'package:user_log/models/single_user.dart';


class SingleUserScreen extends StatelessWidget {
  SingleUserScreen({this.user});

  final SingleUser user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'User Log',
          style: kAppBarTextStyle,
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.all(15.0),
                alignment: Alignment.bottomLeft,
                child: Text(
                  '${user.firstName} ${user.lastName}',
                  style: kUserNameDisplayTextStyle,
                ),
              ),
            ),
            Expanded(
              child: Container(
                child: Image.network(user.urlToImage),
              ),
            ),
            Expanded(
              child: Card(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                  UserInfo(
                    informationLabel: 'Title',
                    informationData: (user.title).toUpperCase(),
                  ),
                  UserInfo(
                    informationLabel: 'DOB',
                    informationData: user.dateOfBirth,
                  ),
                  UserInfo(
                    informationLabel: 'Phone',
                    informationData: user.phoneNumber,
                  ),
                  UserInfo(
                    informationLabel: 'Date Registered',
                    informationData: user.dateRegistered,
                  ),
                  UserInfo(
                    informationLabel: 'email',
                    informationData: user.email,
                  ),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class UserInfo extends StatelessWidget {
  UserInfo({@required this.informationLabel, @required this.informationData});

  final String informationLabel;
  final String informationData;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          '$informationLabel:',
          textAlign: TextAlign.center,
          style: kUserInformationTextStyle,
        ),
        SizedBox(
          width: 5.0,
        ),
        Text(
          informationData,
          style: kUserInformationTextStyle,
        ),
      ],
    );
  }
}
