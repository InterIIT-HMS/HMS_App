import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hospital_management_system/constants/colors.dart';
import 'package:hospital_management_system/screens/choiceSign.dart';
import 'package:hospital_management_system/widgets/MyTextField.dart';
import 'package:http/http.dart' as http;
import 'package:hospital_management_system/services/NetworkHelper.dart';

class LabReports extends StatefulWidget {
  final String userId;
  final dynamic userInfo;
  LabReports({this.userId, this.userInfo});

  @override
  _LabReportsState createState() => _LabReportsState();
}

class _LabReportsState extends State<LabReports> {
  bool _loading = false;
  List _completedLabTests = [
    {
      'test_id': 'lab1_id_02',
      'test_status': 'pending',
      'details': 'Prescriptions may be entered into an electronic medical',
      'date': '12/12/12',
      'file_location': 'http://www.gputtawar.edu.in/downloads/Prescriptions.pdf'
    },
    {
      'test_id': 'lab2_id_02',
      'test_status': 'pending',
      'details': 'Drug equivalence and non-substitution',
      'date': '12/12/12',
      'file_location': 'http://www.gputtawar.edu.in/downloads/Prescriptions.pdf'
    },
    {
      'test_id': 'lab3_id_02',
      'test_status': 'pending',
      'details': 'Label and instructions',
      'date': '12/12/12',
      'file_location': 'http://www.gputtawar.edu.in/downloads/Prescriptions.pdf'
    },
    {
      'test_id': 'lab4_id_02',
      'test_status': 'pending',
      'details': 'Prescriptions for children',
      'date': '12/12/12',
      'file_location': 'http://www.gputtawar.edu.in/downloads/Prescriptions.pdf'
    }
  ];
  double width;
  double height;

  // for real device
  final String pdfBaseUrl = 'http://0.0.0.0:8001/lab-reports';

  // for emulator
  // final String pdfBaseUrl = 'http://10.0.2.2:8001/lab-reports';

  @override
  void initState() {
    // _getLabTests();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: backgroundColor,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Visibility(
        visible: widget.userInfo['given_name'] == ChooseSign.doctor,
        child: FloatingActionButton.extended(
          label: Text('Add Report'),
          onPressed: () {
            _addNewReportsDialog(context);
          },
          icon: Icon(FlutterIcons.exit_run_mco),
        ),
      ),
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text('Lab Reports'),
      ),
      body: _loading
          ? Center(child: CircularProgressIndicator())
          : Container(
              height: height,
              child: _completedLabTests.length > 0
                  ? SingleChildScrollView(
                      child: RefreshIndicator(
                        onRefresh: () async {
                          // _getLabTests();
                        },
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 10),
                          height: height * 0.85,
                          width: double.infinity,
                          child: ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              itemCount: _completedLabTests.length,
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
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          RichText(
                                            text: TextSpan(
                                                text: 'Lab Test ID: ',
                                                style:
                                                    DefaultTextStyle.of(context)
                                                        .style,
                                                children: [
                                                  TextSpan(
                                                    text: _completedLabTests[
                                                            index]['test_id']
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
                                      Row(
                                        children: [
                                          Container(
                                            width: width - 80,
                                            height: 50,
                                            child: Text(
                                              _completedLabTests[index]
                                                  ['details'],
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 3,
                                            ),
                                          )
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            'Appointment: ',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500),
                                          ),
                                          _completedLabTests[index]['date'] ==
                                                  null
                                              ? Text(
                                                  'N/A',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w400),
                                                )
                                              : Text(
                                                  _completedLabTests[index]
                                                      ['date'],
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w400),
                                                ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Lab Report',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500),
                                          ),
                                          GestureDetector(
                                            onTap: () async {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        PdfViewPage(
                                                      location:
                                                          _completedLabTests[
                                                                  index]
                                                              ['file_location'],
                                                    ),
                                                  ));
                                            },
                                            child: Icon(
                                              Icons.remove_red_eye,
                                              color: primaryColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                );
                              }),
                        ),
                      ),
                    )
                  : Center(
                      child: Text('No completed lab reports found!'),
                    ),
            ),
    );
  }

  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _emailController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey();
  // adding new appointment dialog
  Future<Widget> _addNewReportsDialog(context) {
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
                    child: Text('New Reports',
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
                            hint: 'Link To Report',
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
                                Fluttertoast.showToast(
                                    msg: "Lab Report under Review.",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.CENTER,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.red,
                                    textColor: Colors.white,
                                    fontSize: 16.0);
                                Navigator.pop(context);
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

class PdfViewPage extends StatefulWidget {
  final String location;

  const PdfViewPage({Key key, this.location}) : super(key: key);
  @override
  _PdfViewPageState createState() => _PdfViewPageState();
}

class _PdfViewPageState extends State<PdfViewPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Lab Report'),
        ),
        body: const PDF(
                autoSpacing: true,
                enableSwipe: true,
                pageSnap: true,
                swipeHorizontal: true)
            .fromUrl(
          widget.location,
          // 'https://www.researchgate.net/profile/Mustafa_Saad7/publication/321318899_Automatic_Street_Light_Control_System_Using_Microcontroller/links/5c0e6a374585157ac1b74569/Automatic-Street-Light-Control-System-Using-Microcontroller.pdf',
          placeholder: (double progress) => Center(
            child: CircularProgressIndicator(
              value: progress,
            ),
          ),
          errorWidget: (dynamic error) => Center(child: Text(error.toString())),
        ));
  }
}
