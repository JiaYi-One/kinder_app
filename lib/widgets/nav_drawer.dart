import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  final int currentIndex;
  final Function(int) onItemSelected;

  const AppDrawer({
    super.key,
    required this.currentIndex,
    required this.onItemSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.white,
                  child: Icon(
                    Icons.person,
                    size: 40,
                    color: Colors.blue,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Name',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
                Text(
                  'example@email.com',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          _buildDrawerItem(
            icon: Icons.home,
            title: 'Home',
            index: 0,
            context: context,
          ),
          _buildDrawerItem(
            icon: Icons.person,
            title: 'Profile',
            index: 1,
            context: context,
          ),
          _buildDrawerItem(
            icon: Icons.settings,
            title: 'Settings',
            index: 2,
            context: context,
          ),
          const Divider(),
          _buildDrawerItem(
            icon: Icons.help,
            title: 'Help & Feedback',
            index: 3, // ✅ Assign an index for Help
            context: context,
          ),
          _buildDrawerItem(
            icon: Icons.logout,
            title: 'Logout',
            index: 4, // ✅ Assign an index for Logout
            context: context,
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerItem({
    required IconData icon,
    required String title,
    required int index,
    required BuildContext context,
    VoidCallback? onTap,
  }) {
    final isSelected = index == currentIndex;

    return ListTile(
      leading: Icon(
        icon,
        color: isSelected ? Theme.of(context).primaryColor : null,
      ),
      title: Text(
        title,
        style: TextStyle(
          color: isSelected ? Theme.of(context).primaryColor : null,
          fontWeight: isSelected ? FontWeight.bold : null,
        ),
      ),
      selected: isSelected,
      onTap: onTap ??
          () {
            // Close the drawer
            Navigator.pop(context);
            // Update selected index
            onItemSelected(index);
            
          },
    );
  }
}
