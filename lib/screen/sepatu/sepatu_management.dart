import 'dart:async';
import 'package:aplikasi_sepatu/model/sepatu.dart';
import 'package:aplikasi_sepatu/screen/sepatu/sepatu_form.dart';
import 'package:flutter/material.dart';

class SepatuManagementScreen extends StatefulWidget {
  const SepatuManagementScreen({super.key});

  @override
  State<SepatuManagementScreen> createState() => _SepatuManagementScreenState();
}

class _SepatuManagementScreenState extends State<SepatuManagementScreen> {
  bool isLoading = true;
  Future<void> _fetchData() async {
    setState(() {
      isLoading = false;
    });
  }

  Future<void> simpanData(Sepatu sepatu) async {
    print(sepatu.id);

    final success = sepatu.id == null
        ? await Sepatu.tambahSepatu(sepatu)
        : await Sepatu.updateSepatu(sepatu.id!, sepatu);

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Sepatu berhasil disimpan')),
      );

      _fetchData(); // Refresh list
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Gagal menyimpan sepatu')),
      );
    }
  }

  Future<void> delete(Sepatu sepatu) async {
    final success = await Sepatu.hapusSepatu(sepatu.id!);
    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Sepatu berhasil dihapus')),
      );
      _fetchData();
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Kelola Sepatu')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.only(right: 30),
                child: Row(
                  children: [
                    const Text(
                      'Daftar Sepatu',
                      textAlign: TextAlign.start,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Spacer(),
                    ElevatedButton(
                      onPressed: () {
                        showModalBottomSheet(
                            context: context,
                            builder: (_) {
                              return SepatuForm(
                                sepatu: null,
                                onSave: (sepatu) {
                                  simpanData(sepatu);
                                  Navigator.of(context).pop();
                                },
                              );
                            });
                      },
                      child: Text('Tambah'),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              FutureBuilder(
                future: Sepatu.fetchSemuaSepatu(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  }
                  if (snapshot.hasError) {
                    return Text(snapshot.error.toString());
                  }
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      final sepatu = snapshot.data![index];
                      return ListTile(
                        title: Text('${sepatu.namaSepatu}'),
                        subtitle: Text(
                            'Merek: ${sepatu.merek}\nUkuran: ${sepatu.ukuran}\nHarga: Rp ${sepatu.harga}\nStok: ${sepatu.stok}\nDeskripsi: ${sepatu.deskripsi} ',
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.normal,
                                color: Colors.black,
                                overflow: TextOverflow.ellipsis)),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: Icon(Icons.edit),
                              onPressed: () {
                                print(sepatu.id);

                                showModalBottomSheet(
                                    context: context,
                                    builder: (_) {
                                      return SepatuForm(
                                        sepatu: sepatu,
                                        onSave: (sepatu) {
                                          simpanData(sepatu);
                                          Navigator.of(context).pop();
                                        },
                                      );
                                    });
                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () {
                                delete(sepatu);
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
