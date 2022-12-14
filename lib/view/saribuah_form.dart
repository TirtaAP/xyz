import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:xyz/controller/sariBuahcontroller.dart';
import 'package:xyz/entity/komposisi.dart';
import 'package:xyz/helper/format_changer.dart';
import 'package:xyz/view/komposisi_form.dart';
import 'package:xyz/entity/komposisi.dart';

class BarangForm extends StatefulWidget {
  BarangForm({Key? key}) : super(key: key);

  @override
  State<BarangForm> createState() => _BarangFormState();
}

class _BarangFormState extends State<BarangForm> {
  final TextEditingController _tanggalproduksi = TextEditingController();
  final TextEditingController _tanggalkadaluarsa = TextEditingController();
  final TextEditingController _isiBersih = TextEditingController();
  final TextEditingController _harga = TextEditingController();
  final TextEditingController _jumlah = TextEditingController();
  final sariBuahController saribuahController = Get.put(sariBuahController());
  var tanggalKadaluarsa;
  var tanggalProduksi;
  final _formKey = GlobalKey<FormState>();
  late String docid;
  final Stream<QuerySnapshot> _Stream =
      FirebaseFirestore.instance.collection('saribuah').snapshots();

  Map<String, Komposisi> daftarKomposisi = {};

  void _trySubmitForm() {
    final bool? isValid = _formKey.currentState?.validate();
    if (isValid == true) {
      saribuahController.addSariBuah(context, _isiBersih.text, tanggalProduksi,
          tanggalKadaluarsa, _harga.text, _jumlah.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text('Tambah Sari Buah'),
        backgroundColor: Colors.red,
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Container(
            child: Center(
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _isiBersih,
                      decoration:
                          const InputDecoration(labelText: 'Isi Bersih'),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Mohon Masukan Data';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: ElevatedButton(
                          onPressed: () => _trySubmitForm(),
                          child: const Text('Simpan')),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
