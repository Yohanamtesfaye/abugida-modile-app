import 'package:flutter/material.dart';
import 'auth.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        children: [
          ListTile(
            title: const Text('Change Theme'),
            onTap: () {
              // Implement theme change logic
            },
          ),
          ListTile(
            title: const Text('Logout'),
            onTap: () {
              authProvider.logout();
              Navigator.pop(context); // Go back to the previous screen
            },
          ),
        ],
      ),
    );
  }
}
