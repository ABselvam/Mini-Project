import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../constants.dart';
import '../../models/pro.dart' as details;
import 'components/color_dot.dart';

class Product {
  String id;
  String title;
  double price;
  String description;
  int quantity;
  String imageLarge;

  // Add a constructor to initialize the fields
  Product({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.quantity,
    required this.imageLarge,
  });

  String get productId => id;

  int get productQuantity => quantity;
}

class DetailsScreen extends StatefulWidget {
  final details.Product product;

  const DetailsScreen({Key? key, required this.product}) : super(key: key);

  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  bool isFavorite = false;

  Future<void> toggleFavorite() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final favoriteRef = FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .collection('favorites');

      if (isFavorite) {
        favoriteRef.doc(widget.product.id).delete();
      } else {
        favoriteRef.doc(widget.product.id).set({
          'id': widget.product.id,
          'title': widget.product.title,
          'price': widget.product.price,
          'description': widget.product.description,
          'quantity': widget.product.quantity,
          'imageLarge': widget.product.imageLarge,
        });
      }

      setState(() {
        isFavorite = !isFavorite;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    checkIfFavorite();
  }

  Future<void> checkIfFavorite() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final favoriteRef = FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .collection('favorites');

      final favoriteSnapshot = await favoriteRef.doc(widget.product.id).get();
      setState(() {
        isFavorite = favoriteSnapshot.exists;
      });
    }
  }

  Future<void> addToCart(details.Product product) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final cartRef = FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .collection('cart');

      final existingCartItem = await cartRef.doc(product.id).get();
      if (existingCartItem.exists) {
        final quantity = existingCartItem.data()!['quantity'] as int;
        cartRef.doc(product.id).update({'quantity': quantity + 1});
      } else {
        cartRef.doc(product.id).set({'quantity': 1});
      }

      final productRef =
          FirebaseFirestore.instance.collection('products').doc(product.id);
      final currentStock = product.quantity;
      productRef.update({'quantity': currentStock - 1});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 54, 55, 59),
        leading: const BackButton(color: Color.fromARGB(255,226, 183, 19)),
        // actions: [
        //   IconButton(
        //     onPressed: toggleFavorite,
        //     icon: CircleAvatar(
        //       backgroundColor: Color.fromARGB(255, 54, 55, 59),
        //       child: SvgPicture.asset(
        //         "assets/icons/heart.svg",
        //         height: 70,
        //         color: isFavorite ? Colors.red : Color.fromARGB(255,226, 183, 19),
        //       ),
        //     ),
        //   )
        // ],
      ),
      body: Column(
        children: [
          Image.network(
            widget.product.imageLarge,
            height: MediaQuery.of(context).size.height * 0.4,
            fit: BoxFit.fill,
          ),
          const SizedBox(height: defaultPadding * 1.5),
          Expanded(
            child: Container(
              padding: const EdgeInsets.fromLTRB(defaultPadding,
                  defaultPadding * 2, defaultPadding, defaultPadding),
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 54, 55, 59),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(defaultBorderRadius * 4),
                  topRight: Radius.circular(defaultBorderRadius * 4),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          widget.product.title,
                          style: TextStyle(color: Color.fromARGB(255,226, 183, 19),
                          fontSize: 40)
                        ),
                      ),
                      const SizedBox(width: defaultPadding),
                      Text(
                        "\₹ " + widget.product.price.toString() + "/day",
                        style: TextStyle(color: Color.fromARGB(255,226, 183, 19),
                          fontSize: 25)
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: defaultPadding),
                    child: Text(widget.product.description ?? ''),
                  ),
                  SizedBox(height: 50),
                  Text(
                    "Add to favourites",
                    style: TextStyle(color: Color.fromARGB(255,226, 183, 19))
                  ),
                  const SizedBox(height: defaultPadding / 2),
                  IconButton(
            onPressed: toggleFavorite,
            icon: CircleAvatar(
              radius: 200,
              backgroundColor: Color.fromARGB(255, 54, 55, 59),
              child: SvgPicture.asset(
                "assets/icons/heart.svg",
                height: 100,
                color: isFavorite ? Colors.red : Color.fromARGB(255,226, 183, 19),
              ),
            ),
          ),
                  const SizedBox(height: defaultPadding * 2),
                  Center(
                    child: SizedBox(
                      width: 200,
                      height: 48,
                      child: ElevatedButton(
                        onPressed: () {
                          addToCart(widget.product);
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text("Product Rented"),
                                content: TextButton(
                                  child: Text("OK"),
                                  onPressed: () => Navigator.of(context).pop(),
                                ),
                              );
                            },
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromARGB(255,226, 183, 19),
                          shape: const StadiumBorder(),
                        ),
                        child: const Text("Rent now"),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
