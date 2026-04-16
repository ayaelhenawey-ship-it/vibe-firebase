class UserModel {
  final dynamic id;
  final String firstName;
  final String lastName;
  final String username;
  final String email;
  final String image;
  final String token;

  UserModel({
    required this.id,
    this.firstName = '',
    this.lastName = '',
    required this.username,
    required this.email,
    this.image = '',
    this.token = '',
  });

  String get fullName => firstName.isNotEmpty || lastName.isNotEmpty 
      ? '$firstName $lastName'.trim() 
      : username;

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id:        json['id']        ?? 0,
      firstName: json['firstName'] ?? '',
      lastName:  json['lastName']  ?? '',
      username:  json['username']  ?? '',
      email:     json['email']     ?? '',
      image:     json['image']     ?? '',
      token:     json['accessToken'] ?? json['token'] ?? '',
    );
  }
}
