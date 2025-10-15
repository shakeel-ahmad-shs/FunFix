import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:funfix/model/message.dart';

class ChatServices {
  // get instance of firestore & auth
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  //  get user stream
  Stream<List<Map<String, dynamic>>> getUserStream() {
    return _firestore.collection("funfix users").snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        // for each individual user
        final user = doc.data();
        return user;
      }).toList();
    });
  }
  // send a message

  Future<void> sendMessage(String receiverID, message) async {
    final String currentUserID = _auth.currentUser!.uid;
    final String currentUserEmail = _auth.currentUser!.email!;

    final Timestamp timestamp = Timestamp.now();

    // create a new   message ( for clean code create a model folder and  message.dart)

    Message newmessage = Message(
      senderID: _auth.currentUser!.uid,
      senderEmail: currentUserEmail,
      receiverID: receiverID,
      message: message,
      timestamp: timestamp,
    );
    // Constract a chat room for two user to sorted  to ensure user
    List<String> ids = [currentUserID, receiverID];
    ids.sort();
    // sort the id (this is ensure the chatroomID is the same for any two user people)
    String chatroomID = ids.join('_');
    // now add a new message
    await _firestore
        .collection("chatroom")
        .doc(chatroomID)
        .collection("messages")
        .add(newmessage.tomap());
  }

  //  get or revice the message

  Stream<QuerySnapshot> getMessages(String userID, otherUserID) {
    // constract a chatroom id for the  two user
    List<String> ids = [userID, otherUserID];
    ids.sort();
    String chatRoomID = ids.join('_');
    return _firestore
        .collection("chatroom")
        .doc(chatRoomID)
        .collection("messages")
        .orderBy("timestamp", descending: false)
        .snapshots();
  }

  /// this method is only use to stream a last chat sms in subtile of the home page in tile
  ///
  ///
  ///
  Stream<QuerySnapshot> getLastMessage(String userID, String otherUserID) {
    // make chatroom id same as in getMessages
    List<String> ids = [userID, otherUserID];
    ids.sort();
    String chatRoomID = ids.join('_');

    // return only 1 latest message
    return _firestore
        .collection("chatroom")
        .doc(chatRoomID)
        .collection("messages")
        .orderBy("timestamp", descending: true)
        .limit(1)
        .snapshots();
  }
}
/// this method is only use to stream a last chat sms in subtile of the home page in tile