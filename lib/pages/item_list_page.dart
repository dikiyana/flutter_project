import 'package:bootcamp_flutter_tm06/firebase/firebase.dart';
import 'package:bootcamp_flutter_tm06/models/item_models.dart';
import 'package:bootcamp_flutter_tm06/pages/form_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ItemListPage extends StatelessWidget {
  const ItemListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Final Project CRUD"),),
      body: StreamBuilder<List<Item>>(
        stream: FirebaseService().getItem(), 
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator(),);
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty){
              return Center(child: Text("Tidak ada data"));
          }
          final items = snapshot.data!;
          return ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index){
                final item = items[index];
                return ListTile(
                   title: Text(item.nama),
                   subtitle: Text(item.deskripsi),
                   trailing: IconButton(onPressed: ()async{
                    await FirebaseService().deleteItem(item.id);
                   }, icon: Icon(Icons.delete, color: Colors.red)),
                   onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (builder)=>FormPage(item: item,isEdit: true,))),
                );
            },
          );
        }
        ),
        floatingActionButton: FloatingActionButton(onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (builder)=>FormPage(isEdit: false,)));
        }),
    );
  }
}