import 'package:flutter/material.dart';
import 'package:funfix/components/user_tile.dart';
import 'package:funfix/pages/chat_page.dart';
import 'package:funfix/services/auth/auth_service.dart';
import 'package:funfix/components/my_drawer.dart';
import 'package:funfix/services/chat/chat_services.dart';

class Homepage extends StatelessWidget {
  Homepage({super.key});
  // get instace of chat services and athu services

  final ChatServices _chatServices = ChatServices();
  final AuthService _authService = AuthService();
  void logout() {
    //get auth service
    final auth = AuthService();
    auth.signout();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("home page "),

        actions: [IconButton(onPressed: logout, icon: Icon(Icons.logout))],
      ),
      drawer: MyDrawer(),

      body: _buildUserList(),
    );
  }

  Widget _buildUserList() {
    return StreamBuilder(
      stream: _chatServices.getUserStream(),
      builder: (context, snapshot) {
        // eror
        if (snapshot.hasError) {
          return Text("connection  error");
        }

        //loading
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator(strokeWidth: 2));
        }
        // final retrun data in tile
        return ListView(
          children: snapshot.data!
              .map<Widget>((userdata) => _buildUserListItem(userdata, context))
              .toList(),
        );
      },
    );
  }

  // build a widget list tile for user

  Widget _buildUserListItem(
    Map<String, dynamic> userdata,
    BuildContext context,
  ) {
    // display  all user except current user

    if (userdata["email"] == _authService.getCurrentUser()!.email) {
      return Container(); // skip current user
    }
    final currentUserID = _authService.getCurrentUser()!.uid;

    return StreamBuilder(
      stream: _chatServices.getLastMessage(currentUserID, userdata["uid"]),

      builder: (context, asyncSnapshot) {
        String? lastMsg;

        if (asyncSnapshot.hasData && asyncSnapshot.data!.docs.isNotEmpty) {
          lastMsg = asyncSnapshot.data!.docs.first['message'];
        }
        return UserTile(
          subtitle: lastMsg ?? "no message here",
          onTap: () {
            // tapp & navigate to chatpage
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ChatPage(
                  reciveremail: userdata["email"],
                  receiverID: userdata["uid"],
                ),
              ),
            );
          },
          text: userdata["email"],
        );
      },
    );
  }
}
