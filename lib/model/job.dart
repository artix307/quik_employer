class Job {
  String job_id;
  String job_position;
  String job_salary;
  String job_salary_type;
  String job_description;
  String job_requirement;
  String job_benefit;
  String employer_id;



  Job(this.job_id, this.job_position, this.job_salary, this.job_salary_type,
      this.job_description, this.employer_id, this.job_benefit, this.job_requirement);

  Job.map(dynamic obj) {
    this.job_id = obj['id'];
    this.job_position = obj['position'];
    this.job_salary = obj['salary'];
    this.job_salary_type = obj['salaryType'];
    this.job_description = obj['description'];
    this.employer_id = obj['empId'];
    this.job_benefit = obj['benefit'];
    this.job_requirement = obj['requirement'];
  }

  String get id => job_id;

  String get position => job_position;

  String get salary => job_salary;

  String get salaryType => job_salary_type;

  String get description => job_description;

  String get empId => employer_id;

  String get benefit => job_benefit;

  String get requirement => job_requirement;

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    if (job_id != null) {
      map['id'] = job_id;
    }
    map['position'] = job_position;
    map['salary'] = job_salary;
    map['salaryType'] = job_salary_type;
    map['description'] = job_description;
    map['empId'] = employer_id;
    map['benefit'] = job_benefit;
    map['requirement'] = job_requirement;

    return map;
  }

  Job.fromMap(Map<String, dynamic> map) {
    this.job_id = map['id'];
    this.job_position = map['position'];
    this.job_salary = map['salary'];
    this.job_salary_type = map['salaryType'];
    this.job_description = map['description'];
    this.employer_id = map['empId'];
    this.job_benefit = map['benefit'];
    this.job_requirement = map['requirement'];
  }
}
