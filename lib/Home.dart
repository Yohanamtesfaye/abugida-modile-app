import 'package:abugida/Jobs.dart';
import 'package:abugida/Profile.dart';
import 'package:abugida/model/session_model.dart';
import 'package:abugida/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'job_provider.dart';
import 'session_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const HomeContent(),
    const Jobs(),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Abugida Tutors'),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              // Navigate to notifications page
            },
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.pushNamed(context, '/settings');
            },
          ),
        ],
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        selectedItemColor: Colors.blueAccent,
        unselectedItemColor: Colors.grey,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.work),
            label: 'Jobs',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    final jobProvider = Provider.of<JobProvider>(context);
    final sessionProvider = Provider.of<SessionProvider>(context);

    final jobs = jobProvider.jobs;
    final sessions = sessionProvider.sessions;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Users Profile Section
          _buildUsersProfile(context),
          const SizedBox(height: 20),

          // Quick Stats
          const Text(
            'Quick Stats',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildStatCard('${jobs.length}', 'Total Jobs'),
              _buildStatCard(
                  '${jobs.where((job) => job.status == "Ongoing").length}',
                  'Ongoing Jobs'),
              _buildStatCard(
                  '${jobs.where((job) => job.status == "Completed").length}',
                  'Completed Jobs'),
            ],
          ),
          const SizedBox(height: 20),

          // Upcoming Sessions
          const Text(
            'Upcoming Sessions',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          _buildSessionList(sessions
              .where((session) => session.status == "Upcoming")
              .toList()),
          const SizedBox(height: 20),

          // Recent Activity
          const Text(
            'Recent Activity',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          _buildSessionList(sessions
              .where((session) => session.status == "Completed")
              .toList()),
        ],
      ),
    );
  }

  Widget _buildUsersProfile(BuildContext context) {
    // Get the logged-in user from the UserProvider
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final loggedInUser = userProvider.loggedInUser;

    // If no user is logged in, show a placeholder or redirect to the login page
    if (loggedInUser == null) {
      return const Center(child: Text('No user logged in'));
    }

    return Row(
      children: [
        const CircleAvatar(
          radius: 30,
          backgroundImage:
              AssetImage('assets/images/profile.png'), // Add a profile image
        ),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Welcome,',
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
            Text(
              loggedInUser.fullName, // Display the user's full name
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text(
              'Tutor since 2022', // You can replace this with dynamic data if available
              style: TextStyle(fontSize: 14, color: Colors.grey[600]),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStatCard(String value, String label) {
    return Container(
      width: 115,
      height: 110,
      decoration: BoxDecoration(
        color: Colors.blueAccent,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              value,
              style: const TextStyle(color: Colors.white, fontSize: 30),
            ),
            Text(
              label,
              style: const TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSessionList(List<Session> sessions) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: sessions.length,
      itemBuilder: (context, index) {
        final session = sessions[index];
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 5),
          child: ListTile(
            title: Text(session.title),
            subtitle: Text("Date: ${session.date}"),
            trailing: Text(
              session.status,
              style: TextStyle(
                color:
                    session.status == "Upcoming" ? Colors.orange : Colors.green,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        );
      },
    );
  }
}
