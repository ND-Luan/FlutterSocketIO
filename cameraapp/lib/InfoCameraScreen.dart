import 'package:cameraapp/Message.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class InfoCameraScreen extends StatefulWidget {
  const InfoCameraScreen({
    super.key,
  });

  @override
  State<InfoCameraScreen> createState() => _InfoCameraScreenState();
}

class _InfoCameraScreenState extends State<InfoCameraScreen> {
  @override
  Widget build(BuildContext context) {
    var data = ModalRoute.of(context)!.settings.arguments as Message;
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  width: 150,
                  height: 100,
                  color: Colors.black,
                  child: const Center(
                    child: Text(
                      'Navigate Camera',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
              Center(child: Text(data.message)),
              Center(child: Text(data.path))
            ],
          ),
        ),
      ),
    );
  }
}
