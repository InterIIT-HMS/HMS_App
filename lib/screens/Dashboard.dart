import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:auth0/auth0.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:hospital_management_system/constants/colors.dart';
import 'package:hospital_management_system/screens/LoginPage.dart';
import 'package:hospital_management_system/widgets/DashboardTiles.dart';
import 'package:http/http.dart' as http;

enum Page { dashboard, manage }

class Dashboard extends StatefulWidget {
  final String user_token;
  final String id_token;

  Dashboard({this.user_token, this.id_token});
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  Page _selectedPage = Page.dashboard;
  double width;
  double height;
  bool content = false;
  var parsedJson;
  static const AUTH0_DOMAIN = 'dev-rgmfg73e.us.auth0.com';
  static const AUTH0_CLIENT_ID = 'vRpJtT9x6QAqaZEVoSVhoLcadk3ChjDE';

  static const AUTH0_REDIRECT_URI = 'com.auth0.flutterdemo://login-callback';
  static const AUTH0_ISSUER = 'https://$AUTH0_DOMAIN';
  Auth0Client client;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('here');
    print(widget.user_token);
    print(widget.id_token);
    client = Auth0Client(
      clientId: AUTH0_CLIENT_ID,
      clientSecret:
          "SB16I3lCO78cb9JWn1io4hkqkAQk_A5IT7vff9Vwd-Z2voUCV-KirWbc2m8ckqeZ",
      domain: AUTH0_DOMAIN,
      connectTimeout: 10000,
      sendTimeout: 10000,
      receiveTimeout: 60000,
      useLoggerInterceptor: true,
      accessToken: widget.user_token,
    );
    getInfo();
  }

  Future<void> getInfo() async {
    final response =
        await http.get('https://dev-rgmfg73e.us.auth0.com/userinfo', headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${widget.user_token}',
    });
    print('Token :${widget.user_token}');
    print(response.body);
    parsedJson = jsonDecode(response.body);
    print(parsedJson);
    setState(() {
      content = true;
    });
    print('aaaaaaaaaaaaaaaaaaaa');
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton.extended(
          label: Text('Log Out'),
          onPressed: () {
            client.logout();
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) => LoginPage(),
              ),
              (Route<dynamic> route) => false,
            );
          },
          icon: Icon(FlutterIcons.exit_run_mco),
        ),
        body: _loadScreen(_selectedPage),
        backgroundColor: backgroundColor,
      ),
    );
  }

  Widget _loadScreen(page) {
    switch (_selectedPage) {
      case Page.dashboard:
        return content
            ? DashboardTiles(
                user_token: widget.user_token,
                userId: parsedJson['email'],
                userInfo: parsedJson,
              )
            : Center(child: CircularProgressIndicator());
        break;
      case Page.manage:
        return Container();
        break;
      default:
        return Container();
    }
  }
}
