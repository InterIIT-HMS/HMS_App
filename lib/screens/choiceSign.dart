// Container(
//   padding: EdgeInsets.all(10.0),
//   child: DropdownButtonHideUnderline(
//     child: DropdownButton<String>(
//         items: _data.keys.map((String val) {
//           return DropdownMenuItem<String>(
//             value: val,
//             child: Row(
//               children: <Widget>[
//                 Padding(
//                   padding: EdgeInsets.symmetric(horizontal: 10.0),
//                   child: Icon(_data[val]),
//                 ),
//                 Text(val),
//               ],
//             ),
//           );
//         }).toList(),
//         hint: Row(
//           children: <Widget>[
//             Padding(
//               padding: EdgeInsets.symmetric(horizontal: 12.0),
//               child:
//                   Icon(_selectedIcon ?? _data.values.toList()[0]),
//             ),
//             Text(_selectedType ?? _data.keys.toList()[0]),
//           ],
//         ),
//         onChanged: (String val) {
//           setState(() {
//             _selectedType = val;
//             _selectedIcon = _data[val];
//           });
//         }),
//   ),
// ),

import 'package:flutter/material.dart';
import 'package:flutter_auth0/flutter_auth0.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hospital_management_system/constants/colors.dart';
import 'package:hospital_management_system/constants/images.dart';
import 'package:hospital_management_system/screens/SignUp.dart';
import 'package:hospital_management_system/widgets/MyButton.dart';

class ChooseSign extends StatefulWidget {
  static const String hospital = 'Hospital';
  static const String doctor = 'Doctor';
  static const String patient = 'Patient';
  @override
  _ChooseSignState createState() => _ChooseSignState();
}

class _ChooseSignState extends State<ChooseSign> {
  double width;
  double height;
  bool visible = false;
  bool _loading = false;

  bool isBusy = false;
  bool isLoggedIn = false;
  String errorMessage;

  TextEditingController _nameController = TextEditingController();
  TextEditingController _uidController = TextEditingController();
  TextEditingController _roleController = TextEditingController();

  TextEditingController _usernameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _contactController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _nameController.dispose();
    _usernameController.dispose();
    _emailController.dispose();
    _contactController.dispose();
    _addressController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Auth0 auth;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    final Map<String, IconData> _data = Map.fromIterables(
        ['SELECT AN OPTION', ChooseSign.hospital, ChooseSign.patient, ChooseSign.doctor],
        [Icons.filter_1, Icons.filter_2, Icons.filter_3, Icons.filter_4]);
    String _selectedType;
    IconData _selectedIcon;
    return SafeArea(
      child: Scaffold(
        backgroundColor: backgroundColor,
        body: _loading
            ? Center(child: CircularProgressIndicator())
            : Center(
                child: SingleChildScrollView(
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(10, 50, 10, 20),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            login_image,
                            height: height * 0.35,
                          ),
                          SizedBox(height: 20),
                          Container(
                            padding: EdgeInsets.all(10.0),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                  items: _data.keys.map((String val) {
                                    return DropdownMenuItem<String>(
                                      value: val,
                                      child: Row(
                                        children: <Widget>[
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 10.0),
                                            child: Icon(_data[val]),
                                          ),
                                          Text(val),
                                        ],
                                      ),
                                    );
                                  }).toList(),
                                  hint: Row(
                                    children: <Widget>[
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 12.0),
                                        child: Icon(_selectedIcon ??
                                            _data.values.toList()[0]),
                                      ),
                                      Text(_selectedType ??
                                          _data.keys.toList()[0]),
                                    ],
                                  ),
                                  onChanged: (String val) {
                                    setState(() {
                                      print(
                                          'objectobjectobjectobjectobjectobject');
                                      _selectedType = val;
                                      _selectedIcon = _data[val];
                                      if (val != 'SELECT AN OPTION')
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                SignUp(
                                              choice: _selectedType,
                                            ),
                                          ),
                                        ).then(
                                            (value) => Navigator.pop(context));
                                    });
                                  }),
                            ),
                          ),

                          // // login button
                          // GestureDetector(
                          //   onTap: () {
                          //     Navigator.push(
                          //       context,
                          //       MaterialPageRoute(
                          //         builder: (BuildContext context) => SignUp(
                          //           choice: _selectedType,
                          //         ),
                          //       ),
                          //     );
                          //   },
                          //   child: MyButton(
                          //     text: 'Next',
                          //     btnColor: primaryColor,
                          //     btnRadius: 8,
                          //   ),
                          // )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
