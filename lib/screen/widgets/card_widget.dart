import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:student_provider/screen/controller/controller.dart';

import '../../core/constants.dart';
import '../../database/model/model.dart';
import 'image_picking.dart';
import 'text_widget.dart';
import 'textformfield_widget.dart';

Card cardWidget(
    {required StudentModel details,
    required int index,
    required BuildContext context}) {
  final controller = Provider.of<StudentController>(context);
  print(details.name);
  return Card(
    color: const Color(0xff1995AD),
    elevation: 19,
    shadowColor: Colors.grey,
    child: Column(
      children: [
        const Spacer(),
        CircleAvatar(
          radius: 50,
          backgroundColor: Colors.white,
          backgroundImage: FileImage(File(
            details.imageUrl,
          )),
        ),
        textWidget(
          text: 'Name: ${details.name}',
        ),
        textWidget(text: 'Age: ${details.age}'.toString()),
        textWidget(text: 'Roll No: ${details.rollNumber}'.toString()),
        const Spacer(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              onPressed: () {
                controller.deleteStudent(index: index);
              },
              icon: const Icon(
                Icons.delete,
                size: 40,
              ),
            ),
            IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return editDialogue(
                        index: index, details: details, context: context);
                  },
                );
              },
              icon: const Icon(
                Icons.edit,
                size: 40,
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

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
