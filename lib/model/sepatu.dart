import 'dart:convert';
import 'package:http/http.dart' as http;

const String baseUrl = 'http://localhost:3000';

class Sepatu {
  final String? id;
  final String namaSepatu;
  final String merek;
  final String ukuran;
  final String harga;
  final String stok;
  final String deskripsi;
  final String gambar;

  Sepatu({
    this.id,
    required this.namaSepatu,
    required this.merek,
    required this.ukuran,
    required this.harga,
    required this.stok,
    required this.deskripsi,
    required this.gambar,
  });

  factory Sepatu.fromJson(Map<String, dynamic> json) {
    return Sepatu(
      id: json['id'],
      namaSepatu: json['nama_sepatu'],
      merek: json['merek'],
      ukuran: json['ukuran'],
      harga: json['harga'],
      stok: json['stok'],
      deskripsi: json['deskripsi'],
      gambar: json['gambar_url'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nama_sepatu': namaSepatu,
      'merek': merek,
      'ukuran': ukuran,
      'harga': harga,
      'stok': stok,
      'deskripsi': deskripsi,
      'gambar_url': gambar,
    };
  }

  static Future<List<Sepatu>> fetchSemuaSepatu() async {
    final response = await http.get(Uri.parse('$baseUrl/sepatu'));
    if (response.statusCode == 200) {
      List data = json.decode(response.body);
      return data
          .map((json) => Sepatu(
                namaSepatu: json['nama_sepatu'],
                merek: json['merek'],
                ukuran: json['ukuran'.toString()],
                harga: json['harga'].toString(),
                stok: json['stok'].toString(),
                deskripsi: json['deskripsi'],
                gambar: json['gambar_url'],
              ))
          .toList();
    } else {
      throw Exception('Gagal memuat data sepatu');
    }
  }

  static Future<bool> tambahSepatu(Sepatu sepatu) async {
    final response = await http.post(
      Uri.parse('$baseUrl/sepatu'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(sepatu.toJson()),
    );
    return response.statusCode == 201;
  }

  static Future<bool> updateSepatu(int id, Sepatu sepatu) async {
    final response = await http.put(
      Uri.parse('$baseUrl/sepatu/$id'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(sepatu.toJson()),
    );
    return response.statusCode == 200;
  }

  static Future<bool> hapusSepatu(int id) async {
    final response = await http.delete(Uri.parse('$baseUrl/sepatu/$id'));
    return response.statusCode == 200;
  }
}
