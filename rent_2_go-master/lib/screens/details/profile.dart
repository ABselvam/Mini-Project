import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../constants.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: getBody(),
    );
  }

  Widget getBody() {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.black,
        body: SafeArea(
          child: SingleChildScrollView(
              child: Column(
              children: [
          Container(
              margin: EdgeInsets.only(top: 25, left: 25, right: 25, bottom: 10),
              decoration: BoxDecoration(
                  color: Color.fromARGB(255, 54, 55, 59),
                  borderRadius: BorderRadius.circular(25),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.03),
                      spreadRadius: 10,
                      blurRadius: 3,
                      // changes position of shadow
                    ),
                  ]),
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 20, bottom: 25, right: 20, left: 20),
                child: Column(
                  children: [
                    SizedBox(
                      height: 15,
                    ),
                    StreamBuilder<DocumentSnapshot>(
                      stream: _firestore
                          .collection('users')
                          .doc(_auth.currentUser?.uid)
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          Map<String, dynamic> userMap =
                              snapshot.data!.data() as Map<String, dynamic>;
                          String? imageUrl = userMap['image_url']
                              as String?; // Retrieve the image URL
        
                          return Column(
                            children: [
                              Container(
                                width: 200,
                                height: 200,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: imageUrl != null
                                      ? DecorationImage(
                                          image: NetworkImage(imageUrl),
                                          fit: BoxFit.cover,
                                        )
                                      : null,
                                ),
                              ),
                              SizedBox(height: 10),
                              Container(
                                width: (size.width - 40) * 0.6,
                                child: Column(
                                  children: [
                                    Text(
                                      userMap['name'],
                                      style: TextStyle(
                                        fontSize: 40,
                                        fontWeight: FontWeight.bold,
                                        color: Color.fromARGB(255,226, 183, 19),
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    SizedBox(height: 10),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text(
                                          userMap['role'],
                                          style: TextStyle(
                                            fontSize: 25,
                                            fontWeight: FontWeight.bold,
                                            color: Color.fromARGB(255,226, 183, 19)
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Column(
                                    children: [
                                      Text(
                                        userMap['age'],
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w600,
                                            color: Color.fromARGB(255,226, 183, 19) ),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        "Age",
                                        style: TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold,
                                            color: Color.fromARGB(255,226, 183, 19)),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          );
                        } else {
                          return Container(); // or any other widget to return
                        }
                      },
                    ),
                  ],
                ),
              ))
              ],
            )),
        ));
  }
}
