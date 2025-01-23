import 'package:hive/hive.dart';

part 'user_model.g.dart'; // Generated file

@HiveType(typeId: 2)
class User {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String fullName;

  @HiveField(2)
  final String email;

  @HiveField(3)
  final String password;

  User({
    required this.id,
    required this.fullName,
    required this.email,
    required this.password,
  });
}
