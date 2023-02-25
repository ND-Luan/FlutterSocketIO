import 'dart:io';

import 'package:camera/camera.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cameraapp/InfoCameraScreen.dart';
import 'package:cameraapp/Message.dart';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  late List<CameraDescription> cameras;
  late CameraController cameraController;

  int direction = 0;
  // Create a storage reference from our app
  final storageRef = FirebaseStorage.instance.ref().child("img");

  @override
  void initState() {
    startCamera(0);
    super.initState();
  }

  void startCamera(int direction) async {
    cameras = await availableCameras();
    cameraController = CameraController(
        cameras[direction], ResolutionPreset.high,
        enableAudio: false);
    await cameraController.initialize().then((value) {
      if (!mounted) return;
      setState(() {});
    }).catchError((e) {
      print(e);
    });
  }

  @override
  void dispose() {
    cameraController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (cameraController.value.isInitialized) {
      return SafeArea(
        bottom: true,
        left: true,
        top: true,
        right: true,
        maintainBottomViewPadding: true,
        minimum: EdgeInsets.zero,
        child: Scaffold(
            body: Stack(
          children: [
            CameraPreview(cameraController),
            GestureDetector(
              onTap: () {
                setState(() async {
                  direction = direction == 0 ? 1 : 0;

                  startCamera(direction);
                });
              },
              child: button(
                  Icons.flip_camera_android_outlined, Alignment.bottomLeft),
            ),
            GestureDetector(
              onTap: () {
                cameraController.takePicture().then((XFile file) async => {
                      if (mounted)
                        {
                          if (file != null)
                            {
                              print("Picture save to ${file.path}"),
                              await storageRef.putFile(File(file.path)),
                              storageRef
                                  .getDownloadURL()
                                  .then((value) => print(value)),
                              Navigator.pushNamed(
                                context, '/infocamera',
                                //arguments: Message(
                                //message: "Pass args", path: file.path)
                              ),
                            }
                        }
                    });
              },
              child: button(Icons.camera_alt_outlined, Alignment.bottomCenter),
            ),
          ],
        )),
      );
    } else {
      return const SizedBox();
    }
  }

  Widget button(IconData icon, Alignment alignment) {
    return Align(
      alignment: alignment,
      child: Container(
        margin: EdgeInsets.only(left: 50, bottom: 50),
        height: 50,
        width: 50,
        decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.black),
        child: Center(
            child: Icon(
          icon,
          color: Colors.white,
        )),
      ),
    );
  }
}
