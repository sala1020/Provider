import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:student_provider/screen/widgets/image_picking.dart';

import '../../core/constants.dart';
import '../../database/model/model.dart';
import '../controller/controller.dart';
import 'textformfield_widget.dart';

editDialogue(
    {required int index,
    required StudentModel details,
    required BuildContext context}) {
  var nameController = TextEditingController(text: details.name);
  var ageController = TextEditingController(text: details.age.toString());
  var rollNumberController =
      TextEditingController(text: details.rollNumber.toString());
  var formKey = GlobalKey<FormState>();
  final controller = Provider.of<StudentController>(context);

  return Center(
    child: SingleChildScrollView(
      child: AlertDialog(
        shadowColor: Colors.black,
        title: Container(
          width: 250,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(
                onTap: () {
                  pickimage(context: context);
                },
                child: CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.white,
                  backgroundImage: controller.selectedImage.isEmpty
                      ? FileImage(File(details.imageUrl))
                      : FileImage(File(controller.selectedImage)),
                ),
              ),
              kHeight20,
              Form(
                  key: formKey,
                  child: Column(
                    children: [
                      TextFormFieldWidget(
                        conroller: nameController,
                        keyboardType: TextInputType.name,
                        labelText: 'Name',
                        validator: (value) {
                          if (value!.trim().isEmpty) {
                            return 'Field is emtpy';
                          }
                          return null;
                        },
                      ),
                      kHeight20,
                      TextFormFieldWidget(
                        conroller: ageController,
                        labelText: 'Age',
                        validator: (value) {
                          if (value!.trim().isEmpty) {
                            return 'Field is emtpy';
                          }
                          return null;
                        },
                      ),
                      kHeight20,
                      TextFormFieldWidget(
                        conroller: rollNumberController,
                        labelText: 'RollNo',
                        validator: (value) {
                          if (value!.trim().isEmpty) {
                            return 'Field is emtpy';
                          }
                          return null;
                        },
                      ),
                    ],
                  ))
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              if (controller.selectedImage.isNotEmpty ||
                  details.imageUrl.isNotEmpty) {
                print(index);
                if (formKey.currentState!.validate()) {
                  print(index);
                  int age = int.parse(ageController.text);
                  int rollNo = int.parse(rollNumberController.text);
                  Provider.of<StudentController>(
                    context,
                    listen: false,
                  ).updateDetails(
                    index: index,
                    data: StudentModel(
                      name: nameController.text,
                      age: age,
                      rollNumber: rollNo,
                      imageUrl: controller.selectedImage.isEmpty
                          ? details.imageUrl
                          : Provider.of<StudentController>(context,
                                  listen: false)
                              .selectedImage,
                    ),
                  );

                  controller.selectedImage = '';
                  Get.back();
                  Get.snackbar(
                    'Success',
                    'Successfully Edited',
                    backgroundColor: const Color.fromARGB(106, 54, 244, 73),
                    duration: Duration(microseconds: 800)
                  );
                }
              }
            },
            child: const Text(
              'Save',
              style: TextStyle(color: Colors.black),
            ),
          ),
          TextButton(
            onPressed: () {
              Get.back();
            },
            child: const Text(
              'Cancel',
              style: TextStyle(color: Colors.black),
            ),
          )
        ],
      ),
    ),
  );
}
