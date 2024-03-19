import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../app_config/app_color_config.dart';
import '../../controller/profile_controler.dart';
import '../../model/work_experience_model.dart';

class ResumeMaker extends StatelessWidget {
  ResumeMaker({Key? key}) : super(key: key);
  final ProfileController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Create Resume',
          style: TextStyle(
              fontSize: 22.sp,
              fontWeight: FontWeight.w500,
              color: AppColour.blackColor),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Obx(
                  () => controller.imageFile.value != null
                      ? CircleAvatar(
                          radius: 80,
                          backgroundImage:
                              FileImage(controller.imageFile.value!),
                        )
                      : const CircleAvatar(
                          radius: 80,
                          backgroundImage: AssetImage('assets/img.png'),
                        ),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => controller.pickImage(),
                child: const Text('Select Picture'),
              ),
              TextField(
                controller: controller.nameController,
                decoration: const InputDecoration(labelText: 'Name'),
                keyboardType: TextInputType.name,
                maxLength: 20,
              ),
              TextField(
                controller: controller.emailController,
                decoration: const InputDecoration(labelText: 'Email'),
                keyboardType: TextInputType.emailAddress,
              ),
              TextField(
                controller: controller.phoneNumberController,
                keyboardType: TextInputType.phone,
                maxLength: 10,
                decoration: const InputDecoration(labelText: 'Phone Number'),
              ),
              const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Work Experience:-',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  )),
              20.height(),
              Obx(() {
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: controller.workExperiences.value.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          GestureDetector(
                              onTap: () {
                                controller.setUpdateWorkExperience(
                                    controller.workExperiences[index]);
                                _showAddWorkExperienceDialog(context,
                                    index: index);
                                isUpdate = true;
                              },
                              child: const Icon(Icons.edit))
                        ],
                      ),
                      title: Text(
                          controller.workExperiences.value[index].company ??
                              ''),
                      subtitle: Text(
                          controller.workExperiences[index].position ?? ''),
                      onTap: () {
                        // Edit work experience
                      },
                    );
                  },
                );
              }),
              ElevatedButton(
                onPressed: () {
                  _showAddWorkExperienceDialog(context);
                  isUpdate = false;
                  controller.companyController.clear();
                  controller.positionController.clear();
                  controller.startDateController.clear();
                  controller.endDateController.clear();
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: AppColour.secondaryColor,
                  minimumSize: const Size(90, 30),
                  textStyle: const TextStyle(
                    fontSize: 18,
                  ),
                  padding: const EdgeInsets.symmetric(
                      vertical: 12.0, horizontal: 18),
                ),
                child: const Text('Add Work Experience'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (isUpdate) {
                    controller.updateResume(controller.updateId.value);
                  } else {
                    controller.addResume();
                  }
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: AppColour.primaryColor,
                  minimumSize: const Size(double.infinity, 30),
                  textStyle: const TextStyle(
                    fontSize: 18,
                  ),
                  padding: const EdgeInsets.all(12.0),
                ),
                child: const Text("Save"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showAddWorkExperienceDialog(BuildContext context, {int? index}) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add Work Experience'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: controller.companyController,
                decoration: const InputDecoration(labelText: 'Company'),
              ),
              TextField(
                controller: controller.positionController,
                decoration: const InputDecoration(labelText: 'Position'),
              ),
              TextField(
                controller: controller.startDateController,
                decoration: const InputDecoration(labelText: 'Start Date'),
                readOnly: true,
                onTap: () {
                  controller.selectStartDate(context);
                },
              ),
              TextField(
                controller: controller.endDateController,
                decoration: const InputDecoration(labelText: 'End Date'),
                onTap: () {
                  controller.selectEndDate(context);
                },
                readOnly: true,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                WorkExperience newWorkExperience = WorkExperience(
                  company: controller.companyController.text,
                  position: controller.positionController.text,
                  startDate: controller.startDateController.text,
                  endDate: controller.endDateController.text,
                );

                if (!isUpdate) {
                  controller.workExperiences.add(newWorkExperience);
                } else {
                  controller.workExperiences[index!] = newWorkExperience;
                }
                controller.companyController.clear();
                controller.positionController.clear();
                controller.startDateController.clear();
                controller.endDateController.clear();
                Navigator.of(context).pop();
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }
}
