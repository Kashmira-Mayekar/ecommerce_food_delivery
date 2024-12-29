class Reports {
  final String date;
  final Map<String, String>? optIns;

  Reports({required this.date, this.optIns});

  factory Reports.fromJson(Map<String, dynamic> json) {
    return Reports(
      date: json['date'],
      optIns: json['opt_ins'] is Map
          ? Map<String, String>.from(json['opt_ins'])
          : null,
    );
  }
}