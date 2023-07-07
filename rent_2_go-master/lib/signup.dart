import 'dart:io';
import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:rent_2_go/login.dart';

import '../../constants.dart';

class SignUpPage extends StatefulWidget {
  SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _statusController = TextEditingController();
  final TextEditingController _roleController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  PickedFile? _imageFile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: getBody(),
    );
  }

  Widget getBody() {
    var size = MediaQuery.of(context).size;

    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(
                top: 25,
                left: 25,
                right: 25,
                bottom: 10,
              ),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255,51, 52, 56),
                borderRadius: BorderRadius.circular(25),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.03),
                    spreadRadius: 10,
                    blurRadius: 3,
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 20,
                  bottom: 25,
                  right: 20,
                  left: 20,
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Stack(
                          children: [
                            if (_imageFile != null)
                              Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(17.0),
                                  child: CircleAvatar(
                                    backgroundImage:
                                        FileImage(File(_imageFile!.path)),
                                    radius: 60,
                                  ),
                                ),
                              )
                            else
                              const Center(
                                child: Padding(
                                  padding: EdgeInsets.all(17.0),
                                  child: CircleAvatar(
                                    backgroundImage: AssetImage(
                                        'assets/images/default_profile_pic.webp'),
                                    radius: 60,
                                  ),
                                ),
                              ),
                            Positioned(
                              bottom: 5,
                              left: 105,
                              child: IconButton(
                                onPressed: _selectImage,
                                icon: const Icon(
                                  Icons.add_a_photo_outlined,
                                  size: 40,
                                  color: Color.fromARGB(255,226, 183, 19),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    Container(
                      width: size.width - 40,
                      child: Column(
                        children: [
                          TextField(
                            cursorColor: const Color.fromARGB(255,226, 183, 19),
                            controller: _nameController,
                            style: const TextStyle(
                              color: Color.fromARGB(255,226, 183, 19)
                            ),
                            decoration: const InputDecoration(
                              labelText: 'Name',
                              labelStyle: TextStyle(
                                color: Color.fromARGB(255,226, 183, 19),
                              ),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(width: 10, color: Color.fromARGB(255,226, 183, 19))
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          TextField(
                            cursorColor: const Color.fromARGB(255,226, 183, 19),
                            controller: _genderController,
                            style: const TextStyle(
                              color: Color.fromARGB(255,226, 183, 19)
                            ),
                            decoration: const InputDecoration(
                              labelText: 'Gender',
                              labelStyle: TextStyle(
                                color: Color.fromARGB(255,226, 183, 19),
                              ),
                              border: OutlineInputBorder(),
                            ),
                          ),
                          const SizedBox(height: 10),
                          TextField(
                            cursorColor: const Color.fromARGB(255,226, 183, 19),
                            controller: _ageController,
                            style: const TextStyle(
                              color: Color.fromARGB(255,226, 183, 19)
                            ),
                            decoration: const InputDecoration(
                              labelText: 'Age',
                              labelStyle: TextStyle(
                                color: Color.fromARGB(255,226, 183, 19),
                              ),
                              border: OutlineInputBorder(),
                            ),
                          ),
                          const SizedBox(height: 10),
                          TextField(
                            cursorColor: const Color.fromARGB(255,226, 183, 19),
                            controller: _emailController,
                            style: const TextStyle(
                              color: Color.fromARGB(255,226, 183, 19)
                            ),
                            decoration: const InputDecoration(
                              labelText: 'Email',
                              labelStyle: TextStyle(
                                color: Color.fromARGB(255,226, 183, 19),
                              ),
                              border: OutlineInputBorder(),
                            ),
                          ),
                          const SizedBox(height: 10),
                          TextField(
                            cursorColor: const Color.fromARGB(255,226, 183, 19),
                            controller: _passwordController,
                            style: const TextStyle(
                              color: Color.fromARGB(255,226, 183, 19)
                            ),
                            decoration: const InputDecoration(
                              labelText: 'Password',
                              labelStyle: TextStyle(
                                color: Color.fromARGB(255,226, 183, 19),
                              ),
                              border: OutlineInputBorder(),
                            ),
                            obscureText: true,
                          ),
                          const SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: signUp,
                            child: const Text('Sign Up',
                            style: TextStyle(
                              fontSize: 22,
                            ),),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color.fromARGB(255,226, 183, 19),
                              foregroundColor: Color.fromARGB(255, 0, 0, 0)
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 60,),
            Padding(
                padding: const EdgeInsets.only(left: 26.0, right: 26.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Already have an account?  ',
                    style: TextStyle(
                      color: Color.fromARGB(255,226, 183, 19)
                    ) ,),
                    InkWell(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LoginPage(),
                          ),
                        );
                      },
                      child: const Text(
                        "Login here",
                        style: TextStyle(
                          color: Color.fromARGB(255,226, 183, 19),
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  Future<void> _selectImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _imageFile = pickedFile;
      }
    });
  }

  Future<String> _uploadImageFile() async {
    if (_imageFile != null) {
      try {
        final firebase_storage.Reference storageRef = firebase_storage
            .FirebaseStorage.instance
            .ref()
            .child('user_images');
        final firebase_storage.UploadTask uploadTask = storageRef
            .child('${DateTime.now()}.jpg')
            .putFile(File(_imageFile!.path));

        final firebase_storage.TaskSnapshot snapshot = await uploadTask;

        final String downloadURL = await snapshot.ref.getDownloadURL();
        return downloadURL;
      } catch (e) {
        print('Error uploading image: $e');
      }
    }

    return '';
  }

  Future<void> signUp() async {
    try {
      final String imageUrl = await _uploadImageFile();

      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      String uid = userCredential.user!.uid;

      await _firestore.collection('users').doc(uid).set({
        'name': _nameController.text,
        'status': _statusController.text,
        'role': "User",
        'gender': _genderController.text,
        'age': _ageController.text,
        'image_url': imageUrl,
      });

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const LoginPage(),
        ),
      );
    } catch (e) {
      print(e.toString());
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Error'),
            content: Text(e.toString()),
            actions: <Widget>[
              TextButton(
                child: const Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }
}


// import 'dart:io';
// import 'dart:typed_data';

// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/container.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
// import 'package:rent_2_go/login.dart';

// import '../../constants.dart';

// class SignUpPage extends StatefulWidget {
//   SignUpPage({Key? key}) : super(key: key);

//   @override
//   _SignUpPageState createState() => _SignUpPageState();
// }

// class _SignUpPageState extends State<SignUpPage> {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//   final TextEditingController _nameController = TextEditingController();
//   final TextEditingController _statusController = TextEditingController();
//   final TextEditingController _roleController = TextEditingController();
//   final TextEditingController _genderController = TextEditingController();
//   final TextEditingController _ageController = TextEditingController();
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();
//   PickedFile? _imageFile;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: bgColor,
//       body: getBody(),
//     );
//   }

//   Widget getBody() {
//     var size = MediaQuery.of(context).size;

//     return SafeArea(
//       child: SingleChildScrollView(
//         child: Column(
//           children: [
//             Container(
//               margin: const EdgeInsets.only(
//                 top: 25,
//                 left: 25,
//                 right: 25,
//                 bottom: 10,
//               ),
//               decoration: BoxDecoration(
//                 color: primaryColor,
//                 borderRadius: BorderRadius.circular(25),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.grey.withOpacity(0.03),
//                     spreadRadius: 10,
//                     blurRadius: 3,
//                   ),
//                 ],
//               ),
//               child: Padding(
//                 padding: const EdgeInsets.only(
//                   top: 20,
//                   bottom: 25,
//                   right: 20,
//                   left: 20,
//                 ),
//                 child: Column(
//                   children: [
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children:[
//                         Stack(
//                 children: [
//                   _imageFile !=null
//                   ? Center(
//                      child: Padding(
//                       padding: const EdgeInsets.all(17.0),
//                       child: CircleAvatar(
//                         backgroundImage: MemoryImage(Pi),
//                         radius: 60,
//                         ),
//                       )
//                    )
//                    :  const Center(
//                      child: Padding(
//                       padding: EdgeInsets.all(17.0),
//                       child: CircleAvatar(
//                         backgroundImage: AssetImage('assets/images/default_profile_pic.webp'),
//                         radius: 60,
//                         ),
//                       ),
//                    ),
//                    Positioned(
//                     bottom:5,
//                     left: 97,
//                     child: IconButton(
//                       onPressed: _selectImage, 
//                     icon:  const Icon(Icons.add_a_photo_outlined,
//                     size: 40,
//                     color: Color.fromARGB(255, 255, 222, 36),)))
//                 ],
//               ),
//                         // const Icon(Icons.bar_chart),
//                         // const Icon(Icons.person_2_outlined),
//                       ],
//                     ),
//                     const SizedBox(height: 15),
//                     Container(
//                       width: size.width - 40,
//                       child: Column(
//                         children: [
//                           TextField(
//                             controller: _nameController,
//                             decoration: const InputDecoration(
//                               labelText: 'Name',
//                               labelStyle: TextStyle(
//                                 color: kTextColor,
//                               ),
//                               border: OutlineInputBorder(),
//                             ),
//                           ),
//                           const SizedBox(height: 10),
//                           // TextField(
//                           //   controller: _statusController,
//                           //   decoration: const InputDecoration(
//                           //     labelText: 'Status',
//                           //     labelStyle: TextStyle(
//                           //       color: kTextColor,
//                           //     ),
//                           //     border: OutlineInputBorder(),
//                           //   ),
//                           // ),
//                           // const SizedBox(height: 10),
//                           // TextField(
//                           //   controller: _roleController,
//                           //   decoration: const InputDecoration(
//                           //     labelText: 'Role',
//                           //     labelStyle: TextStyle(
//                           //       color: kTextColor,
//                           //     ),
//                           //     border: OutlineInputBorder(),
//                           //   ),
//                           // ),
//                           const SizedBox(height: 10),
//                           TextField(
//                             controller: _genderController,
//                             decoration: const InputDecoration(
//                               labelText: 'Gender',
//                               labelStyle: TextStyle(
//                                 color: kTextColor,
//                               ),
//                               border: OutlineInputBorder(),
//                             ),
//                           ),
//                           const SizedBox(height: 10),
//                           TextField(
//                             controller: _ageController,
//                             decoration: const InputDecoration(
//                               labelText: 'Age',
//                               labelStyle: TextStyle(
//                                 color: kTextColor,
//                               ),
//                               border: OutlineInputBorder(),
//                             ),
//                           ),
//                           const SizedBox(height: 10),
//                           TextField(
//                             controller: _emailController,
//                             decoration: const InputDecoration(
//                               labelText: 'Email',
//                               labelStyle: TextStyle(
//                                 color: kTextColor,
//                               ),
//                               border: OutlineInputBorder(),
//                             ),
//                           ),
//                           const SizedBox(height: 10),
//                           TextField(
//                             controller: _passwordController,
//                             decoration: const InputDecoration(
//                               labelText: 'Password',
//                               labelStyle: TextStyle(
//                                 color: kTextColor,
//                               ),
//                               border: OutlineInputBorder(),
//                             ),
//                             obscureText: true,
//                           ),
//                           // const SizedBox(height: 10),
//                           // ElevatedButton(
//                           //   onPressed: _selectImage,
//                           //   child: const Text('Select profile picture'),
//                           // ),
//                           const SizedBox(height: 20),
//                           ElevatedButton(
//                             onPressed: signUp,
//                             child: const Text('Sign Up'),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Future<void> _selectImage() async {
//     final picker = ImagePicker();
//     final pickedFile = await picker.getImage(source: ImageSource.gallery);

//     setState(() {
//       if (pickedFile != null) {
//         _imageFile = pickedFile;
//       }
//     });
//   }

//   // Future<String> _uploadImageFile() async {
//   //   if (_imageFile != null) {
//   //     try {
//   //       final firebase_storage.Reference storageRef = firebase_storage
//   //           .FirebaseStorage.instance
//   //           .ref()
//   //           .child('user_images');
//   //       final firebase_storage.UploadTask uploadTask = storageRef
//   //           .child('${DateTime.now()}.jpg')
//   //           .putFile(File(_imageFile!.path));

//   //       final firebase_storage.TaskSnapshot snapshot = await uploadTask;

//   //       final String downloadURL = await snapshot.ref.getDownloadURL();
//   //       return downloadURL;
//   //     } catch (e) {
//   //       print('Error uploading image: $e');
//   //     }
//   //   }

//   //   return '';
//   // }

//   Future<String> _uploadImageFile() async {
//     if (_imageFile != null) {
//       try {
//         final firebase_storage.Reference storageRef = firebase_storage
//             .FirebaseStorage.instance
//             .ref()
//             .child('user_images');
//         final firebase_storage.UploadTask uploadTask = storageRef
//             .child('${DateTime.now()}.jpg')
//             .putFile(File(_imageFile!.path));

//         final firebase_storage.TaskSnapshot snapshot = await uploadTask;

//         final String downloadURL = await snapshot.ref.getDownloadURL();
//         return downloadURL;
//       } catch (e) {
//         print('Error uploading image: $e');
//       }
//     }

//     return '';
//   }

//   Future<void> signUp() async {
//     try {
//       final String imageUrl = await _uploadImageFile();

//       UserCredential userCredential =
//           await _auth.createUserWithEmailAndPassword(
//         email: _emailController.text.trim(),
//         password: _passwordController.text.trim(),
//       );

//       String uid = userCredential.user!.uid;

//       await _firestore.collection('users').doc(uid).set({
//         'name': _nameController.text,
//         'status': _statusController.text,
//         'role': "User",
//         'gender': _genderController.text,
//         'age': _ageController.text,
//         'image_url': imageUrl,
//       });

//       Navigator.push(
//         context,
//         MaterialPageRoute(
//           builder: (context) => const LoginPage(),
//         ),
//       );
//     } catch (e) {
//       print(e.toString());
//       showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return AlertDialog(
//             title: const Text('Error'),
//             content: Text(e.toString()),
//             actions: <Widget>[
//               TextButton(
//                 child: const Text('OK'),
//                 onPressed: () {
//                   Navigator.of(context).pop();
//                 },
//               ),
//             ],
//           );
//         },
//       );
//     }
//   }
// }
