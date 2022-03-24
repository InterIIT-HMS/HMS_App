import 'dart:convert';
import 'dart:typed_data';

import 'package:http/http.dart';
import 'package:http/http.dart' as http;

class APIService {
  factory APIService() {
    return _api;
  }

  APIService._internal();
  static final APIService _api = APIService._internal();
  String _baseUrl = 'http://10.61.71.54:8080';

  Future<Map<String, dynamic>> createUser(String name, String contact) async {
    print('Start');
    Response response = await http.post(
      Uri.parse('${_baseUrl}/doctor'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'name': name,
        'degree': 'MBBS',
        'profession': 'Doctor',
        'experience': 3,
        'phone_number': contact,
      }),
    );
    print('Stop');
    print(response);
    if (response.statusCode == 200) {
      Map<String, dynamic> mp =
          (jsonDecode(response.body) as Map<String, dynamic>);
      return mp;
    } else {
      return null;
    }
  }

  Future<Map<String, dynamic>> createPatient(String name, String nhid) async {
    print('Start');
    Response response = await http.post(
      Uri.parse('${_baseUrl}/patient'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'name': name,
        'nhid': nhid,
        'gender': 'male',
        'age': 20,
      }),
    );
    print('Stop');
    print(response);
    if (response.statusCode == 200) {
      Map<String, dynamic> mp =
          (jsonDecode(response.body) as Map<String, dynamic>);
      return mp;
    } else {
      return null;
    }
  }

  Future<Map<String, dynamic>> createHospital(
      String name, String contact) async {
    print('Start');
    Response response = await http.post(
      Uri.parse('${_baseUrl}/hospital'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'name': name,
        'address': 'Delhi',
        'phonenumber': contact,
        'rating': 3,
      }),
    );
    print('Stop');
    print(response);
    if (response.statusCode == 200) {
      Map<String, dynamic> mp =
          (jsonDecode(response.body) as Map<String, dynamic>);
      return mp;
    } else {
      return null;
    }
  }

  // Future<Map<String, dynamic>> getAppointments(String token, String id) async {
  //   print('Start');
  //   Response response = await http.get('${_baseUrl}/appointments/}', headers: {
  //     'Content-Type': 'application/json',
  //     'Accept': 'application/json',
  //     'Authorization': 'Bearer $token',
  //   });
  //   print('Stop');
  //   print(response);
  //   if (response.statusCode == 200) {
  //     Map<String, dynamic> mp =
  //         (jsonDecode(response.body) as Map<String, dynamic>);
  //     return mp;
  //   } else {
  //     return null;
  //   }
  // }
}
