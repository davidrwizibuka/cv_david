import 'dart:convert';

import 'package:http/http.dart' as http;

/// XAMPP in this setup serves Apache on port 8080.
/// Override for an Android emulator/phone without editing this service:
/// flutter run --dart-define=API_BASE_URL=http://10.0.2.2:8080/api-test/public
class ApiService {
  ApiService({http.Client? client}) : _client = client ?? http.Client();

  static const String baseUrl = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: 'http://localhost:8080/api-test/public',
  );

  final http.Client _client;
  static const _headers = {'Content-Type': 'application/json'};

  Future<Map<String, dynamic>> login(String email, String password) async {
    final result = await _send(
      _client.post(
        _uri('/accounts/login'),
        headers: _headers,
        body: jsonEncode({'email': email.trim(), 'password': password}),
      ),
    );
    return _map(result['data']);
  }

  Future<List<FamilyMember>> getFamilyMembers() async {
    final result = await _send(_client.get(_uri('/famille-membres')));
    final data = result['data'];
    if (data is! List) {
      throw const ApiException('La réponse de l’API ne contient pas une liste de membres.');
    }
    return data.map((item) => FamilyMember.fromJson(_map(item))).toList();
  }

  Future<void> addFamilyMember(FamilyMember member) async {
    await _send(
      _client.post(
        _uri('/famille-membres'),
        headers: _headers,
        body: jsonEncode(member.toJson()),
      ),
    );
  }

  Future<void> updateFamilyMember(FamilyMember member) async {
    final id = member.id;
    if (id == null) throw const ApiException('Identifiant du membre absent.');
    await _send(
      _client.put(
        _uri('/famille-membres/$id'),
        headers: _headers,
        body: jsonEncode(member.toJson()),
      ),
    );
  }

  Future<void> deleteFamilyMember(int id) async {
    await _send(_client.delete(_uri('/famille-membres/$id')));
  }

  Uri _uri(String path) => Uri.parse('$baseUrl$path');

  Future<Map<String, dynamic>> _send(Future<http.Response> request) async {
    late http.Response response;
    try {
      response = await request.timeout(const Duration(seconds: 15));
    } on Exception catch (error) {
      throw ApiException(
        'Impossible de joindre l’API ($baseUrl). Vérifiez XAMPP, Apache et votre réseau. Détail : $error',
      );
    }

    Map<String, dynamic> body;
    try {
      body = _map(jsonDecode(utf8.decode(response.bodyBytes)));
    } on FormatException {
      throw ApiException('Réponse illisible de l’API (HTTP ${response.statusCode}).');
    }
    if (response.statusCode < 200 || response.statusCode >= 300 || body['success'] != true) {
      final message = body['message']?.toString();
      final errors = body['errors'];
      final details = errors is Map ? errors.values.join('\n') : null;
      throw ApiException([
        if (message != null && message.isNotEmpty) message,
        if (details != null && details.isNotEmpty) details,
        if ((message == null || message.isEmpty) && (details == null || details.isEmpty))
          'Erreur HTTP ${response.statusCode}',
      ].join('\n'));
    }
    return body;
  }

  static Map<String, dynamic> _map(Object? value) =>
      value is Map<String, dynamic> ? value : <String, dynamic>{};
}

class ApiException implements Exception {
  const ApiException(this.message);
  final String message;

  @override
  String toString() => message;
}

class FamilyMember {
  const FamilyMember({
    this.id,
    required this.nom,
    required this.postnom,
    required this.prenom,
    required this.lieuNaissance,
    required this.dateNaissance,
    required this.parente,
    this.imageUrl,
  });

  final int? id;
  final String nom;
  final String postnom;
  final String prenom;
  final String lieuNaissance;
  final String dateNaissance;
  final String parente;
  final String? imageUrl;

  factory FamilyMember.fromJson(Map<String, dynamic> json) => FamilyMember(
        id: int.tryParse('${json['id'] ?? ''}'),
        nom: '${json['nom'] ?? ''}',
        postnom: '${json['postnom'] ?? ''}',
        prenom: '${json['prenom'] ?? ''}',
        lieuNaissance: '${json['lieu_naissance'] ?? ''}',
        dateNaissance: '${json['date_naissance'] ?? ''}',
        parente: '${json['parente'] ?? ''}',
        imageUrl: json['image_url']?.toString(),
      );

  Map<String, dynamic> toJson() => {
        'nom': nom,
        'postnom': postnom,
        'prenom': prenom,
        'lieu_naissance': lieuNaissance,
        'date_naissance': dateNaissance,
        'parente': parente,
      };
}
