import 'package:FitAdvisor/utils/pose_detector_view.dart';
import 'package:FitAdvisor/utils/responsive.dart';
import 'package:FitAdvisor/utils/textstyles.dart';
import 'package:flutter/material.dart';

import 'button.dart';
import 'colors.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomTextStyles.head(
                  "Click here to Scan", AppMediaQuery.Textfactor(context) * 30),
              Image.asset(
                "assets/scan.png",
              ),
              CustomButton.button("Start Scan", CustomColor.Whitetext(),
                  CustomColor.Blackmain(), () {
                Navigator.push(
                    (context),
                    MaterialPageRoute(
                        builder: (context) => const PoseDetectorView()));
              })
            ],
          ),
        ),
      ),
    ));
  }
}
