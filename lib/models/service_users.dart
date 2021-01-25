import 'package:flutter/cupertino.dart';

class ServiceUsers extends ChangeNotifier{

  final String id;
  final String firstName;
  final String lastName;
  final String urlToImage;
  final String email;

  ServiceUsers({this.id, this.firstName, this.lastName, this.urlToImage, this.email});

  factory ServiceUsers.fromJson(Map<String, dynamic> json) {
    return ServiceUsers(
      id: json['id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      urlToImage: json['picture'],
      email: json['email'],
    );
  }
}