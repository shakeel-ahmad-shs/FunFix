import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  //instance of auth
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  // get current user
  User? getCurrentUser() {
    return _auth.currentUser;
  }

  // sign in
  Future<UserCredential> signInWithEmailPassword(String email, password) async {
    try {
      // sign uer in
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      ); // save user info if not exist already
      _firebaseFirestore
          .collection("funfix users")
          .doc(userCredential.user!.uid)
          .set({"uid": userCredential.user!.uid, "email": email});
      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }
  //  sign up

  Future<UserCredential> signUpWithEmailPassword(String email, password) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);

      // save user info in a seprate docment
      _firebaseFirestore
          .collection("funfix users")
          .doc(userCredential.user!.uid)
          .set({"uid": userCredential.user!.uid, "email": email});
      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }
  //sign out

  Future<void> signout() async {
    return await _auth.signOut();
  }

  //error
}
