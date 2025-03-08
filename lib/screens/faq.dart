import 'package:flutter/material.dart';

class FAQScreen extends StatelessWidget {
  const FAQScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('FAQ')),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Frequently Asked Questions', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            SizedBox(height: 16),
            Text('Q: How do I reset my password?', style: TextStyle(fontWeight: FontWeight.bold)),
            Text('A: Go to the settings page and select "Reset Password".'),
            SizedBox(height: 10),
            Text('Q: How do I contact support?', style: TextStyle(fontWeight: FontWeight.bold)),
            Text('A: Send an email to support@example.com.'),
          ],
        ),
      ),
    );
  }
}