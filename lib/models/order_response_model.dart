import 'report_model.dart';
import 'user_model.dart';

class OrderResponseModel {
  final User user;
  final List<Reports> reports;

  OrderResponseModel({required this.user, required this.reports});

  factory OrderResponseModel.fromJson(Map<String, dynamic> json) {
    return OrderResponseModel(
      user: User.fromJson(json['user']),
      reports: (json['reports'] as List)
          .map((report) => Reports.fromJson(report))
          .toList(),
    );
  }
}
