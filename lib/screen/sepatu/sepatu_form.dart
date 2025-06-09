import 'package:aplikasi_sepatu/model/sepatu.dart';
import 'package:flutter/material.dart';

class SepatuForm extends StatefulWidget {
  final Sepatu? sepatu;
  final Function(Sepatu sepatu) onSave;
  const SepatuForm({super.key, required this.onSave, required this.sepatu});

  @override
  State<SepatuForm> createState() => _SepatuFormState();
}

class _SepatuFormState extends State<SepatuForm> {
  final namaSepatuController = TextEditingController();
  final merekController = TextEditingController();
  final ukuranController = TextEditingController();
  final hargaController = TextEditingController();
  final stokController = TextEditingController();
  final deskripsiController = TextEditingController();
  final gambarUrlController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  void _clearFields() {
    namaSepatuController.clear();
    merekController.clear();
    ukuranController.clear();
    hargaController.clear();
    stokController.clear();
    deskripsiController.clear();
    gambarUrlController.clear();
  }

  @override
  void dispose() {
    namaSepatuController.dispose();
    merekController.dispose();
    ukuranController.dispose();
    hargaController.dispose();
    stokController.dispose();
    deskripsiController.dispose();
    gambarUrlController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.sepatu != null) {
      namaSepatuController.text = widget.sepatu!.namaSepatu!;
      merekController.text = widget.sepatu!.merek!;
      ukuranController.text = widget.sepatu!.ukuran!;
      hargaController.text = widget.sepatu!.harga!;
      stokController.text = widget.sepatu!.stok!;
      deskripsiController.text = widget.sepatu!.deskripsi!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: namaSepatuController,
                          decoration:
                              const InputDecoration(labelText: 'Nama Sepatu'),
                          validator: (value) => value == null || value.isEmpty
                              ? 'Wajib diisi'
                              : null,
                        ),
                      ),
                      const SizedBox(width: 3),
                      Expanded(
                        child: TextFormField(
                          controller: merekController,
                          decoration: const InputDecoration(labelText: 'Merek'),
                          validator: (value) => value == null || value.isEmpty
                              ? 'Wajib diisi'
                              : null,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  TextFormField(
                    controller: ukuranController,
                    decoration: const InputDecoration(labelText: 'Ukuran'),
                    keyboardType: TextInputType.number,
                    validator: (value) =>
                        value == null || value.isEmpty ? 'Wajib diisi' : null,
                  ),
                  const SizedBox(height: 5),
                  TextFormField(
                    controller: hargaController,
                    decoration: const InputDecoration(labelText: 'Harga'),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Wajib diisi';
                      } else if (int.tryParse(value) == null) {
                        return 'Harga harus berupa angka';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 5),
                  TextFormField(
                    controller: stokController,
                    decoration: const InputDecoration(labelText: 'Stok'),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Wajib diisi';
                      } else if (int.tryParse(value) == null) {
                        return 'Stok harus berupa angka';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 5),
                  TextFormField(
                    controller: deskripsiController,
                    decoration: const InputDecoration(labelText: 'Deskripsi'),
                  ),
                  const SizedBox(height: 5),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        final sepatu = Sepatu(
                          id: widget.sepatu?.id,
                          namaSepatu: namaSepatuController.text,
                          merek: merekController.text,
                          ukuran: ukuranController.text,
                          harga: hargaController.text,
                          stok: stokController.text,
                          deskripsi: deskripsiController.text,
                        );
                        widget.onSave(sepatu);
                        _clearFields();
                      }
                    },
                    child: const Text('Simpan Data Sepatu'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
