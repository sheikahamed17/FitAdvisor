import 'dart:math';

import 'package:FitAdvisor/utils/pose_painter.dart';
import 'package:FitAdvisor/utils/responsive.dart';
import 'package:FitAdvisor/utils/textstyles.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:google_mlkit_pose_detection/google_mlkit_pose_detection.dart';

import 'detector_view.dart';

class PoseDetectorView extends StatefulWidget {
  const PoseDetectorView({super.key});

  @override
  State<StatefulWidget> createState() => _PoseDetectorViewState();
}

class _PoseDetectorViewState extends State<PoseDetectorView> {
  void updateResult(String result) {
    setState(() {
      this.result = result;
    });
  }

  final PoseDetector _poseDetector =
      PoseDetector(options: PoseDetectorOptions());
  bool _canProcess = true;
  bool _isBusy = false;
  CustomPaint? _customPaint;
  String? _text;
  String result = 'unknown';
  var _cameraLensDirection = CameraLensDirection.back;

  @override
  void dispose() async {
    _canProcess = false;
    _poseDetector.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Stack(
        children: [
          DetectorView(
            title: 'Pose Detector',
            customPaint: _customPaint,
            text: _text,
            onImage: _processImage,
            initialCameraLensDirection: _cameraLensDirection,
            onCameraLensDirectionChanged: (value) =>
                _cameraLensDirection = value,
          ),
          CustomTextStyles.head(result, AppMediaQuery.Textfactor(context) * 30),
        ],
      ),
    ));
  }

  Future<String> _poseDetect(InputImage inputImage) async {
    final List<Pose> poses = await _poseDetector.processImage(inputImage);

    for (Pose pose in poses) {
      // to access all landmarks
      pose.landmarks.forEach((_, landmark) {
        final type = landmark.type;
        final x = landmark.x;
        final y = landmark.y;
        var last = pose.landmarks.values.last;
      });
      final leftShoulder = pose.landmarks[PoseLandmarkType.leftShoulder];
      final rightShoulder = pose.landmarks[PoseLandmarkType.rightShoulder];
      final leftElbow = pose.landmarks[PoseLandmarkType.leftElbow];
      final rightElbow = pose.landmarks[PoseLandmarkType.rightElbow];
      final leftWrist = pose.landmarks[PoseLandmarkType.leftWrist];
      final rightWrist = pose.landmarks[PoseLandmarkType.rightWrist];
      final leftHip = pose.landmarks[PoseLandmarkType.leftHip];
      final rightHip = pose.landmarks[PoseLandmarkType.rightHip];
      final leftKnee = pose.landmarks[PoseLandmarkType.leftKnee];
      final rightKnee = pose.landmarks[PoseLandmarkType.rightKnee];
      final leftAnkle = pose.landmarks[PoseLandmarkType.leftAnkle];
      final rightAnkle = pose.landmarks[PoseLandmarkType.rightAnkle];

      final squatAngle = calculateAngle([leftHip!.x, leftHip.y],
          [leftKnee!.x, leftKnee.y], [leftAnkle!.x, leftAnkle.y]);
      if (squatAngle > 160) {
        result = "Squat Down";
        return "Squat Down";
      } else if (squatAngle < 30) {
        result = "Squat Up";
        return "Squat Up";
      }

      final pushupAngle = calculateAngle([leftShoulder!.x, leftShoulder.y],
          [leftElbow!.x, leftElbow.y], [leftWrist!.x, leftWrist.y]);
      if (pushupAngle < 120) {
        result = "Push-Up";
        return "Push-Up";
      }

      final lungeAngle = calculateAngle([leftHip.x, leftHip.y],
          [leftKnee.x, leftKnee.y], [rightKnee!.x, rightKnee.y]);
      if (lungeAngle > 160) {
        result = "Lunge Down";
        return "Lunge Down";
      } else if (lungeAngle < 30) {
        result = "Lunge Up";
        return "Lunge Up";
      }

      final plankAngle = calculateAngle([leftShoulder.x, leftShoulder.y],
          [leftHip.x, leftHip.y], [rightHip!.x, rightHip.y]);
      if (plankAngle < 30) {
        result = "Plank";
        return "Plank";
      }

      final stretchAngle = calculateAngle([leftShoulder.x, leftShoulder.y],
          [leftElbow.x, leftElbow.y], [leftWrist.x, leftWrist.y]);
      if (stretchAngle < 30) {
        result = "Stretch";
        return "Stretch";
      }
    }
    result = "Unknown";
    return "Unknown";
  }

  double calculateAngle(List<double> a, List<double> b, List<double> c) {
    a = List.from(a);
    b = List.from(b);
    c = List.from(c);

    double radians =
        atan2(c[1] - b[1], c[0] - b[0]) - atan2(a[1] - b[1], a[0] - b[0]);
    double angle = radians * 180.0 / pi;
    double finalAngle = angle.abs();

    if (finalAngle > 180.0) {
      finalAngle = 360 - finalAngle;
    }

    return finalAngle;
  }

  Future<void> _processImage(InputImage inputImage) async {
    if (!_canProcess) return;
    if (_isBusy) return;
    _isBusy = true;
    setState(() {
      _text = '';
    });
    final poses = await _poseDetector.processImage(inputImage);
    if (inputImage.metadata?.size != null &&
        inputImage.metadata?.rotation != null) {
      final painter = PosePainter(
        poses,
        inputImage.metadata!.size,
        inputImage.metadata!.rotation,
        _cameraLensDirection,
      );
      _customPaint = CustomPaint(painter: painter);
    } else {
      _text = 'Poses found: ${poses.length}\n\n';
      // TODO: set _customPaint to draw landmarks on top of image
      _customPaint = null;
    }
    _isBusy = false;
    if (mounted) {
      setState(() {
        _poseDetect(inputImage);
      });
    }
  }
}
