import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:homework/pages/login_page.dart';
import 'package:slide_to_act/slide_to_act.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          "images/image2.jpg",
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.cover,
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                    flex: 5,
                    child: Container(
                      padding: EdgeInsets.only(bottom: 150, left: 100),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Center(
                            child: Text('Welcome To\nMYSITE ...',
                                style: GoogleFonts.aladin(
                                    letterSpacing: 3,
                                    color: Colors.white,
                                    fontSize: 40)),
                          ),
                        ],
                      ),
                    )),
                Expanded(
                    flex: 5,
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: SlideAction(
                        onSubmit: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => LogInPage()));
                        },
                        outerColor: Colors.white,
                        innerColor: Color.fromARGB(255, 209, 144, 79),
                        elevation: 5,
                        text: 'Swipe to GO ...',
                        textStyle: GoogleFonts.abhayaLibre(
                            color: Color.fromARGB(255, 219, 144, 68),
                            letterSpacing: 3,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                        borderRadius: 20,
                        sliderRotate: false,
                      ),
                    ))
              ],
            ),
          ),
        )
      ],
    );
  }
}
