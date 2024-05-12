import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

// Authenticate using Firebase

// signup function
Future<User?> createUserWithEmailAndPassword(
    String name, String emailAddress, String password) async {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  try {
    final credential = (await _auth.createUserWithEmailAndPassword(
      email: emailAddress,
      password: password,
    ))
        .user;
    if (credential != null) {
      print("User Created Successfully");
      // To update the display name
      credential.updateDisplayName(name);

      // To update data on the Cloud Firestore database
      await _firestore.collection("Users").doc(_auth.currentUser?.uid).set(
          {"name": name, "email": emailAddress, "available": "Unavailable"});

      return credential;
    } else {
      print("Account Creation failed");
      return credential;
    }
  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      print('The password provided is too weak.');
    } else if (e.code == 'email-already-in-use') {
      print('The account already exists for that email.');
    }
  } catch (e) {
    print(e);
  }
  return null;
}

//sign in function
Future<User?> signInWithEmailAndPassword(
    String emailAddress, String password) async {
  final _auth = FirebaseAuth.instance;

  try {
    final credential = (await _auth.signInWithEmailAndPassword(
      email: emailAddress,
      password: password,
    ))
        .user;
    if (credential != null) {
      print("User Login Successfull");
      return credential;
    } else {
      print("Login Failed");
      return credential;
    }
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      print('No user found for that email.');
    } else if (e.code == 'wrong-password') {
      print('Wrong password provided for that user.');
    }
  }
  return null;
}

//sign out function

Future<User?> signOut() async {
  final _auth = FirebaseAuth.instance;
  try {
    await _auth.signOut();
  } catch (e) {
    print(e);
  }
  return null;
}
