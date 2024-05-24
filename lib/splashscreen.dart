import 'dart:async';

import 'package:FitAdvisor/utils/colors.dart';
import 'package:FitAdvisor/utils/responsive.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'auth/login.dart';

class splashscreen extends StatefulWidget {
  const splashscreen({super.key});

  @override
  State<splashscreen> createState() => _splashscreenState();
}

class _splashscreenState extends State<splashscreen> {
  User? user = FirebaseAuth.instance.currentUser;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => LoginPage()));
      // user!=null?Navigator.pushReplacement(
      //     context, MaterialPageRoute(builder: (context) => const HomeScreen())):Navigator.pushReplacement(
      //     context, MaterialPageRoute(builder: (context) => const LoginPage()));
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/login.png",
              height: AppMediaQuery.ScreenHeight(context) / 2,
              width: AppMediaQuery.ScreenWidth(context) / 2,
            ),
            Text(
              "FitAdvisor",
              style: GoogleFonts.manrope(
                  fontWeight: FontWeight.bold,
                  fontSize: 50,
                  color: CustomColor.Whitetext()),
            ),
          ],
        ),
      ),
    );
  }
}
