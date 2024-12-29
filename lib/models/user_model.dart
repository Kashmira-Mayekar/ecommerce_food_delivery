class User {
  final int id;
  final String firstName;
  final String lastName;
  final String phone;
  final String email;
  final String empId;
  final bool isVeg;

  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.email,
    required this.empId,
    required this.isVeg,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] ?? 0,
      firstName: json['f_name'] ?? '',
      lastName: json['l_name'] ?? '',
      phone: json['phone'] ?? '',
      email: json['email'] ?? '',
      empId: json['emp_id'] ?? '',
      isVeg: json['is_veg'] == 1,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['f_name'] = this.firstName;
    data['l_name'] = this.lastName;
    data['phone'] = this.phone;
    data['email'] = this.email;
    data['emp_id'] = this.empId;
    data['is_veg'] = this.isVeg;
    return data;
  }
}
