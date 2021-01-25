class SingleUser {
  // String url = 'user/$serviceUser.id'

  final String id;
  final String title;
  final String firstName;
  final String lastName;
  final String urlToImage;
  final String email;
  final String dateOfBirth;
  final String dateRegistered;
  final String phoneNumber;

  SingleUser(
      {this.id,
      this.firstName,
      this.lastName,
      this.urlToImage,
      this.email,
      this.dateOfBirth,
      this.dateRegistered,
      this.phoneNumber,
      this.title});

  SingleUser.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        firstName = json['firstName'],
        lastName = json['lastName'],
        dateOfBirth = json['dateOfBirth'],
        dateRegistered = json['registerDate'],
        phoneNumber = json['phone'],
        urlToImage = json['picture'],
        email = json['email'];

}
