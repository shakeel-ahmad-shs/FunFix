import 'package:flutter/material.dart';
import 'package:funfix/services/auth/auth_service.dart';
import 'package:funfix/pages/setting_pages.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  // for logout method
  void logout() {
    //get auth service
    final auth = AuthService();
    auth.signout();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 250,
      backgroundColor: Theme.of(context).colorScheme.surface,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Column(
              children: [
                //logo
                DrawerHeader(
                  child: Center(
                    child: Icon(
                      Icons.message,
                      size: 40,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ),

                ListTile(title: Text(" H O M E S"), leading: Icon(Icons.home)),
                ListTile(
                  title: Text("S E T T I N G"),
                  leading: Icon(Icons.settings),

                  onTap: () {
                    Navigator.pop(context);

                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SettingPages()),
                    );
                  },
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 5, left: 20),
            child: ListTile(
              title: Text("L O G O U T"),
              leading: Icon(Icons.logout),
              onTap: logout,
            ),
          ),
        ],
      ),
    );
  }
}
