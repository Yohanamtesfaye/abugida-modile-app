import 'package:hive/hive.dart';

part 'job_model.g.dart'; // This will be generated

@HiveType(typeId: 0) // Unique typeId for each model
class Job {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  String status;

  Job({required this.id, required this.title, required this.status});
}
