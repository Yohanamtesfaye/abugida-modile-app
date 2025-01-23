import 'package:abugida/model/job_model.dart';
import 'package:abugida/model/session_model.dart';
import 'package:hive/hive.dart';
import 'package:flutter/material.dart';

class JobProvider with ChangeNotifier {
  late Box<Job> _jobsBox;

  JobProvider() {
    _jobsBox = Hive.box<Job>('jobsBox');
  }

  List<Job> get jobs => _jobsBox.values.toList();

  void addJob(Job job) {
    _jobsBox.add(job);
    notifyListeners();
  }

  void updateJobStatus(int id, String status) {
    final job = _jobsBox.values.firstWhere((job) => job.id == id);
    job.status = status;
    _jobsBox.put(job.id, job); // Update the job in the box
    notifyListeners();
  }

  Future<void> seedInitialData() async {
    final jobsBox = Hive.box<Job>('jobsBox');
    if (jobsBox.isEmpty) {
      await jobsBox.addAll([
        Job(id: 1, title: "Math Tutor", status: "Ongoing"),
        Job(id: 2, title: "Science Tutor", status: "Not Started"),
        Job(id: 3, title: "English Tutor", status: "Requests"),
        Job(id: 4, title: "History Tutor", status: "Completed"),
      ]);
    }

    final sessionsBox = Hive.box<Session>('sessionsBox');
    if (sessionsBox.isEmpty) {
      await sessionsBox.addAll([
        Session(
            id: 1,
            title: "Math Session",
            date: "2023-10-15",
            status: "Upcoming"),
        Session(
            id: 2,
            title: "Science Session",
            date: "2023-10-16",
            status: "Completed"),
        Session(
            id: 3,
            title: "English Session",
            date: "2023-10-17",
            status: "Upcoming"),
      ]);
    }
  }
}
