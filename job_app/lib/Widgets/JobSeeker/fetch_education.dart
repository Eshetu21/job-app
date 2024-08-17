// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:job_app/Controllers/JobSeeker/education_controller.dart';

class FetchEducation extends StatefulWidget {
  const FetchEducation({super.key});

  @override
  State<FetchEducation> createState() => _FetchEducationState();
}

class _FetchEducationState extends State<FetchEducation> {
  final EducationController _educationController =
      Get.put(EducationController());
  @override
  void initState() {
    super.initState();
    _educationController.showeducation();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _educationController.showeducation(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (_educationController.educationDetails.isEmpty) {
            return Center(
                child: Text("No Education", style: GoogleFonts.poppins()));
          } else {
            return _educationController.educationDetails.isEmpty
                ? Text("No education")
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: _educationController.educationDetails
                        .map<Widget>((education) {
                      bool noEducationProvided =
                          education["school_name"] == null &&
                              education["field"] == null &&
                              education["education_level"] == null &&
                              education["edu_start_date"] == null &&
                              education["edu_end_date"] == null &&
                              education["description"] == null;
                      return Container(
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.all(8.0),
                        margin: EdgeInsets.symmetric(vertical: 5.0),
                        child: noEducationProvided
                            ? Center(child: Text("No education",style: GoogleFonts.poppins()))
                            : Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    education["school_name"] ?? "Not Provided",
                                    style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    "Field: ${education["field"] ?? "Not Provided"}",
                                    style: GoogleFonts.poppins(),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    "Level: ${education["education_level"] ?? "Not Provided"}",
                                    style: GoogleFonts.poppins(),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    "Start Date: ${education["edu_start_date"] ?? "Not Provided"}",
                                    style: GoogleFonts.poppins(),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                      "End Date: ${education["edu_end_date"] ?? "Not Provided"}",
                                      style: GoogleFonts.poppins()),
                                  SizedBox(height: 4),
                                  Text(
                                    "Description: ${education["description"] ?? "Not Provided"}",
                                    style: GoogleFonts.poppins(),
                                  ),
                                ],
                              ),
                      );
                    }).toList(),
                  );
          }
        });
  }
}