// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:job_app/Controllers/Profile/ProfileController.dart';
import 'package:job_app/Widgets/JobSeeker/fetch_education.dart';
import 'package:job_app/Widgets/JobSeeker/fetch_experience.dart';
import 'package:job_app/Widgets/JobSeeker/fetch_language.dart';
import 'package:job_app/Widgets/JobSeeker/fetch_skill.dart';

class JobseekerProfile extends StatefulWidget {
  const JobseekerProfile({super.key});

  @override
  State<JobseekerProfile> createState() => _JobseekerProfileState();
}

class _JobseekerProfileState extends State<JobseekerProfile> {
  final ProfileController _profileController = Get.put(ProfileController());

  @override
  void initState() {
    super.initState();
    _profileController.fetchProfiles();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: FutureBuilder(
                future: _profileController.fetchProfiles(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                        child: CircularProgressIndicator(
                      strokeWidth: 2,
                      strokeAlign: -5,
                    ));
                  }
                  if (snapshot.hasError) {
                    return Center(child: Text("Error"));
                  }
                  if (_profileController.profiles.isEmpty) {
                    return Center(
                      child: Text("No profile data found",
                          style: GoogleFonts.poppins()),
                    );
                  } else {
                    return SingleChildScrollView(
                      child: Column(
                        children: [
                          Container(
                            margin:
                                EdgeInsets.only(top: 16, left: 16, right: 10),
                            width: double.infinity,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(children: [
                                  Container(
                                      decoration: BoxDecoration(
                                          color: Colors.grey.withOpacity(0.5),
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      margin:
                                          EdgeInsets.only(right: 5, top: 20),
                                      padding: EdgeInsets.all(16),
                                      child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                                _profileController
                                                        .profiles["jobseeker"]
                                                    ["user"]["firstname"][0],
                                                style: GoogleFonts.poppins(
                                                    fontSize: 50)),
                                            Text(
                                                _profileController
                                                        .profiles["jobseeker"]
                                                    ["user"]["lastname"][0],
                                                style: GoogleFonts.poppins(
                                                    fontSize: 50)),
                                          ])),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          _profileController.isloading.value
                                              ? Text("loading...")
                                              : Text(
                                                  _profileController.profiles[
                                                                  "jobseeker"]
                                                              ["user"]
                                                          ["firstname"] +
                                                      " " +
                                                      _profileController
                                                                  .profiles[
                                                              "jobseeker"]
                                                          ["user"]["lastname"],
                                                  style: GoogleFonts.poppins(
                                                      fontSize: 20)),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Icon(Icons.location_on_outlined,
                                              size: 18),
                                          _profileController
                                                          .profiles["jobseeker"]
                                                      ["user"]["address"] !=
                                                  null
                                              ? Text(
                                                  _profileController
                                                          .profiles["jobseeker"]
                                                      ["user"]["address"],
                                                  style: GoogleFonts.poppins(),
                                                )
                                              : Text("Null",
                                                  style: GoogleFonts.poppins()),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Icon(Icons.email_outlined, size: 20),
                                          _profileController
                                                          .profiles["jobseeker"]
                                                      ["user"]["email"] !=
                                                  null
                                              ? Text(
                                                  _profileController
                                                          .profiles["jobseeker"]
                                                      ["user"]["email"],
                                                  style: GoogleFonts.poppins(),
                                                )
                                              : Text("Null",
                                                  style: GoogleFonts.poppins()),
                                        ],
                                      ),
                                    ],
                                  ),
                                ]),
                                SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.02),
                                Divider(thickness: 2),
                                FetchSkill(),
                                Divider(thickness: 2),
                                FetchEducation(),
                                Divider(thickness: 2),
                                FetchExperience(),
                                Divider(thickness: 2),
                                FetchLanguage(),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                })));
  }
}
