import 'package:flutter_project/firebase/firebase.dart';
import 'package:flutter_project/models/item_models.dart';
import 'package:flutter_project/pages/form_page.dart';
import 'package:flutter_project/pages/profil_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  Future<String> _getUsername() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return "Guest";

    final doc = await FirebaseFirestore.instance
        .collection("users")
        .doc(user.uid)
        .get();

    return doc.data()?["username"] ?? "No Username";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Admin Online Shop"),
        actions: [
          IconButton(
            icon: Icon(Icons.person),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfilePage()),
              );
            },
          )
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FutureBuilder<String>(
            future: _getUsername(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Padding(
                  padding: const EdgeInsets.all(16),
                  child: CircularProgressIndicator(),
                );
              }
              return Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  "Hello, ${snapshot.data}",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              );
            },
          ),
          Expanded(
            child: StreamBuilder<List<Item>>(
              stream: FirebaseService().getItem(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text("Tidak ada data"));
                }
                final items = snapshot.data!;
                return ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    final item = items[index];
                    return ListTile(
                      title: Text(item.nama),
                      subtitle: Text(item.deskripsi),
                      trailing: IconButton(
                        onPressed: () async {
                          await FirebaseService().deleteItem(item.id);
                        },
                        icon: Icon(Icons.delete, color: Colors.red),
                      ),
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (builder) => FormPage(
                            item: item,
                            isEdit: true,
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (builder) => FormPage(isEdit: false),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
