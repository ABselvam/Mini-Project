import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../models/pro.dart' as details;

class FavoritesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final favoriteRef = FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .collection('favorites');

      return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 54, 55, 59),
          title: Text('Favorites',
          style: TextStyle(
            color: Color.fromARGB(255,226, 183, 19)
          ),),
        ),
        backgroundColor: Colors.black,
        body: StreamBuilder<QuerySnapshot>(
          stream: favoriteRef.snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final favoriteDocs = snapshot.data!.docs;
              if (favoriteDocs.isNotEmpty) {
                return ListView.builder(
                  itemCount: favoriteDocs.length,
                  itemBuilder: (context, index) {
                    final favoriteData =
                        favoriteDocs[index].data() as Map<String, dynamic>;
                    final favoriteProduct = details.Product(
                      id: favoriteData['id'] ?? '',
                      title: favoriteData['title'] ?? '',
                      price: favoriteData['price'] ?? 0.0,
                      description: favoriteData['description'] ?? '',
                      quantity: favoriteData['quantity'] ?? 0,
                      imageSmall: favoriteData['imageSmall'] ?? '',
                      imageLarge: favoriteData['imageLarge'] ?? '',
                      category: favoriteData['category'] ?? '',
                      userId: favoriteData['userId'] ?? '',
                    );
                    return Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: ListTile(
                        tileColor: Color.fromARGB(255, 54, 55, 59),
                        title: Text(favoriteProduct.title,
                        style: TextStyle(color: Color.fromARGB(255,226, 183, 19)),),
                        leading: ConstrainedBox(
                          constraints: BoxConstraints(
                            minHeight: 500,
                            minWidth: 100
                          ),
                          child: Image(
                            image: NetworkImage(favoriteProduct.imageLarge),
                            width: 100,
                            height: 100,
                            fit: BoxFit.fill,
                          ),
                        ),
                        subtitle: Text("Price: ₹ ${favoriteProduct.price}/day",
                        style: TextStyle(color: Color.fromARGB(255,226, 183, 19)),),
                        trailing: IconButton(
                          icon: Icon(Icons.delete,
                          color: Color.fromARGB(255,226, 183, 19) ,),
                          onPressed: () {
                            favoriteRef.doc(favoriteProduct.id).delete();
                          },
                        ),
                      ),
                    );
                  },
                );
              } else {
                return Center(
                  child: Text("No favorites yet."),
                );
              }
            } else if (snapshot.hasError) {
              return Center(
                child: Text("Error: ${snapshot.error}"),
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      );
    } else {
      return Center(
        child: Text("User not logged in."),
      );
    }
  }
}
