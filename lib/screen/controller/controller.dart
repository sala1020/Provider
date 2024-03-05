import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import '../../database/boxes/boxes.dart';
import '../../database/model/model.dart';

// StudentController controller = Get.put(StudentController());

class StudentController extends ChangeNotifier {
  String selectedImage = '';
  bool imageSelected = false;

  var text = 'salu';

  Box<StudentModel> studentBox = Hive.box<StudentModel>('StudentDetails');


  void getImage(String imageUrl) {
    selectedImage = imageUrl;

    notifyListeners();
  }

  void updateStudentListView() {
    List<StudentModel> newData = box.values.cast<StudentModel>().toList();
    for (var student in newData) {
      if (!studentBox.values.contains(student)) {
        studentBox.add(student);
      }
    }

    notifyListeners();
  }

  void updateDetails({required int index, required StudentModel data}) {
    studentBox.putAt(index, data);
    notifyListeners();
  }

  void deleteStudent({required int index}) {
    studentBox.deleteAt(index);
    Get.back();
    notifyListeners();
  }

  
}
