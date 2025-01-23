import 'package:hive/hive.dart';
part 'session_model.g.dart';

@HiveType(typeId: 1)
class Session {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String date;

  @HiveField(3)
  String status;

  Session(
      {required this.id,
      required this.title,
      required this.date,
      required this.status});
}
