import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:resume_builder/app_config/app_color_config.dart';
import 'package:resume_builder/view/resume_view/resume_view.dart';

import '../controller/profile_controler.dart';
import 'CreateResume/resume_maker.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final resumeController = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Home',
          style: TextStyle(
              fontSize: 22.sp,
              fontWeight: FontWeight.w500,
              color: AppColour.blackColor),
        ),
        actions: [
          IconButton(
              onPressed: () {
                resumeController.deleteData();
              },
              icon: const Icon(Icons.delete))
        ],
      ),
      body: Center(
        child: Obx(
          () => resumeController.resumeList.isEmpty
              ? const Center(
                  child: Text(
                    'No Data',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                )
              : ReorderableListView(
            onReorder: (oldIndex, newIndex) {
              setState(() {
                if (newIndex > oldIndex) {
                  newIndex -= 1;
                }
                final item = resumeController.resumeList.removeAt(oldIndex);
                resumeController.resumeList.insert(newIndex, item);
              });
            },
            children: [
              for (var i =0;i<resumeController.resumeList.length;i++)
                ListTile(
                  onTap: (){
                    Get.to(ResumeViewScreen(resume: resumeController.resumeList[i],));
                  },
                   key: Key(i.toString()),
                  leading: CircleAvatar(
                    backgroundImage: FileImage(File(resumeController.resumeList[i].imagePath!)),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      GestureDetector(
                          onTap: () {
                            resumeController.setUpdateDate(
                                resumeController.resumeList[i], i);
                            Get.to(ResumeMaker());
                            isUpdate = true;
                            resumeController.updateId.value = i + 1;
                            resumeController.setId(i + 1);
                          },
                          child: const Icon(Icons.edit)),
                      8.width(),
                      GestureDetector(
                          onTap: () {
                            resumeController.delete(i+1);
                          },
                          child: const Icon(Icons.delete))
                    ],
                  ),
                  title: Text(resumeController.resumeList[i].name ?? ''),
                  subtitle: Text(resumeController.resumeList[i].email ?? ''),
                ),
            ],
          )

        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColour.primaryColor,
        tooltip: 'Increment',
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        onPressed: () {
          resumeController.clearData();
          isUpdate = false;
          Get.to(ResumeMaker());
        },
        child: const Icon(Icons.add, color: Colors.white, size: 25),
      ),
    );
  }
}
