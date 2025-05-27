import 'dart:async';
import 'package:aplikasi_sepatu/model/sepatu.dart';
import 'package:flutter/material.dart';

class SepatuManagementScreen extends StatefulWidget {
  const SepatuManagementScreen({super.key});

  @override
  State<SepatuManagementScreen> createState() => _SepatuManagementScreenState();
}

class _SepatuManagementScreenState extends State<SepatuManagementScreen> {
  final namaSepatuController = TextEditingController();
  final merekController = TextEditingController();
  final ukuranController = TextEditingController();
  final hargaController = TextEditingController();
  final stokController = TextEditingController();
  final deskripsiController = TextEditingController();
  final gambarUrlController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  List<Sepatu> daftarSepatu = [];
  bool isLoading = true;

  Future<void> _fetchData() async {
    final data = await Sepatu.fetchSemuaSepatu();
    setState(() {
      daftarSepatu = data;
      isLoading = false;
    });
  }

  Future<void> simpanData() async {
    if (_formKey.currentState!.validate()) {
      final success = await Sepatu.tambahSepatu(Sepatu(
        namaSepatu: namaSepatuController.text,
        merek: merekController.text,
        ukuran: ukuranController.text,
        harga: hargaController.text,
        stok: stokController.text,
        deskripsi: deskripsiController.text,
        gambar: gambarUrlController.text,
      ));

      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Sepatu berhasil disimpan')),
        );
        _clearFields();
        _fetchData(); // Refresh list
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Gagal menyimpan sepatu')),
        );
      }
    }
  }

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
  void initState() {
    super.initState();
    _fetchData();
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Kelola Sepatu')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: namaSepatuController,
                      decoration:
                          const InputDecoration(labelText: 'Nama Sepatu'),
                      validator: (value) =>
                          value == null || value.isEmpty ? 'Wajib diisi' : null,
                    ),
                    TextFormField(
                      controller: merekController,
                      decoration: const InputDecoration(labelText: 'Merek'),
                      validator: (value) =>
                          value == null || value.isEmpty ? 'Wajib diisi' : null,
                    ),
                    TextFormField(
                      controller: ukuranController,
                      decoration: const InputDecoration(labelText: 'Ukuran'),
                      keyboardType: TextInputType.number,
                      validator: (value) =>
                          value == null || value.isEmpty ? 'Wajib diisi' : null,
                    ),
                    TextFormField(
                      controller: hargaController,
                      decoration: const InputDecoration(labelText: 'Harga'),
                      keyboardType: TextInputType.number,
                      validator: (value) =>
                          value == null || value.isEmpty ? 'Wajib diisi' : null,
                    ),
                    TextFormField(
                      controller: stokController,
                      decoration: const InputDecoration(labelText: 'Stok'),
                      keyboardType: TextInputType.number,
                      validator: (value) =>
                          value == null || value.isEmpty ? 'Wajib diisi' : null,
                    ),
                    TextFormField(
                      controller: deskripsiController,
                      decoration: const InputDecoration(labelText: 'Deskripsi'),
                    ),
                    TextFormField(
                      controller: gambarUrlController,
                      decoration:
                          const InputDecoration(labelText: 'Gambar URL'),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: simpanData,
                      child: const Text('Simpan Data Sepatu'),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              const Divider(),
              const SizedBox(height: 10),
              const Text(
                'Daftar Sepatu',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              isLoading
                  ? const CircularProgressIndicator()
                  : ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: daftarSepatu.length,
                      itemBuilder: (context, index) {
                        final sepatu = daftarSepatu[index];
                        return Card(
                          child: ListTile(
                            leading: Image.network(
                              sepatu.gambar,
                              width: 60,
                              errorBuilder: (_, __, ___) =>
                                  const Icon(Icons.image_not_supported),
                            ),
                            title: Text(sepatu.namaSepatu),
                            subtitle: Text(
                                '${sepatu.merek} - Ukuran ${sepatu.ukuran}'),
                            trailing: Text('Rp ${sepatu.harga}'),
                          ),
                        );
                      },
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
