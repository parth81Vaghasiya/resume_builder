import 'dart:convert';

import 'package:resume_builder/model/work_experience_model.dart';

class Resume {
  final int? id;
  final String? name;
  final String? email;
  final String? phoneNumber;
  final String? imagePath;
  final List<WorkExperience>? workExperiences;

  Resume({this.id, this.name, this.email, this.phoneNumber, this.imagePath, this.workExperiences});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phoneNumber': phoneNumber,
      'imagePath': imagePath,
      'workExperiences': jsonEncode(workExperiences?.map((e) => e.toMap()).toList()),
    };
  }
}
