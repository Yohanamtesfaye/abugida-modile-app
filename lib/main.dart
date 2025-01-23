import 'package:abugida/model/job_model.dart';
import 'package:abugida/model/session_model.dart';
import 'package:abugida/model/user_model.dart';
import 'package:abugida/provider/user_provider.dart';
import 'package:abugida/screen/sign_in_page.dart';
import 'package:abugida/screen/sign_up_page.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'auth.dart';
import 'job_provider.dart';
import 'session_provider.dart';
import 'Home.dart';
import 'Jobs.dart';
import 'Profile.dart';
import 'settings.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.deleteBoxFromDisk('usersBox');
  // Register adapters
  Hive.registerAdapter(JobAdapter());
  Hive.registerAdapter(SessionAdapter());
  Hive.registerAdapter(UserAdapter());

  // Open Hive boxes
  await Hive.openBox<Job>('jobsBox');
  await Hive.openBox<Session>('sessionsBox');
  await Hive.openBox<User>('usersBox');
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => JobProvider()),
        ChangeNotifierProvider(create: (_) => SessionProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
      ],
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.grey[100],
        appBarTheme: const AppBarTheme(
          elevation: 0,
          centerTitle: true,
        ),
      ),
      home: SignInPage(),
      routes: {
        '/signin': (context) => SignInPage(),
        '/signup': (context) => SignUpPage(),
        '/home': (context) => const HomePage(),
        '/jobs': (context) => const Jobs(),
        '/profile': (context) => const ProfilePage(),
        '/settings': (context) => const SettingsPage(),
      },
    );
  }
}
