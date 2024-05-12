import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:velocity_x/velocity_x.dart';

class ChatRoom extends StatefulWidget {
  final Map<String, dynamic> userMap;
  final String chatRoomId;

  ChatRoom({required this.chatRoomId, required this.userMap});

  @override
  _ChatRoomState createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  final TextEditingController _messageController = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  void _onSendMessage() async {
    if (_messageController.text.isNotEmpty) {
      Map<String, dynamic> message = {
        "sendBy": _auth.currentUser!.displayName,
        "message": _messageController.text,
        "time": FieldValue.serverTimestamp(),
      };

// To update chats on the Cloud Firestore database
      await _firestore
          .collection('chatroom')
          .doc(widget.chatRoomId)
          .collection('chats')
          .add(message);
      _messageController.clear();
    } else {
      print("Enter Some Text");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.userMap['name']).text.white.make(),
      ),
      backgroundColor: Colors.blue,
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: _firestore
                  .collection('chatroom')
                  .doc(widget.chatRoomId)
                  .collection('chats')
                  .orderBy("time", descending: false)
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasData) {
                  final messages = snapshot.data!.docs;
                  List<Widget> messageWidgets = [];
                  for (var message in messages) {
                    final messageData = message.data() as Map<String, dynamic>;
                    final messageText = messageData['message'];
                    final messageSender = messageData['sendBy'];

                    final messageWidget = ListTile(
                      title: messageText.toString().text.make(),
                      subtitle: messageSender.toString().text.make(),
                      trailing: messageSender == _auth.currentUser!.displayName
                          ? null
                          : const Icon(Icons.arrow_forward),
                    ).card.make().p8();

                    messageWidgets.add(messageWidget);
                  }
                  return messageWidgets.isNotEmpty
                      ? ListView(
                          children: messageWidgets,
                        )
                      : 'No messages yet'.text.makeCentered();
                } else {
                  return const CircularProgressIndicator().centered();
                }
              },
            ),
          ),
          HStack(
            [
              Expanded(
                child: TextField(
                  controller: _messageController,
                  decoration: const InputDecoration(
                    hintText: 'Send Message',
                    filled: true,
                    fillColor: Colors.white,
                  ),
                ),
              ),
              IconButton(
                onPressed: _onSendMessage,
                icon: const Icon(Icons.send),
              )
            ],
          ).p16(),
        ],
      ),
    );
  }
}
