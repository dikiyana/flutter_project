import 'package:flutter_project/models/item_models.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class FirebaseService{
  final _db = FirebaseFirestore.instance;

  Future<void> createItem(Item item) async{
    await _db.collection('item').add(item.toMap());
  }
  Stream<List<Item>> getItem(){
    return _db.collection('item').orderBy('createdAt', descending: true)
    .snapshots()
    .map((snap)=> snap.docs.map((e) =>  Item.fromDoc(e),).toList());
  }
  Future<void> updateitem(String id, Map<String, dynamic> data) async{
    await _db.collection('item').doc(id).update(data);
  }
  Future<void> deleteItem(String id) async{
    await _db.collection('item').doc(id).delete();
  }

}
