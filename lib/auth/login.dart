import 'package:FitAdvisor/auth/signup.dart';
import 'package:FitAdvisor/utils/colors.dart';
import 'package:FitAdvisor/utils/homepage.dart';
import 'package:FitAdvisor/utils/textstyles.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../utils/auth_method.dart';
import '../utils/button.dart';
import '../utils/responsive.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  final GlobalKey<FormState> key = GlobalKey<FormState>();
  bool _isObscure = true;

  navigateToHomePage() {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
        (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: CustomTextStyles.head("Log in to your account",
                      AppMediaQuery.Textfactor(context) * 22),
                ),
                SizedBox(
                  height: AppMediaQuery.ScreenHeight(context) / 20,
                ),
                Form(
                  key: key,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextFormField(
                          style: TextStyle(color: CustomColor.Whitetext()),
                          controller: emailcontroller,
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          decoration: InputDecoration(
                              filled: true,
                              fillColor: CustomColor.Greymain(),
                              hintText: 'Email address',
                              hintStyle:
                                  TextStyle(color: CustomColor.GreyText()),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: const BorderSide(
                                    style: BorderStyle.none,
                                    width: 0,
                                  ))),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return ("Please enter your email");
                            }
                            // reg expression for email validation
                            if (!RegExp(
                                    "^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                                .hasMatch(value)) {
                              return "Please enter correct mail";
                            }
                            return null;
                          },
                          onSaved: (value) {
                            emailcontroller.text = value!;
                          },
                        ),
                        SizedBox(
                          height: AppMediaQuery.ScreenHeight(context) / 40,
                        ),
                        TextFormField(
                          obscureText: _isObscure,
                          keyboardType: TextInputType.text,
                          style: TextStyle(color: CustomColor.Whitetext()),
                          textInputAction: TextInputAction.done,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          controller: passwordcontroller,
                          validator: (value) {
                            if (value!.length < 8) {
                              return "Please enter the password";
                            }
                            return null;
                          },
                          onSaved: (value) {
                            passwordcontroller.text = value!;
                          },
                          decoration: InputDecoration(
                            hintText: "Password",
                            hintStyle: TextStyle(color: CustomColor.GreyText()),
                            fillColor: CustomColor.Greymain(),
                            filled: true,
                            border: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    style: BorderStyle.none, width: 0),
                                borderRadius: BorderRadius.circular(15)),
                            suffixIcon: IconButton(
                              color: Colors.white,
                              icon: Icon(
                                _isObscure
                                    ? Icons.visibility_outlined
                                    : Icons.visibility_off_outlined,
                                color: CustomColor.Whitetext(),
                              ),
                              onPressed: () {
                                setState(() {
                                  _isObscure = !_isObscure;
                                });
                              },
                            ),
                          ),
                        )
                      ]),
                ),
                SizedBox(
                  height: AppMediaQuery.ScreenHeight(context) / 60,
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: CustomTextStyles.subtext("Forgot password?",
                      AppMediaQuery.Textfactor(context) * 14, null),
                ),
                SizedBox(
                  height: AppMediaQuery.ScreenHeight(context) / 30,
                ),
                CustomButton.button(
                    "Login", CustomColor.Whitetext(), CustomColor.Blackmain(),
                    () async {
                  if (key.currentState!.validate()) {
                    String res = await AuthMethods().loginUser(
                        email: emailcontroller.text.trim(),
                        password: passwordcontroller.text.trim());
                    if (res == "success") {
                      navigateToHomePage();
                    } else {
                      Fluttertoast.showToast(msg: "Some error occurred");
                    }
                  }
                }),
                SizedBox(
                  height: AppMediaQuery.ScreenHeight(context) / 60,
                ),
                CustomButton.button("Create an account",
                    CustomColor.Whitetext(), CustomColor.Blackmain(), () {
                  Navigator.push((context),
                      MaterialPageRoute(builder: (context) => const SignUp()));
                })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
