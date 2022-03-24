import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hospital_management_system/constants/colors.dart';
import 'package:hospital_management_system/screens/choiceSign.dart';
import 'package:hospital_management_system/widgets/MyTextField.dart';
import 'package:http/http.dart' as http;
import 'package:hospital_management_system/services/NetworkHelper.dart';

class Prescriptions extends StatefulWidget {
  final String userId;
  final dynamic userInfo;
  Prescriptions({this.userId, this.userInfo});

  @override
  _PrescriptionsState createState() => _PrescriptionsState();
}

class _PrescriptionsState extends State<Prescriptions> {
  bool _loading = false;
  List _prescriptions = [
    {
      'prescription_id': 'lab1',
      'prescription_status': 'pending',
      'prescription': 'khyal rakho',
      'prescription_location': 'mumbai'
    },
    {
      'prescription_id': 'lab2',
      'prescription_status': 'pending',
      'prescription': 'khyal rakho',
      'prescription_location': 'mumbai'
    },
  ];
  double width;
  double height;
  String dropdownValue = 'Mark as Received';

  @override
  void initState() {
    // _getPrescriptions();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

// get the prescriptions list

  // marking a prescription as received
  Future<http.Response> _markAsReceived(prescriptionId) async {
    setState(() {
      _loading = true;
    });

    final http.Response response = await Network().postData({
      'prescription_id': prescriptionId.toString(),
    }, '/markAsReceived.php');

    print('response ---- ${jsonDecode(response.body)}');

    setState(() {
      _loading = false;
    });

    return response;
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: backgroundColor,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text('Prescriptions'),
      ),
      floatingActionButton: Visibility(
        visible: widget.userInfo['given_name'] == ChooseSign.doctor,
        child: FloatingActionButton.extended(
          label: Text('Add Precription'),
          onPressed: () {
            _addNewPrescriptionsDialog(context);
          },
          icon: Icon(FlutterIcons.exit_run_mco),
        ),
      ),
      body: _loading
          ? Center(child: CircularProgressIndicator())
          : Container(
              height: height,
              child: _prescriptions.length > 0
                  ? SingleChildScrollView(
                      child: RefreshIndicator(
                        onRefresh: () async {
                          // _getPrescriptions();
                        },
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 10),
                          height: height * 0.85,
                          width: double.infinity,
                          child: ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              itemCount: _prescriptions.length,
                              itemBuilder: (context, index) {
                                return Container(
                                  padding:
                                      const EdgeInsets.fromLTRB(20, 10, 20, 6),
                                  margin:
                                      const EdgeInsets.fromLTRB(20, 10, 20, 10),
                                  width: width,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: colorWhite,
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.grey.withOpacity(0.5),
                                          spreadRadius: 5,
                                          blurRadius: 7,
                                          offset: Offset(0, 3)),
                                    ],
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          RichText(
                                            text: TextSpan(
                                                text: 'Prescription ID: ',
                                                style:
                                                    DefaultTextStyle.of(context)
                                                        .style,
                                                children: [
                                                  TextSpan(
                                                    text: _prescriptions[index]
                                                            ['prescription_id']
                                                        .toString(),
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                ]),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 5),
                                      Text(
                                        'Prescription:',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15),
                                      ),
                                      Container(
                                        width: width - 80,
                                        height: 55,
                                        child: Text(
                                          _prescriptions[index]['prescription']
                                              .toString(),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 3,
                                          textAlign: TextAlign.justify,
                                        ),
                                      ),
                                      SizedBox(height: 5),
                                      Text(
                                        'Location:',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15),
                                      ),
                                      Container(
                                        width: width - 80,
                                        height: 40,
                                        child: Text(
                                          _prescriptions[index]
                                              ['prescription_location'],
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 3,
                                          textAlign: TextAlign.justify,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }),
                        ),
                      ),
                    )
                  : Center(
                      child: Text('No prescriptions found!'),
                    ),
            ),
    );
  }
  TextEditingController _emailController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey();
  // adding new appointment dialog
  Future<Widget> _addNewPrescriptionsDialog(context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            backgroundColor: Colors.transparent,
            child: Container(
              decoration: BoxDecoration(
                color: backgroundColor,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(16),
              ),
              width: double.infinity,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: primaryColor,
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(16.0),
                        topRight: Radius.circular(16.0),
                      ),
                    ),
                    height: 70,
                    width: double.infinity,
                    alignment: Alignment.center,
                    child: Text('New Appointment',
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 18,
                            color: colorWhite),
                        textAlign: TextAlign.center),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          MyTextField(
                            hint: 'Email of Patient',
                            icon: MaterialCommunityIcons.note_text,
                            isMultiline: true,
                            maxLines: 1,
                            controller: _emailController,
                            validation: (val) {
                              if (val.isEmpty) {
                                return 'An Email is required';
                              }
                              return null;
                            },
                          ),
                          MyTextField(
                            hint: 'Link To Prescription',
                            icon: MaterialCommunityIcons.note_text,
                            isMultiline: true,
                            maxLines: 1,
                            controller: _descriptionController,
                            validation: (val) {
                              if (val.isEmpty) {
                                return 'A description is required';
                              }
                              return null;
                            },
                          ),
                          GestureDetector(
                            onTap: () {
                              if (_formKey.currentState.validate()) {
                                // prescription post
                              }
                            },
                            child: Container(
                              alignment: Alignment.center,
                              height: 30.0,
                              width: double.infinity,
                              child: Text(
                                'SAVE',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                ],
              ),
            ),
          );
        });
  }
}
