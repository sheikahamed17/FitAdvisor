import "package:FitAdvisor/utils/button.dart";
import 'package:FitAdvisor/utils/colors.dart';
import "package:FitAdvisor/utils/responsive.dart";
import "package:flutter/material.dart";
import "package:fluttertoast/fluttertoast.dart";
import "package:image_picker/image_picker.dart";

class ScanPage extends StatefulWidget {
  const ScanPage({super.key});

  @override
  State<ScanPage> createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  String recognizedText = "";

  Future getImage(ImageSource source) async {
    final pickedImage = await ImagePicker().pickImage(source: source);
    if (pickedImage != null) {
      //final recognized = await ocr().recognizeText(pickedImage.path);
      setState(() {
        //recognizedText = recognized;
      });

      Fluttertoast.showToast(msg: "Image uploaded");
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back,
            ),
          ),
          centerTitle: true,
          title: Text(
            "Scan a product label",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: <Widget>[
              SizedBox(
                height: AppMediaQuery.ScreenHeight(context) / 20,
              ),
              Center(
                child: SizedBox(
                    height: AppMediaQuery.ScreenHeight(context) / 11.5,
                    width: AppMediaQuery.ScreenHeight(context) / 11.5,
                    child: FloatingActionButton(
                      onPressed: () {},
                      backgroundColor: Colors.white,
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50)),
                      child: GestureDetector(
                        onTap: () {
                          showDialog<void>(
                            context: context,
                            // false = user must tap button, true = tap outside dialog
                            builder: (BuildContext dialogContext) {
                              return AlertDialog(
                                elevation: 15,
                                title: Text("Select"),
                                actionsPadding: EdgeInsets.only(
                                    top: 10, bottom: 10, right: 10, left: 10),
                                actionsAlignment:
                                    MainAxisAlignment.spaceBetween,
                                alignment: Alignment.center,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5)),
                                contentTextStyle:
                                    TextStyle(color: CustomColor.Whitetext()),
                                actions: <Widget>[
                                  TextButton(
                                    child: Text('Camera'),
                                    onPressed: () {
                                      getImage(ImageSource
                                          .camera); // Dismiss alert dialog
                                    },
                                  ),
                                  TextButton(
                                    child: Text('Gallery'),
                                    onPressed: () {
                                      getImage(ImageSource
                                          .gallery); // Dismiss alert dialog
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        child: Icon(
                          Icons.camera_alt,
                          size: 38,
                          color: Colors.black,
                        ),
                      ),
                    )),
              ),
              SizedBox(
                height: AppMediaQuery.ScreenHeight(context) / 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Align the label inside\nthe box",
                    style: TextStyle(color: CustomColor.Whitetext()),
                  ),
                  Text(
                    "The label should be inside\nthe white box.",
                    textAlign: TextAlign.end,
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: AppMediaQuery.ScreenHeight(context) / 80,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Hold your phone steady",
                    style: TextStyle(color: CustomColor.Whitetext()),
                  ),
                  Text(
                    "We'll take care of the rest",
                    textAlign: TextAlign.end,
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: AppMediaQuery.ScreenHeight(context) / 20,
              ),
              CustomButton.button("Capture Image", CustomColor.Whitetext(),
                  CustomColor.Blackmain(), () {
                getImage(ImageSource.gallery);
              }),
              Text(recognizedText)
            ],
          ),
        ),
      ),
    );
  }
}
