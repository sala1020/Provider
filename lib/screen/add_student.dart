import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../core/constants.dart';
import '../database/boxes/boxes.dart';
import '../database/model/model.dart';
import 'controller/controller.dart';
import 'widgets/appbar_wiget.dart';
import 'widgets/image_picking.dart';
import 'widgets/text_widget.dart';
import 'widgets/textformfield_widget.dart';

class AddStudent extends StatelessWidget {
  AddStudent({super.key});
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final ageController = TextEditingController();
  final rollNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<StudentController>(context, listen: false);
    return Scaffold(
      appBar: appBarWidget(title: 'Add Student'),
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                imagePicking(context: context),
                kHeight20,
                kHeight10,
                TextFormFieldWidget(
                  conroller: nameController,
                  labelText: 'Name',
                  keyboardType: TextInputType.text,
                  validator: (value) {
                    if (value!.trim().isEmpty) {
                      return 'Enter Name Of student';
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
                      return 'Enter Age of the Student';
                    }
                    return null;
                  },
                ),
                kHeight20,
                TextFormFieldWidget(
                  conroller: rollNumberController,
                  labelText: 'Roll no',
                  validator: (value) {
                    if (value!.trim().isEmpty) {
                      return 'Enter RollNO of Student';
                    }
                    return null;
                  },
                ),
                kHeight20,
                ElevatedButton(
                  onPressed: () {
                    if (controller.selectedImage.isNotEmpty) {
                      if (formKey.currentState!.validate()) {
                        int age = int.parse(ageController.text);
                        int rollNo = int.parse(rollNumberController.text);

                        box.add(
                          StudentModel(
                              name: nameController.text,
                              age: age,
                              rollNumber: rollNo,
                              imageUrl: Provider.of<StudentController>(context,
                                      listen: false)
                                  .selectedImage),
                        );
                        nameController.clear();
                        ageController.clear();
                        rollNumberController.clear();
                        controller.selectedImage = '';

                        Get.back(result: 'back');
                        controller.updateStudentListView();
                        Get.snackbar('Success', 'Created Successfully',
                            backgroundColor:
                                const Color.fromARGB(106, 54, 244, 73),
                            dismissDirection: DismissDirection.horizontal,
                            duration: const Duration(milliseconds: 800));
                      }
                    } else {
                      Get.snackbar('error', 'Plz Select image',
                          backgroundColor:
                              const Color.fromARGB(106, 244, 67, 54),
                          dismissDirection: DismissDirection.horizontal,
                          duration: const Duration(milliseconds: 800));
                    }
                  },
                  style: const ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(
                      Color(0xff1995AD),
                    ),
                  ),
                  child: textWidget(text: 'Create'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
