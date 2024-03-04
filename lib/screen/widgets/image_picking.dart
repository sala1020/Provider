import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../controller/controller.dart';

GestureDetector imagePicking({required BuildContext context}) {
  final controller = Provider.of<StudentController>(context, listen: false);
  return GestureDetector(onTap: () {
    pickimage(context: context);
  }, child: Consumer<StudentController>(
    builder: (context, value, child) {
      return GestureDetector(
        onTap: () {
          pickimage(context: context);
        },
        child: CircleAvatar(
          backgroundColor: Colors.white,
          radius: 70,
          backgroundImage: controller.selectedImage.trim().isEmpty
              ? Image.asset(
                  'assets/profile1.png',
                  fit: BoxFit.fill,
                ).image
              : Image.file(
                  File(controller.selectedImage),
                  fit: BoxFit.cover,
                  gaplessPlayback: true,
                ).image,
        ),
      );
    },
  ));
}

void pickimage({required BuildContext context}) async {
  final image = await ImagePicker().pickImage(source: ImageSource.gallery);
  if (image != null) {
    Provider.of<StudentController>(context, listen: false).getImage(image.path);
  }
  return null;
}
