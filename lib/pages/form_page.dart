import 'package:flutter_project/firebase/firebase.dart';
import 'package:flutter_project/models/item_models.dart';
import 'package:flutter/material.dart';

class FormPage extends StatefulWidget {
  final Item? item;
  final bool isEdit;
  const FormPage({super.key, this.item, required this.isEdit});


  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final _namacontroller = TextEditingController();
  final _deskripsicontroller = TextEditingController();

  Future<void> _saveItem() async{
    final nama = _namacontroller.text;
    final deskripsi = _deskripsicontroller.text;
    if (nama.isEmpty || deskripsi.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("All fields are required")));
      return;
    }

    final itemData = Item(
      id: widget.item?.id??'', 
      nama: nama, 
      deskripsi: deskripsi
    );
        if (widget.isEdit && widget.item != null) {
      await FirebaseService().updateitem(itemData.id, itemData.toMap());
    } else {
      await FirebaseService().createItem(itemData);
    }

    if (mounted) {
      Navigator.pop(context);
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Tambah Data"),),
      body: Padding(padding: EdgeInsets.all(10),
        child: Column(
          children: [
            TextField(
              controller: _namacontroller,
              decoration: InputDecoration(labelText: "Nama"),
            ),
            TextField(
              controller: _deskripsicontroller,
              decoration: InputDecoration(labelText: "Deskripsi"),
            ),
            ElevatedButton(onPressed: _saveItem, child: Text("Simpan"),)
          ],
        )
      ),
    );
  }
}