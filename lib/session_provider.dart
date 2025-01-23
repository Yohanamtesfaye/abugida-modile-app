import 'package:abugida/model/session_model.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class SessionProvider with ChangeNotifier {
  late Box<Session> _sessionsBox;

  SessionProvider() {
    _sessionsBox = Hive.box<Session>('sessionsBox');
  }

  List<Session> get sessions => _sessionsBox.values.toList();

  void addSession(Session session) {
    _sessionsBox.add(session);
    notifyListeners();
  }

  void updateSessionStatus(int id, String status) {
    final session =
        _sessionsBox.values.firstWhere((session) => session.id == id);
    session.status = status;
    _sessionsBox.put(session.id, session); // Update the session in the box
    notifyListeners();
  }
}
