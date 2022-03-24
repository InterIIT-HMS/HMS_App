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
  String _baseUrlAppointment = 'http://10.61.71.54:8081';
  String _baseUrlReports = 'http://10.61.71.54:8082';

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

  Future<List<dynamic>> getAppointments(String token) async {
    print('Start');
    Response response =
        await http.get('${_baseUrlAppointment}/secure/appointment', headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });
    print('Stop');
    print(response);
    if (response.statusCode == 200) {
      List<dynamic> mp = (jsonDecode(response.body) as List<dynamic>);
      return mp;
    } else {
      return null;
    }
  }

  Future<Map<String, dynamic>> createAppointment(
      String time, String agenda, int docId, String token) async {
        print(token);
        print(time);
    print('Start');
    Response response = await http.post(
      Uri.parse('${_baseUrlAppointment}/secure/appointment'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(<String, dynamic>{
        'doctor_id': docId,
        'agenda': agenda,
        'date_time': time,
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

  Future<List<Map<String, dynamic>>> getDoctors(String token) async {
    print('Start');
    Response response = await http.get('${_baseUrl}/secure/doctors', headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });
    print('Stop');
    print(response);
    if (response.statusCode == 200) {
      // List<dynamic> mp = (jsonDecode(response.body) as List<dynamic>);
      // DateTime().now().toUtc().toIso8601String();
      List<Map<String, dynamic>> lmp = (jsonDecode(response.body) as List)
          .map((e) => e as Map<String, dynamic>)
          ?.toList();
      return lmp;
    } else {
      return null;
    }
  }
}
