import 'package:flutter/material.dart';
class RequestsPage extends StatelessWidget {
  const RequestsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Abugida Tutors'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('On going', style: TextStyle( fontWeight:FontWeight.bold, fontSize: 25 ),),
        ],
      ),
    );
  }
}