class Doctor {
  String name;
  String degree;
  String profession, expeirence, phoneNumber;
  List<String> hospitals;
}

class Hospital {
  String name;
  String address;
  String phoneNumber;
  int rating;
  List<String> doctors;
}

class Patient {
  String name;
  String NHID;
  String gender;
  int age;
}

class User {
  String email;
  Doctor doc;
  Hospital hos;
  Patient patient;
  String type;
}
