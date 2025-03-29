import 'dart:developer' show log;

import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService {
  final CollectionReference billsCollection = FirebaseFirestore.instance
      .collection('bills');

  // Fetch parentId (dummy implementation, can be customized)
  Future<String?> getParentId() async {
    // Example logic (can be modified based on user login/session)
    return "P25K5434"; // Hardcoded parentId for now
  }

  // Fetch bills for a given parentId
  Future<List<Map<String, dynamic>>> getParentBills(String parentId) async {
    try {
      QuerySnapshot querySnapshot =
          await billsCollection.where('parentId', isEqualTo: parentId).get();
      return querySnapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();
    } catch (e) {
      log("Error fetching bills: $e");
      return [];
    }
  }
}
