import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat/constants.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';




final _firestore = FirebaseFirestore.instance;

late User? loggedInUser;
class ChatScreen extends StatefulWidget {
  static String id = 'chatscreen';

  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}
class _ChatScreenState extends State<ChatScreen> {


  final _aut = FirebaseAuth.instance;

  //final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance.collection('messages').snapshots();
  late String messageText;
  late String messageSender;
  final messageController = TextEditingController();

  getCurentUser() async {
    try {
      final user = _aut.currentUser;
      if (user != null) {
        loggedInUser = user;

      }
    } catch (e) {
   e;
    }
  }

  //
  // void getMessages()async{
  //  final messages = await _firestore.collection('messages').get();
  //  for(var messages in messages.docs){
  //    print(messages.data());
  //  }
  // }
  // void getmessagesStream() async {
  //   await for (var snapshots in _firestore.collection('messages').snapshots()) {
  //     for (var messages in snapshots.docs) {
  //       print(messages.data());
  //     }
  //   }
  // }

  @override
  void initState() {
    super.initState();
    getCurentUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF1EDF6),
      appBar: AppBar(
        backgroundColor: Colors.lightBlueAccent,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {
               // getmessagesStream();
                _aut.signOut();
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.close,
              ))
        ],
        title: Text(
          '⚡️chat',
          style: TextStyle(fontSize: 27),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
             StreamMessages(),
              Container(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: TextField(
                        controller: messageController,
                        style: TextStyle(color: Colors.black),
                        onChanged: (value) {
                          messageText = value;
                        },
                        decoration: kSendmessageText,
                      ),
                    ),
                    MaterialButton(
                      onPressed: () {
                        messageController.clear();
                        _firestore.collection('messages').add({
                          'text': messageText,
                          'sender': loggedInUser!.email,
                          'time'  : FieldValue.serverTimestamp()
                        });
                      },
                      child: Icon(
                       Icons.send,color: Colors.lightBlueAccent,size: 30,
                        ),
                      ),

                  ],
                ),
              ),
            ]),
      ),
    );
  }
}
class MessagesBuddle extends StatelessWidget {
   MessagesBuddle({required this.sender,required this.isMe,required this.text,});

  final String sender ;
  final String text ;
  final bool isMe;
  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding:  EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment:isMe? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text(sender,style: TextStyle(fontSize: 17,color: Colors.black54),),
          Material(
            borderRadius: BorderRadius.only(
              topLeft:Radius.circular(17),
              topRight: Radius.circular(17),
              bottomLeft: Radius.circular(17),
            ),
            elevation: 5,
            color:isMe? Colors.lightBlueAccent: Colors.lightGreen,
            child: Column(
              children: [
                Padding(
                  padding:  EdgeInsets.symmetric(vertical: 10,horizontal: 20),
                  // child: Text(sender ,style: TextStyle(fontSize: 17,color: Colors.white),),
                ),
                Padding(
                  padding:  EdgeInsets.symmetric(vertical: 10,horizontal: 20),
                  child: Text(text,style: TextStyle(fontSize: 17,color: Colors.white),),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
class StreamMessages extends StatelessWidget {
  const StreamMessages({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: _firestore.collection('messages').orderBy('time').snapshots(),
        builder: ( context, snapshot) {

          List <MessagesBuddle> messageWidgtes= [];

          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator(color: Colors.grey,),);
          }
          final messages = snapshot.data?.docs.reversed;
          for(var message in messages!){

            final messageText = message.get('text');
            final messageSender = message.get('sender');

            final currentUser = loggedInUser?.email;

            final messageWidgite = MessagesBuddle(
              sender: messageSender,
              text: messageText,
              isMe:currentUser==messageSender ,
                );

            messageWidgtes.add(messageWidgite);
          }

          return Expanded(
            child: ListView(
              // pour classer les messages
             reverse: true,
              padding: EdgeInsets.symmetric(horizontal: 10,vertical: 20),
              children: messageWidgtes,
            ),
          );
        }
    );
  }
}


