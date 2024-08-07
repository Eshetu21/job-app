import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:job_app/constants/constants.dart';
import 'package:http/http.dart' as http;

class EducationController extends GetxController {
  RxMap<String, dynamic> education = <String, dynamic>{}.obs;
  final box = GetStorage();
  late final String? token;
  late final int jobseekerId;

  EducationController() {
    token = box.read("token");
    jobseekerId = box.read("jobseekerId");
  }

 Future<void> createeducation() async {
    final response = await http.post(
      Uri.parse("${url}addeducation"),
      headers: {"Accept": "application/json", "Authorization": "Bearer $token"},
    );
    if (response.statusCode == 201) {
      print("sucessfully created education");
    } else {
      print("failed to created");
    }
  }
  Future<Map<String, dynamic>> showeducation({int? jobseekerId}) async {
    var response = await http.get(Uri.parse("${url}showeducation"), headers: {
      "Accept": "application/json",
      "Authorization": "Bearer $token"
    });
    if (response.statusCode == 200) {
      var responseData = jsonDecode(response.body);
      return responseData;
    } else {
      throw Exception("Failed to get jobseeker data");
    }
  }

  Future updateeducation(
      {required int jobseekerid,
      required int educationid,
      String? institution,
      String? field,
      String? eduLevel,
      String? eduStart,
      String? eduEnd,
      String? eduDescription}) async {
    try {
      var data = {
        "school_name": institution ?? "",
        "field": field ?? "",
        "education_level": eduLevel ?? "",
        "edu_start_date": eduStart ?? "",
        "edu_end_date": eduEnd ?? "",
        "description": eduDescription ?? ""
      };
      var encodedData = data.entries
          .map((e) =>
              '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
          .join('&');
      final response = await http.put(
          Uri.parse("${url}updateeducation/$jobseekerid/$educationid"),
          headers: {
            "Accept": "application/json",
            "Authorization": "Bearer $token",
            "Content-Type": "application/x-www-form-urlencoded",
          },
          body: encodedData);
      if (response.statusCode == 200) {
        print("Education updated");
        print(encodedData);
      }
    } catch ($e) {
      print("Failed");
      print($e.toString());
    }
  }
}
