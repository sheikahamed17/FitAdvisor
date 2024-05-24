import 'package:FitAdvisor/utils/colors.dart';
import 'package:FitAdvisor/utils/textstyles.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../utils/auth_method.dart';
import '../utils/button.dart';
import '../utils/responsive.dart';
import 'infopage.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final GlobalKey<FormState> key2 = GlobalKey<FormState>();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController namecontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  TextEditingController cpasswordcontroller = TextEditingController();
  bool _isObscure = true;
  bool _isObscureConfirm = true;

  navigateToInfoScreen() {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => const Infopage(),
        ),
        (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
            backgroundColor: const Color(0XFF171717),
            leading: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
            )),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: <Widget>[
                Center(
                  child: CustomTextStyles.head("Create your account",
                      AppMediaQuery.Textfactor(context) * 22),
                ),
                SizedBox(
                  height: AppMediaQuery.ScreenHeight(context) / 40,
                ),
                Form(
                  key: key2,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextFormField(
                          style: TextStyle(color: CustomColor.Whitetext()),
                          keyboardType: TextInputType.name,
                          textInputAction: TextInputAction.next,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          controller: namecontroller,
                          decoration: InputDecoration(
                              filled: true,
                              fillColor: CustomColor.Greymain(),
                              hintText: 'Name',
                              hintStyle:
                                  TextStyle(color: CustomColor.Whitetext()),
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
                          },
                          onSaved: (value) {
                            emailcontroller.text = value!;
                          },
                        ),
                        SizedBox(
                          height: AppMediaQuery.ScreenHeight(context) / 60,
                        ),
                        TextFormField(
                          controller: emailcontroller,
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          style: TextStyle(color: CustomColor.Whitetext()),
                          decoration: InputDecoration(
                              filled: true,
                              fillColor: CustomColor.Greymain(),
                              hintText: 'Email address',
                              hintStyle:
                                  TextStyle(color: CustomColor.Whitetext()),
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
                              return ("Please enter a valid email");
                            }
                            return null;
                          },
                          onSaved: (value) {
                            emailcontroller.text = value!;
                          },
                        ),
                        SizedBox(
                          height: AppMediaQuery.ScreenHeight(context) / 60,
                        ),
                        TextFormField(
                          controller: passwordcontroller,
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.next,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          style: TextStyle(color: CustomColor.Whitetext()),
                          obscureText: _isObscure,
                          validator: (value) {
                            if (value!.length < 8) {
                              return " Invaild Password";
                            }
                          },
                          onSaved: (value) {
                            passwordcontroller.text = value!;
                          },
                          decoration: InputDecoration(
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
                              hintText: "Password",
                              hintStyle:
                                  TextStyle(color: CustomColor.Whitetext()),
                              fillColor: CustomColor.Greymain(),
                              filled: true,
                              border: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      style: BorderStyle.none, width: 0),
                                  borderRadius: BorderRadius.circular(15))),
                        ),
                        SizedBox(
                          height: AppMediaQuery.ScreenHeight(context) / 60,
                        ),
                        TextFormField(
                          controller: cpasswordcontroller,
                          obscureText: _isObscureConfirm,
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.done,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          style: TextStyle(color: CustomColor.Whitetext()),
                          validator: (value) {
                            if (value!.length < 8) {
                              return " Invaild Password";
                            }
                            if (value.toString() !=
                                passwordcontroller.text.trim()) {
                              return "Password does not match";
                            }
                          },
                          onSaved: (value) {
                            passwordcontroller.text = value!;
                          },
                          decoration: InputDecoration(
                              suffixIcon: IconButton(
                                color: Colors.white,
                                icon: Icon(
                                  _isObscureConfirm
                                      ? Icons.visibility_outlined
                                      : Icons.visibility_off_outlined,
                                  color: CustomColor.Whitetext(),
                                ),
                                onPressed: () {
                                  setState(() {
                                    _isObscureConfirm = !_isObscureConfirm;
                                  });
                                },
                              ),
                              hintText: "Confirm Password",
                              hintStyle:
                                  TextStyle(color: CustomColor.Whitetext()),
                              fillColor: CustomColor.Greymain(),
                              filled: true,
                              border: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      style: BorderStyle.none, width: 0),
                                  borderRadius: BorderRadius.circular(15))),
                        ),
                      ]),
                ),
                SizedBox(
                  height: AppMediaQuery.ScreenHeight(context) / 40,
                ),
                CustomButton.button(
                    "Sign up", CustomColor.Whitetext(), CustomColor.Blackmain(),
                    () async {
                  if (key2.currentState!.validate()) {
                    String res = await AuthMethods().signUpUser(
                        email: emailcontroller.text.trim(),
                        password: passwordcontroller.text.trim(),
                        name: namecontroller.text.trim());
                    if (res == "success") {
                      navigateToInfoScreen();
                    } else {
                      Fluttertoast.showToast(msg: "Some error occurred");
                    }
                  }
                })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
