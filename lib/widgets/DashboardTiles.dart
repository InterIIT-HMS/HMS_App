import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:hospital_management_system/constants/colors.dart';
import 'package:hospital_management_system/screens/AddDoctors.dart';
import 'package:hospital_management_system/screens/Appointments.dart';
import 'package:hospital_management_system/screens/History.dart';
import 'package:hospital_management_system/screens/LabReports.dart';
import 'package:hospital_management_system/screens/LabTests.dart';
import 'package:hospital_management_system/screens/Prescriptions.dart';
import 'package:hospital_management_system/screens/choiceSign.dart';

class DashboardTiles extends StatefulWidget {
  final String username;
  final String userId;
  final dynamic userInfo;
  const DashboardTiles({Key key, this.username, this.userId, this.userInfo})
      : super(key: key);

  @override
  _DashboardTilesState createState() => _DashboardTilesState();
}

class _DashboardTilesState extends State<DashboardTiles> {
  double width;
  double height;
  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Column(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [
                    Colors.purple,
                    Colors.pinkAccent,
                  ],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  tileMode: TileMode.clamp),
              borderRadius: BorderRadius.circular(10)),
          padding: const EdgeInsets.all(8),
          margin: const EdgeInsets.all(10),
          width: width,
          height: 150,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Welcome ${widget.username},',
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: Colors.white),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Have a nice day!',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Colors.white),
                  ),
                  Icon(Icons.tag_faces, color: Colors.white)
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: 25),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: GridView(
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => Appointments(
                                userId: widget.userId,
                                userInfo: widget.userInfo)));
                  },
                  child: Card(
                    margin: const EdgeInsets.all(10),
                    color: cardColor,
                    elevation: 5.0,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Icon(FlutterIcons.calendar_account_mco,
                              size: 50, color: primaryColor),
                          Text(
                            'Appointments',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => LabReports(userId: widget.userId)));
                  },
                  child: Card(
                    margin: const EdgeInsets.all(10),
                    color: cardColor,
                    elevation: 5.0,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Icon(FlutterIcons.test_tube_mco,
                              size: 50, color: primaryColor),
                          Text(
                            'Reports',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) =>
                                Prescriptions(userId: widget.userId)));
                  },
                  child: Card(
                    margin: const EdgeInsets.all(10),
                    color: cardColor,
                    elevation: 5.0,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Icon(FlutterIcons.medical_bag_mco,
                              size: 50, color: primaryColor),
                          Text(
                            'Prescriptions',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                if (widget.userInfo['given_name'] == ChooseSign.hospital)
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) =>
                                  ListOfDoctors(userId: widget.userId)));
                    },
                    child: Card(
                      margin: const EdgeInsets.all(10),
                      color: cardColor,
                      elevation: 5.0,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Icon(FlutterIcons.file_document_mco,
                                size: 50, color: primaryColor),
                            Text(
                              'Add Doctors',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w500),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                if (widget.userInfo['given_name'] == 'Doctor')
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) =>
                                  LabReports(userId: widget.userId)));
                    },
                    child: Card(
                      margin: const EdgeInsets.all(10),
                      color: cardColor,
                      elevation: 5.0,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Icon(FlutterIcons.file_document_mco,
                                size: 50, color: primaryColor),
                            Text(
                              'Join Hospital',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w500),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
