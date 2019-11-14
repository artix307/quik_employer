class Employer {
  String emp_id;
  String emp_pic;
  String emp_name;
  String emp_email;
  String emp_phone;
  String emp_address;
  String emp_about;
  String emp_rating;
  String emp_counter;

  Employer(this.emp_id, this.emp_pic, this.emp_name, this.emp_email,
      this.emp_phone, this.emp_address, this.emp_about, this.emp_rating,
      this.emp_counter);

  Employer.map(dynamic obj) {
    this.emp_id = obj['id'];
    this.emp_pic = obj['picture'];
    this.emp_name = obj['name'];
    this.emp_email = obj['email'];
    this.emp_phone = obj['phone'];
    this.emp_address = obj['address'];
    this.emp_about = obj['about'];
    this.emp_rating = obj['rating'];
    this.emp_counter = obj['counter'];
  }

  String get id => emp_id;

  String get picture => emp_pic;

  String get name => emp_name;

  String get email => emp_email;

  String get phone => emp_phone;

  String get address => emp_address;

  String get about => emp_about;

  String get rating => emp_rating;

  String get counter => emp_counter;

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    if (emp_id != null) {
      map['id'] = emp_id;
    }
    map['picture'] = emp_pic;
    map['name'] = emp_name;
    map['email'] = emp_email;
    map['phone'] = emp_phone;
    map['address'] = emp_address;
    map['about'] = emp_about;
    map['rating'] = emp_rating;
    map['counter'] = emp_counter;

    return map;
  }

  Employer.fromMap(Map<String, dynamic> map) {
    this.emp_id = map['id'];
    this.emp_pic = map['picture'];
    this.emp_name = map['name'];
    this.emp_phone = map['phone'];
    this.emp_email = map['email'];
    this.emp_address = map['address'];
    this.emp_rating = map['rating'];
    this.emp_counter = map['counter'];
  }
}