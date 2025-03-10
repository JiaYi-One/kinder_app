import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:developer'; // Use logging instead of print

Future<Map<String, dynamic>?> getStudentData(String studentId) async {
  try {
    DocumentSnapshot studentSnapshot =
        await FirebaseFirestore.instance.collection('students').doc(studentId).get();

    if (studentSnapshot.exists) {
      return studentSnapshot.data() as Map<String, dynamic>;
    } else {
      log("Student not found", name: "FirestoreService");
      return null;
    }
  } catch (e) {
    log("Error fetching student data: $e", name: "FirestoreService", level: 900);
    return null;
  }
}
