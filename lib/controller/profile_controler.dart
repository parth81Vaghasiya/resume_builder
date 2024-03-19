import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';

import '../app_config/database_manager.dart';
import '../model/resume_model.dart';
import '../model/work_experience_model.dart';
import '../utils/app_utils.dart';

bool isUpdate = false;

class ProfileController extends GetxController {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();

  final TextEditingController companyController = TextEditingController();
  final TextEditingController positionController = TextEditingController();
  final TextEditingController startDateController = TextEditingController();
  final TextEditingController endDateController = TextEditingController();
  RxInt updateId = 0.obs;

  Future<void> selectStartDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      startDateController.text = DateFormat('dd-MM-yyyy').format(picked);
    }
  }

  Future<void> selectEndDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      endDateController.text = DateFormat('dd-MM-yyyy').format(picked);
    }
  }

  Rx<File?> imageFile = Rx<File?>(null);
  RxList<WorkExperience> workExperiences = <WorkExperience>[].obs;

  Future<void> pickImage() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      imageFile.value = File(pickedImage.path);
    } else {
      print('No image selected.');
    }
  }

  var resumeList = <Resume>[].obs;
  DatabaseHelper dbHelper = DatabaseHelper();

  clearData() {
    nameController.clear();
    emailController.clear();
    phoneNumberController.clear();
    imageFile = Rx<File?>(null);
    workExperiences.clear();
  }

  @override
  void onInit() {
    super.onInit();
    fetchResumes();
  }

  void deleteData() async {
    await dbHelper.clearDatabase();
    fetchResumes();
  }

  Future<String> _saveImage(File imageFile) async {
    final directory = await getApplicationDocumentsDirectory();
    final imagePath =
        '${directory.path}/${DateTime.now().millisecondsSinceEpoch}.png';
    await imageFile.copy(imagePath);
    return imagePath;
  }

  void fetchResumes() async {
    var resumes = await dbHelper.getResumes();
    resumeList.assignAll(resumes);
  }

  void addResume() async {
    if (imageFile.value != null &&
        nameController.text.isNotEmpty &&
        emailController.text.isNotEmpty &&
        phoneNumberController.text.isNotEmpty) {
      final imagePath = await _saveImage(imageFile.value!);
      Resume newResume = Resume(
        name: nameController.text,
        email: emailController.text,
        phoneNumber: phoneNumberController.text,
        workExperiences: workExperiences,
        imagePath: imagePath,
      );
      await dbHelper.insertResume(newResume);
      clearData();
      fetchResumes();
      Get.back();
    } else {
      UtilsForApp.showToast(
          message: 'Please Select Profile Picture or Fill Detail',
          isError: true);
    }
  }

  setId(int id) {
    updateId.value = id;
    update();
  }

  void updateResume(int id) async {
    if (imageFile.value != null &&
        nameController.text.isNotEmpty &&
        emailController.text.isNotEmpty &&
        phoneNumberController.text.isNotEmpty) {
      final imagePath = await _saveImage(imageFile.value!);
      Resume newResume = Resume(
        id: id,
        name: nameController.text,
        email: emailController.text,
        phoneNumber: phoneNumberController.text,
        workExperiences: workExperiences.value,
        imagePath: imagePath,
      );
      await dbHelper.updateResume(newResume);
      clearData();
      fetchResumes();
      Get.back();
    } else {
      UtilsForApp.showToast(
          message: 'Please Select Profile Picture or Fill Detail',
          isError: true);
    }
  }

  void delete(int index) async {
    await dbHelper.deleteResume(index);
    fetchResumes();
  }

  setUpdateDate(Resume resume, int index) {
    updateId.value = index;
    imageFile.value = File(resume.imagePath ?? '');
    nameController.text = resume.name ?? "";
    emailController.text = resume.email ?? '';
    phoneNumberController.text = resume.phoneNumber ?? "";
    workExperiences.value = resume.workExperiences ?? [];
    update();
  }

  setUpdateWorkExperience(WorkExperience workExperience) {
    companyController.text = workExperience.company ?? '';
    startDateController.text = workExperience.startDate ?? '';
    endDateController.text = workExperience.endDate ?? '';
    positionController.text = workExperience.position ?? '';
  }


}
