import 'package:FitAdvisor/utils/button.dart';
import 'package:FitAdvisor/utils/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../utils/responsive.dart';
import '../utils/textstyles.dart';

class EmailVerification extends StatefulWidget {
  const EmailVerification({super.key});

  @override
  State<EmailVerification> createState() => _EmailVerificationState();
}

class _EmailVerificationState extends State<EmailVerification> {
  bool v = false;
  Future<void> emailverify() async {
    FirebaseAuth.instance.currentUser!.sendEmailVerification();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: AppMediaQuery.ScreenWidth(context) / 20,
            vertical: AppMediaQuery.ScreenHeight(context) / 10),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  CustomTextStyles.head("Email Verification",
                      AppMediaQuery.Textfactor(context) * 28),
                  CustomTextStyles.subtext(
                      "To verify your account, please click the\nverification link sent to your email address.",
                      AppMediaQuery.Textfactor(context) * 14,
                      TextAlign.center)
                ],
              ),
              Image.asset("assets/email1.gif"),
              CustomButton.button(
                  "Send Link", CustomColor.Whitetext(), CustomColor.Blackmain(),
                  () {
                emailverify();
                Fluttertoast.showToast(msg: "Sent Successfully!");
                //Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const OnboardingPage()));
              })
            ],
          ),
        ),
      ),
    ));
  }
}
