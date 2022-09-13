import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:homework/pages/main_page.dart';
import 'package:homework/services/custom_api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LogInPage extends StatefulWidget {
  const LogInPage({Key? key}) : super(key: key);

  @override
  State<LogInPage> createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  bool isLoading = false;
  bool isObsecure = true;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  @override
  void initState() {
    isLogin();
    super.initState();
  }

  isLogin() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.getString("token") != null) {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => MainPage()));
    }
  }

  getLogin() async {
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      setState(() {
        isLoading = true;
      });
      final result = await CustomHttp.login(
          _emailController.text, _passwordController.text);
      setState(() {
        isLoading = false;
      });
      final data = jsonDecode(result);
      if (data["access_token"] != null) {
        setState(() {
          sharedPreferences.setString("token", data["access_token"]);
          sharedPreferences.setString("email", _emailController.text);
          print("my token save${sharedPreferences.getString("token")}");
        });
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => MainPage()));
      }
    } catch (e) {
      print("$e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      //background image
      Image.asset(
        "images/image1.jpg",
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        fit: BoxFit.cover,
      ),
      Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
            child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //Icon
                Icon(
                  Icons.android,
                  size: 100,
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'SIGN IN HERE',
                  style: GoogleFonts.aladin(
                      fontSize: 45,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 3),
                ),
                SizedBox(
                  height: 50,
                ),
                //textfield for email
                TextFormField(
                  controller: _emailController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter email';
                    }
                  },
                  decoration: InputDecoration(
                      hintText: 'Email',
                      fillColor: Colors.grey.withOpacity(0.4),
                      filled: true,
                      labelText: 'Email',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20))),
                ),
                SizedBox(
                  height: 20,
                ),
                //textfield for password
                TextFormField(
                  controller: _passwordController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter password';
                    }
                  },
                  obscureText: isObsecure,
                  decoration: InputDecoration(
                      suffixIcon: IconButton(
                        icon: isObsecure == false
                            ? Icon(
                                Icons.visibility,
                                color: Colors.white,
                              )
                            : Icon(
                                Icons.visibility_off,
                                color: Colors.grey.shade700,
                              ),
                        onPressed: () {
                          setState(() {
                            isObsecure = !isObsecure;
                          });
                        },
                      ),
                      hintText: 'Password',
                      fillColor: Colors.grey.withOpacity(0.4),
                      filled: true,
                      labelText: 'Password',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20))),
                ),
                SizedBox(
                  height: 20,
                ),
                //login button
                GestureDetector(
                  onTap: () {
                    getLogin();
                  },
                  child: Container(
                    height: 50,
                    width: 150,
                    decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(15)),
                    child: Center(
                      child: Text(
                        'SIGN IN',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 2),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                //signup button
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Don't heve an account?",
                          style: TextStyle(
                            color: Colors.pink,
                            fontSize: 14,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: Text(
                            'Sign Up',
                            style: TextStyle(
                                color: Colors.blue,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 2),
                          ),
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Text(
                        'Forgot Password',
                        style: TextStyle(
                          color: Colors.pink,
                          fontSize: 16,
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        )),
      )
    ]);
  }
}
