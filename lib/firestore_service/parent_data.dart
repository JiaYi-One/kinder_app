import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:developer'; // Use logging instead of print

Future<Map<String, dynamic>?> getParentData(String parentId) async {
  try {
    DocumentSnapshot parentSnapshot =
        await FirebaseFirestore.instance.collection('parents').doc(parentId).get();

    if (parentSnapshot.exists) {
      return parentSnapshot.data() as Map<String, dynamic>;
    } else {
      log("Parent not found", name: "FirestoreService");
      return null;
    }
  } catch (e) {
    log("Error fetching parent data: $e", name: "FirestoreService", level: 900);
    return null;
  }
}
