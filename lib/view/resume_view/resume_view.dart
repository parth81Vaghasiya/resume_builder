import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:resume_builder/model/resume_model.dart';

import '../../app_config/app_color_config.dart';

class ResumeViewScreen extends StatelessWidget {
  ResumeViewScreen({Key? key, required this.resume}) : super(key: key);
  Resume resume;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Preview',
          style: TextStyle(
              fontSize: 22.sp,
              fontWeight: FontWeight.w500,
              color: AppColour.blackColor),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Center(
                child: Container(
                  padding: const EdgeInsets.all(5),
                  decoration: const BoxDecoration(
                      color: Colors.black, shape: BoxShape.circle),
                  child: CircleAvatar(
                    radius: 60,
                    backgroundImage: FileImage(File(resume.imagePath!)),
                  ),
                ),
              ),
              10.height(),
              detailWidgets(title: 'Name:-', detail: resume.name),
              detailWidgets(title: 'Email:-', detail: resume.email),
              detailWidgets(
                  title: 'Phone Number:-', detail: resume.phoneNumber),
              20.height(),
              const Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Work Experience',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: AppColour.primaryColor),
                  )),
              10.height(),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: resume.workExperiences?.length,
                itemBuilder: (context, index) {
                  return Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: AppColour.lightYellowColor
                    ),
                    child: Column(
                      children: [
                        detailWidgets(title: 'Company:-', detail: resume.workExperiences![index].company ?? ''),
                        detailWidgets(title: 'Position:-', detail: resume.workExperiences![index].position ?? ''),
                        detailWidgets(title: 'Start Date:-', detail: resume.workExperiences![index].startDate ?? ''),
                        detailWidgets(title: 'End Date:-', detail: resume.workExperiences![index].endDate ?? ''),
                      ],
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  detailWidgets({String? title, detail}) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title ?? '',
              style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
            ),
            Text(
              detail ?? '',
              style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
            )
          ],
        ),
        Divider(),
      ],
    );
  }
}
