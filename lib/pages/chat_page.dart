import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:funfix/call%20feature/methods/appbar_call_button.dart';
import 'package:funfix/components/chat_bubble.dart';
import 'package:funfix/components/my_textfield.dart';
import 'package:funfix/services/auth/auth_service.dart';
import 'package:funfix/services/chat/chat_services.dart';

class ChatPage extends StatefulWidget {
  final String reciveremail;
  final String receiverID;

  const ChatPage({
    super.key,
    required this.reciveremail,
    required this.receiverID,
  });

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  // txt fld auto fucs +  show chat

  FocusNode myFoucsNode = FocusNode();

  // txt contrl for message input
  final TextEditingController _messageController = TextEditingController();

  //  import services chat services and auth
  final ChatServices _chatServices = ChatServices();

  final AuthService _authService = AuthService();
  @override
  void initState() {
    super.initState();

    //listener to focus node

    myFoucsNode.addListener(() {
      if (myFoucsNode.hasFocus) {
        // cause a delay so that kybd has time to show Up
        //then a ammount of remaining space  will be calculated ,
        //then scroll down

        Future.delayed(Duration(milliseconds: 500), () => scrollDown());
      }
    });
    Future.delayed(Duration(milliseconds: 500), () => scrollDown());
  }

  @override
  void dispose() {
    myFoucsNode.dispose();
    _messageController.dispose();
    super.dispose();
  }

  // scroll controller
  final ScrollController _scrollController = ScrollController();
  void scrollDown() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: Duration(seconds: 1),
      curve: Curves.fastOutSlowIn,

      /// go to the list to add controller for scroll auto   (bholna nahi)
    );
  }

  //send a  message
  void sendMessage() async {
    // if there is some thing in side the txt fld
    if (_messageController.text.isNotEmpty) {
      // send a message
      await _chatServices.sendMessage(
        widget.receiverID,
        _messageController.text,
      ); //  clear a controller after send  for new
      _messageController.clear();
    }
    scrollDown();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWithCall(
        receiverEmail: widget.reciveremail,
        receiverID: widget.receiverID,
      ),
      // AppBar(title: Text(widget.reciveremail)),
      body: Column(
        children: [
          // display all messages
          Expanded(child: _buildMessageList()),

          // user input
          _buildUserInput(),
        ],
      ),
    );
  }

  // build a  message list
  Widget _buildMessageList() {
    String senderID = _authService.getCurrentUser()!.uid;
    return StreamBuilder(
      stream: _chatServices.getMessages(senderID, widget.receiverID),
      builder: (context, snapshot) {
        // check errors
        if (snapshot.hasError) {
          return Text("  Network error try  later again ");
        } // loading
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } // return atfer all okay   list view
        return ListView(
          controller:
              _scrollController, // aslo add fousnode in textfld   for that go fst in mytxtfld pge

          children: snapshot.data!.docs
              .map((doc) => _buildMessageItem(doc))
              .toList(),
        );
      },
    );
  }

  // build a message  item list
  Widget _buildMessageItem(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    // this is for doing align the sender and receiver sms

    // is  current user
    bool isCurrentUser = data['senderID'] == _authService.getCurrentUser()!.uid;

    var alignment = isCurrentUser
        ? Alignment.centerRight
        : Alignment.centerLeft;
    return Container(
      width: double.infinity,
      alignment: alignment,
      child: Column(
        crossAxisAlignment: isCurrentUser
            ? CrossAxisAlignment.end
            : CrossAxisAlignment.start,
        children: [
          ChatBubble(isCurrentUser: isCurrentUser, message: data["message"]),
        ],
      ),
    );
  }

  // create a sms input
  Widget _buildUserInput() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(12),
        ),

        padding: EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // txt fld  should take up a space
            Expanded(
              child: MyTextfield(
                focusNode: myFoucsNode,
                obscureText: false,
                hintText: "type a Message",
                controller: _messageController,
              ),
            ),

            // button to send a message
            Container(
              decoration: BoxDecoration(
                color: Colors.green,
                shape: BoxShape.circle,
              ),
              margin: EdgeInsets.only(right: 25),
              child: IconButton(
                onPressed: sendMessage,
                icon: Icon(Icons.arrow_forward_ios, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
