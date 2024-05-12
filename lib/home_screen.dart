import 'package:chat_app/auth_screen/login_user.dart';
import 'package:chat_app/chat_room.dart';
import 'package:chat_app/consts/consts.dart';
import 'package:chat_app/firebase_functions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Map<String, dynamic> userMap = {};
  bool isLoading = false;
  final _auth = FirebaseAuth.instance;

  final _search = TextEditingController();

  void onSearch() async {
    final _firestore = FirebaseFirestore.instance;

    setState(() {
      isLoading = true;
    });
    // To Get the data on the Cloud Firestore database by using email
    await _firestore
        .collection("Users")
        .where("email", isEqualTo: _search.text)
        .get()
        .then((value) {
      setState(() {
        userMap = value.docs[0].data() as Map<String, dynamic>;
        isLoading = false;
      });
    });
  }

// Identify the users

  String chatRoomId(String user1, String user2) {
    if (user1[0].toLowerCase().codeUnits[0] >
        user2[0].toLowerCase().codeUnits[0]) {
      return "$user1$user2";
    } else {
      return "$user2$user1";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        title: onStart.text.white.fontFamily(bold).make(),
        leading: Image.asset(
          logo,
          width: 40,
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.logout,
              color: whiteColor,
            ),
            onPressed: () {
              signOut();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const LoginScreen()),
              );
            },
          )
        ],
        automaticallyImplyLeading: false,
        centerTitle: true,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  20.heightBox,
                  TextField(
                    controller: _search,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.search),
                      hintText: search,
                      filled: true,
                      fillColor: lightGrey,
                      hintStyle: TextStyle(
                        fontFamily: semibold,
                        color: darkFontGrey,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: onSearch,
                    style: ElevatedButton.styleFrom(
                        backgroundColor: darkFontGrey,
                        textStyle: const TextStyle(
                          color: whiteColor,
                        )),
                    child: search.text.white.make(),
                  ),
                  10.heightBox,
                  userMap.isNotEmpty
                      ? ListTile(
                          onTap: () {
                            String roomId = chatRoomId(
                                _auth.currentUser?.displayName ?? "Anonymous",
                                userMap['name']);

                            Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) => ChatRoom(
                                        chatRoomId: roomId,
                                        userMap: userMap,
                                      )),
                            );
                          },
                          leading: const Icon(
                            Icons.account_box,
                            color: whiteColor,
                          ),
                          title: Text(
                            userMap["name"] ?? "",
                            style: const TextStyle(
                              fontFamily: semibold,
                              color: whiteColor,
                              fontSize: 17,
                            ),
                          ),
                          subtitle: Text(userMap["email"] ?? ""),
                        )
                      : Container(),
                ],
              ),
            ),
    );
  }
}
