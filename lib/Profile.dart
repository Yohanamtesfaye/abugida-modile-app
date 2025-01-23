import 'package:abugida/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'auth.dart';
import 'job_provider.dart';
import 'session_provider.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final jobProvider = Provider.of<JobProvider>(context);
    final sessionProvider = Provider.of<SessionProvider>(context);
    final authProvider = Provider.of<AuthProvider>(context);

    final jobs = jobProvider.jobs;
    final sessions = sessionProvider.sessions;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              // Navigate to edit profile page
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Users Profile Section
            _buildUsersProfile(context),
            const SizedBox(height: 20),

            // Statistics Section
            const Text(
              'Statistics',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildStatCard('${jobs.length}', 'Total Jobs'),
                _buildStatCard(
                    '${sessions.where((session) => session.status == "Completed").length}',
                    'Completed Sessions'),
                _buildStatCard('ETB 0.00', 'Total Earnings'),
              ],
            ),
            const SizedBox(height: 20),

            // About Me Section
            const Text(
              'About Me',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              'I am a passionate tutor with over 5 years of experience in teaching Math, Science, and English. I believe in making learning fun and engaging for my students.',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 20),

            // Skills Section
            const Text(
              'Skills',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 8.0,
              children: [
                _buildSkillChip('Math'),
                _buildSkillChip('Science'),
                _buildSkillChip('English'),
                _buildSkillChip('Programming'),
                _buildSkillChip('History'),
              ],
            ),
            const SizedBox(height: 20),

            // Reviews Section
            const Text(
              'Reviews',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            _buildReviewCard(
                'John Doe', 'Great tutor! Very patient and knowledgeable.', 5),
            _buildReviewCard(
                'Jane Smith', 'Amazing teaching style. Highly recommended!', 4),
            _buildReviewCard('Alice Johnson',
                'Helped me improve my grades significantly.', 5),
            const SizedBox(height: 20),

            // Logout Button
            Center(
              child: ElevatedButton(
                onPressed: () {
                  authProvider.logout();
                  Navigator.pop(context); // Go back to the previous screen
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                ),
                child: const Text(
                  'Logout',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 20),
            TextButton(
                onPressed: () {
                  jobProvider.seedInitialData();
                },
                child: Text(
                  'add test data',
                  style: TextStyle(color: Colors.blue),
                )),
          ],
        ),
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
      width: 100,
      height: 100,
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
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              label,
              style: const TextStyle(color: Colors.white, fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSkillChip(String skill) {
    return Chip(
      label: Text(
        skill,
        style: const TextStyle(color: Colors.white),
      ),
      backgroundColor: Colors.blueAccent,
    );
  }

  Widget _buildReviewCard(String name, String review, int rating) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 5),
      child: ListTile(
        leading: const CircleAvatar(
          backgroundImage: AssetImage('assets/images/profile.png'),
        ),
        title: Text(
          name,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(review),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.star, color: Colors.amber, size: 20),
            const SizedBox(width: 5),
            Text(
              rating.toString(),
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
