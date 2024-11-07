import 'dart:convert';
// Fonction pour créer un utilisateur à partir de JSON
User usersFromJson(String str) => User.fromJson(json.decode(str));
// Fonction pour convertir un utilisateur en JSON
String usersToJson(User data) => json.encode(data.toJson());

class User {
  final int? userId;
  final String email;
  final String password;


  User({
    this.userId,
    required this.email,
    required this.password,
  });
  // Fabrique pour créer un utilisateur à partir d'un Map JSON
  factory User.fromJson(Map<String, dynamic> json) => User(
    userId: json["userId"],
    email: json["email"],
    password: json["password"],

  );
  // Méthode pour convertir l'utilisateur en Map JSON
  Map<String, dynamic> toJson() => {
    "userId": userId,
    "email": email,
    "password": password,

  };
}
