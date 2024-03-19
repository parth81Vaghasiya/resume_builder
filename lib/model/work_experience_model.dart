class WorkExperience {
  String? company;
  String? position;
  String? startDate;
  String? endDate;

  WorkExperience(
      {
      this.company,
      this.position,
      this.startDate,
      this.endDate});

  Map<String, dynamic> toMap() {
    return {
      'company': company,
      'position': position,
      'startDate': startDate,
      'endDate': endDate,
    };
  }

  factory WorkExperience.fromMap(Map<String, dynamic> map) {
    return WorkExperience(
      company: map['company'],
      position: map['position'],
      startDate: map['startDate'],
      endDate: map['endDate'],
    );
  }
}
