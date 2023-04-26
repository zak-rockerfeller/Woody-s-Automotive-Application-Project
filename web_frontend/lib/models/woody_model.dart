import 'package:web_frontend/models/models.dart';


class Nest{
  int? id;
  String? name;
  String? type;
  String? category;
  User? user;

  Nest({
    this.id,
    this.name,
    this.type,
    this.category,
    this.user,

  });

  //map json to nest model
  factory Nest.fromJson(Map<String, dynamic> json){
    return Nest(
      id: json['id'],
      name: json['name'],
      type: json['type'],
      category: json['category'],
      user: User(
        id: json['user']['id'],
        name: json['user']['name'],
        email: json['user']['email'],


      ),
    );
  }




}

