import 'dart:convert';

import 'package:hospital_management_system/modals/User.dart';
import 'package:hospital_management_system/services/NetworkHelper.dart';

class apiHits {
  var net = Network();
  Doctor getDoctor() {
    json.decode((net.getData('doctor/')));
    return Doctor();
  }

  void createDoctor(Doctor doc) {
    net.postData({}, 'doctor/');
  }

  Doctor getPatient() {
    json.decode((net.getData('patients/')));
    return Doctor();
  }

  void createPatient(Doctor doc) {
    net.postData({}, 'patients/');
  }

  Doctor getHospital() {
    json.decode((net.getData('hospitals/')));
    return Doctor();
  }

  void createHospital(Doctor doc) {
    net.postData({}, 'hospitals/');
  }
}
