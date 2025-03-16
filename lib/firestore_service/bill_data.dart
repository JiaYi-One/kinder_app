import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:developer';

class FirebaseService {
  //final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String?> getParentId() async {
    String user = "P25K5904"; // Hardcoded for now

    // Instead of querying Firestore, return the hardcoded ID
    return user;
  }

  Future<List<Map<String, dynamic>>> getParentBills(String parentId) async {
    try {
      // Get studentIds associated with the parent
      QuerySnapshot studentSnapshot =
          await _firestore
              .collection('students')
              .where('parentId', isEqualTo: parentId)
              .get();

      List<String> studentIds =
          studentSnapshot.docs
              .map((doc) => doc['studentId'].toString())
              .toList();

      if (studentIds.isEmpty) return [];

      // Get bills where studentIds array contains any of the studentIds
      QuerySnapshot billSnapshot =
          await _firestore
              .collection('bills')
              .where('studentIds', arrayContainsAny: studentIds)
              .get();

      return billSnapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();
    } catch (e) {
      log("Error fetching bills: $e");
      return [];
    }
  }
}
