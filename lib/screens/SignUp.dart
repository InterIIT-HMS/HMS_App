import 'package:flutter/material.dart';
import 'package:flutter_auth0/flutter_auth0.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hospital_management_system/constants/colors.dart';
import 'package:hospital_management_system/constants/images.dart';
import 'package:hospital_management_system/screens/LoginPage.dart';
import 'package:hospital_management_system/widgets/MyButton.dart';
import 'package:hospital_management_system/widgets/MyTextField.dart';

class SignUp extends StatefulWidget {
  String choice;
  SignUp({this.choice});
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  double width;
  double height;
  bool visible = false;
  bool _loading = false;
  static const AUTH0_DOMAIN = 'dev-rgmfg73e.us.auth0.com';
  static const AUTH0_CLIENT_ID = 'vRpJtT9x6QAqaZEVoSVhoLcadk3ChjDE';

  static const AUTH0_REDIRECT_URI = 'com.auth0.flutterdemo://login-callback';
  static const AUTH0_ISSUER = 'https://$AUTH0_DOMAIN';
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

  String validateEmail(String value) {
    String pattern =
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
    RegExp regExp = new RegExp(pattern);

    if (value.isEmpty) {
      return 'Email address is required';
    } else if (!regExp.hasMatch(value)) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  String validateMobile(String value) {
    String pattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
    RegExp regExp = new RegExp(pattern);

    if (value.length == 0) {
      return 'Mobile number is required';
    } else if (!regExp.hasMatch(value)) {
      return 'Please enter a valid mobile number';
    }
    return null;
  }

  Auth0 auth;

  @override
  void initState() {
    super.initState();
    _roleController.text = widget.choice;
    auth = Auth0(baseUrl: 'https://$AUTH0_DOMAIN/', clientId: AUTH0_CLIENT_ID);
    _roleController.text = 'None';
  }

  signup(
      {String email,
      String password,
      String role,
      String name,
      String contact,
      String address,
      String uid}) async {
    print('signup');
    try {
      setState(() {
        isBusy = true;
      });
      await auth.auth.createUser({
        'email': email,
        'password': password,
        'connection': 'Username-Password-Authentication',
        'given_name': role,
        'family_name': uid.toString(),
        'nickname': address,
      });
      setState(() {
        isBusy = false;
      });

      print('signup success');
      Fluttertoast.showToast(
          msg: "Successfully registered",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      Future.delayed(Duration(seconds: 2), () {
        Navigator.pop(context);
      });
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
          fontSize: 16.0);
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
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(10, 50, 10, 20),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'REGISTER',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 28),
                          ),
                          SvgPicture.asset(
                            signup_image,
                            height: width * 0.50,
                          ),
                          SizedBox(height: 10),

                          // full name
                          MyTextField(
                            controller: _nameController,
                            hint: "Name",
                            icon: FlutterIcons.account_card_details_mco,
                            validation: (val) {
                              if (val.isEmpty) {
                                return "Name is required";
                              }
                              return null;
                            },
                          ),
                          MyTextField(
                            controller: _uidController,
                            hint: widget.choice == 'Hospital' ||
                                    widget.choice == 'Doctor'
                                ? "Registration number"
                                : "Health ID",
                            icon: FlutterIcons.account_card_details_mco,
                            validation: (val) {
                              if (val.isEmpty) {
                                return "Name is required";
                              }
                            },
                          ),

                          // // username
                          // MyTextField(
                          //   controller: _usernameController,
                          //   hint: "Username",
                          //   icon: FlutterIcons.account_badge_horizontal_mco,
                          //   validation: (val) {
                          //     if (val.isEmpty) {
                          //       return "Username is required";
                          //     }
                          //     return null;
                          //   },
                          // ),

                          // email
                          MyTextField(
                            controller: _emailController,
                            hint: "Email",
                            isEmail: true,
                            icon: Icons.contact_mail,
                            validation: (val) {
                              return validateEmail(val);
                            },
                          ),

                          // contact
                          MyTextField(
                            controller: _contactController,
                            hint: "Contact",
                            isNumber: true,
                            maxLength: 10,
                            icon: Icons.contact_phone,
                            validation: (val) {
                              return validateMobile(val);
                            },
                          ),

                          // address
                          MyTextField(
                            controller: _addressController,
                            hint:
                                widget.choice != "Patient" ? "Address" : "Age",
                            isMultiline: true,
                            maxLines: widget.choice != "Patient" ? 3 : 1,
                            icon: widget.choice != "Patient"
                                ? FlutterIcons.location_city_mdi
                                : Icons.person,
                            validation: (val) {
                              if (val.isEmpty) {
                                return "Address is required";
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
                            icon: FlutterIcons.account_key_mco,
                            validation: (val) {
                              if (val.isEmpty) {
                                return "Password is required";
                              }
                              return null;
                            },
                          ),

                          // login button
                          !isBusy
                              ? GestureDetector(
                                  onTap: () {
                                    signup(
                                        email: _emailController.text,
                                        password: _passwordController.text,
                                        role: _roleController.text,
                                        name: _nameController.text,
                                        contact: _contactController.text,
                                        address: _addressController.text,
                                        uid: _uidController.text);
                                  },
                                  child: MyButton(
                                    text: 'SIGNUP',
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
                                'Already have an account?',
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
                                          builder: (_) => LoginPage()));
                                },
                                child: Text(
                                  'Log in',
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
