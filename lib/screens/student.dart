import 'package:flutter/material.dart';
import '../firestore_service/student_data.dart';

class StudentScreen extends StatelessWidget {
  const StudentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    String studentId = "Yuanseng"; // Hardcoded Student ID

    return Scaffold(
      appBar: AppBar(title: const Text("Student Details")),
      body: FutureBuilder<Map<String, dynamic>?>(
        future: getStudentData(studentId), // Fetch data based on hardcoded ID
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data == null) {
            return const Center(child: Text("Student not found"));
          } else {
            var studentData = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Name: ${studentData['name']}",
                    style: const TextStyle(fontSize: 18),
                  ),
                  Text(
                    "Age: ${studentData['age']}",
                    style: const TextStyle(fontSize: 18),
                  ),
                  Text(
                    "Birth Date: ${studentData['birthDate']}",
                    style: const TextStyle(fontSize: 18),
                  ),
                  Text(
                    "Parent Email: ${studentData['parentEmail']}",
                    style: const TextStyle(fontSize: 18),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
