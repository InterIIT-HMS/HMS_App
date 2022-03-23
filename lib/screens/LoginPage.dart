import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hospital_management_system/constants/colors.dart';
import 'package:hospital_management_system/constants/images.dart';
import 'package:hospital_management_system/screens/Dashboard.dart';

import 'package:hospital_management_system/screens/SignUp.dart';
import 'package:hospital_management_system/screens/choiceSign.dart';

import 'package:hospital_management_system/widgets/MyButton.dart';
import 'package:hospital_management_system/widgets/MyTextField.dart';
import 'package:flutter_auth0/flutter_auth0.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  double width;
  double height;
  bool visible = false;
  bool _loading = false;

  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  static const AUTH0_DOMAIN = 'dev-rgmfg73e.us.auth0.com';
  static const AUTH0_CLIENT_ID = 'vRpJtT9x6QAqaZEVoSVhoLcadk3ChjDE';

  static const AUTH0_REDIRECT_URI = 'com.auth0.flutterdemo://login-callback';
  static const AUTH0_ISSUER = 'https://$AUTH0_DOMAIN';
  bool isBusy = false;
  bool isLoggedIn = false;
  String errorMessage;

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Auth0 auth;

  @override
  void initState() {
    super.initState();
    auth = Auth0(baseUrl: 'https://$AUTH0_DOMAIN/', clientId: AUTH0_CLIENT_ID);
  }

  login({String email, String password}) async {
    try {
      setState(() {
        isBusy = true;
      });
      dynamic data = await auth.auth.passwordRealm({
        'username': email,
        'password': password,
        'realm': 'Username-Password-Authentication'
      });
      print('aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa');
      print(data['access_token']);
      setState(() {
        isBusy = false;
      });
      Fluttertoast.showToast(
          msg: "Login successful",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => Dashboard(
            name: data['access_token'].toString(),
            id_token: data['id_token'].toString(),
          ),
        ),
        (Route<dynamic> route) => false,
      );
    } catch (e) {
      setState(() {
        isBusy = false;
      });
      print(e);
      Fluttertoast.showToast(
        msg: e.toString(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        backgroundColor: backgroundColor,
        body: _loading
            ? Center(child: CircularProgressIndicator())
            : Center(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'LOGIN',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 28),
                          ),
                          SvgPicture.asset(
                            login_image,
                            height: height * 0.35,
                          ),
                          SizedBox(height: 20),

                          // username
                          MyTextField(
                            controller: _usernameController,
                            hint: "Username",
                            icon: Icons.person,
                            validation: (val) {
                              if (val.isEmpty) {
                                return "Username is required";
                              }
                              return null;
                            },
                          ),

                          // password
                          MyTextField(
                            controller: _passwordController,
                            hint: "Password",
                            isPassword: true,
                            isSecure: true,
                            icon: Icons.lock,
                            validation: (val) {
                              if (val.isEmpty) {
                                return "Password is required";
                              }
                              return null;
                            },
                          ),

                          !isBusy
                              ? GestureDetector(
                                  onTap: () async {
                                    // loginAction();
                                    print('aaaaaaaaaaaaa');
                                    await login(
                                      email: _usernameController.text,
                                      password: _passwordController.text,
                                    );
                                  },
                                  child: MyButton(
                                    text: 'Log in',
                                    btnColor: primaryColor,
                                    btnRadius: 8,
                                  ),
                                )
                              : CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.white),
                                ),

                          // link to sign up page
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Don\'t have an account?',
                                style: TextStyle(
                                    color: primaryColor, fontSize: 16),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              ChooseSign()));
                                },
                                child: Text(
                                  'Sign up',
                                  style: TextStyle(
                                      color: primaryColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                              ),
                            ],
                          )
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
