import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:developer';

class AppDrawer extends StatelessWidget {
  final int currentIndex;
  final Function(int) onItemSelected;
  final String parentId = "P25K1886"; // Hardcoded Parent ID

  const AppDrawer({
    super.key,
    required this.currentIndex,
    required this.onItemSelected,
  });

  Future<String?> getParentName(String parentId) async {
    try {
      DocumentSnapshot parentSnapshot =
          await FirebaseFirestore.instance
              .collection('parents')
              .doc(parentId)
              .get();

      if (parentSnapshot.exists) {
        return parentSnapshot['name'] as String; // Get the 'name' field
      } else {
        log("Parent not found", name: "FirestoreService");
        return null;
      }
    } catch (e) {
      log(
        "Error fetching parent data: $e",
        name: "FirestoreService",
        level: 900,
      );
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: Theme.of(context).primaryColor),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.white,
                  child: Icon(Icons.person, size: 40, color: Colors.blue),
                ),
                const SizedBox(height: 10),
                FutureBuilder<String?>(
                  future: getParentName(parentId),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Text(
                        'Loading...',
                        style: TextStyle(color: Colors.white, fontSize: 24),
                      );
                    } else if (snapshot.hasError ||
                        !snapshot.hasData ||
                        snapshot.data == null) {
                      return const Text(
                        'Unknown',
                        style: TextStyle(color: Colors.white, fontSize: 24),
                      );
                    } else {
                      return Text(
                        snapshot.data!,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Home'),
            selected: currentIndex == 0,
            onTap: () => onItemSelected(0),
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Settings'),
            selected: currentIndex == 1,
            onTap: () => onItemSelected(1),
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Logout'),
            onTap: () {
              // Implement logout functionality here
            },
          ),
        ],
      ),
    );
  }
}
