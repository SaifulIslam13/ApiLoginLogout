import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:homework/pages/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Login successful"),
          ElevatedButton(
              onPressed: () {
                showCupertinoDialog(
                    context: context,
                    builder: (context) => CupertinoAlertDialog(
                          content: Text(
                            "Clicking 'yes' you will be signed out from this page! ",
                            style: TextStyle(fontSize: 14),
                          ),
                          title: Text("Are you sure?"),
                          actions: [
                            CupertinoDialogAction(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text("No")),
                            CupertinoDialogAction(
                                onPressed: () async {
                                  SharedPreferences pref =
                                      await SharedPreferences.getInstance();
                                  await pref.clear();
                                  Navigator.of(context).pushAndRemoveUntil(
                                      MaterialPageRoute(
                                          builder: ((context) => LogInPage())),
                                      (route) => false);
                                },
                                child: Text(
                                  "Yes",
                                  style: TextStyle(color: Colors.red),
                                ))
                          ],
                        ));
              },
              child: Text("Log Out"))
        ],
      )),
    );
  }
}
