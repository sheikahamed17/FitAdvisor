
import 'package:flutter/cupertino.dart';

class AppMediaQuery{
  static ScreenHeight(BuildContext context){
    return MediaQuery.of(context).size.height;
  }
  static ScreenWidth(BuildContext context){
    return MediaQuery.of(context).size.width;
  }
  static Textfactor(BuildContext context){
    return MediaQuery.of(context).textScaleFactor;
  }
}