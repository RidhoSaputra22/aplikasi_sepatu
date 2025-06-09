import 'dart:convert';
import 'package:http/http.dart' as http;

const String baseUrl = 'http://localhost:3000';

class Sepatu {
  final int? id;
  final String? namaSepatu;
  final String? merek;
  final String? ukuran;
  final String? harga;
  final String? stok;
  final String? deskripsi;

  Sepatu({
    this.id,
    required this.namaSepatu,
    required this.merek,
    required this.ukuran,
    required this.harga,
    required this.stok,
    required this.deskripsi,
  });

  factory Sepatu.fromJson(Map<String, dynamic> json) {
    return Sepatu(
      id: json['id'] ?? null,
      namaSepatu: json['nama_sepatu'] ?? null,
      merek: json['merek'] ?? null,
      ukuran: json['ukuran']?.toString() ?? null,
      harga: json['harga']?.toString() ?? null,
      stok: json['stok']?.toString() ?? null,
      deskripsi: json['deskripsi'] ?? null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id ?? null,
      'nama_sepatu': namaSepatu ?? null,
      'merek': merek ?? null,
      'ukuran': ukuran ?? null,
      'harga': harga ?? null,
      'stok': stok ?? null,
      'deskripsi': deskripsi ?? null,
    };
  }

  static Future<List<Sepatu>> fetchSemuaSepatu() async {
    final response = await http.get(Uri.parse('$baseUrl/sepatu'));
    if (response.statusCode == 200) {
      List data = json.decode(response.body);
      return data
          .map((json) => Sepatu.fromJson(json as Map<String, dynamic>))
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
