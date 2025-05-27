import 'package:aplikasi_sepatu/model/sepatu.dart';
import 'package:flutter/material.dart';

class SepatuTile extends StatelessWidget {
  final Sepatu sepatu;
  SepatuTile({super.key, required this.sepatu});

  @override
  Widget build(BuildContext context) {
    return ListTile(
        leading: Icon(Icons.shop),
        title: Text('${sepatu.namaSepatu}'),
        subtitle: Text(
            'Merek: ${sepatu.merek}\nUkuran: ${sepatu.ukuran}\nHarga: Rp. ${sepatu.harga}\nStok: ${sepatu.stok}\nDeskripsi: ${sepatu.deskripsi} '));
  }
}
