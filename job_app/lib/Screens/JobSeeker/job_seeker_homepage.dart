// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_final_fields, avoid_unnecessary_containers, sized_box_for_whitespace, invalid_use_of_protected_member

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:job_app/Controllers/JobSeeker/jobseeker_controller.dart';
import 'package:job_app/Controllers/Profile/ProfileController.dart';
import 'package:job_app/Controllers/User/UserController.dart';
import 'package:job_app/Screens/Company/company_homepage.dart';
import 'package:job_app/Screens/JobSeeker/Jobseeker/applications_page.dart';
import 'package:job_app/Screens/JobSeeker/Jobseeker/explore_page.dart';
import 'package:job_app/Screens/JobSeeker/Jobseeker/jobseeker_profile.dart';
import 'package:job_app/Screens/PrivateClient/private_client_homepage.dart';
import 'package:job_app/Screens/Profiles/profiles.dart';

class JobSeekerHomepage extends StatefulWidget {
  const JobSeekerHomepage({super.key});

  @override
  State<JobSeekerHomepage> createState() => _JobSeekerHomepageState();
}

class _JobSeekerHomepageState extends State<JobSeekerHomepage> {
  final UserAuthenticationController _userAuthenticationController =
      Get.put(UserAuthenticationController());
  final JobSeekerController _jobSeekerController =
      Get.put(JobSeekerController());
  final ProfileController _profileController = Get.put(ProfileController());
  String selectedProfile = 'jobseeker';
  int currentindex = 0;
  final PageController _pageController = PageController();
  @override
  void initState() {
    super.initState();
    _jobSeekerController.getJobSeeker();
    _jobSeekerController.fetchJobSeeker();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Container(
            margin: EdgeInsets.only(top: 20, right: 20, left: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text("Welcome",
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w600,
                            fontSize: 24,
                            color: Color(0xFFFF9228))),
                    Spacer(),
                    SizedBox(width: 10),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: GestureDetector(
                          onTap: () {
                            showModalBottomSheet(
                              context: context,
                              builder: (context) {
                                return StatefulBuilder(
                                  builder: (BuildContext context,
                                      StateSetter setState) {
                                    return Container(
                                      width: double.infinity,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.45,
                                      child: Column(
                                        children: [
                                          if (_profileController
                                              .isloading.value)
                                            Center(
                                                child:
                                                    CircularProgressIndicator())
                                          else ...[
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 8, left: 18, top: 18),
                                              child: Align(
                                                  alignment: Alignment.topLeft,
                                                  child: Text("My Accounts",
                                                      style:
                                                          GoogleFonts.poppins(
                                                              fontSize: 22,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600))),
                                            ),
                                            if (_profileController
                                                    .profiles["jobseeker"] !=
                                                null)
                                              _profileContainer(
                                                  ListTile(
                                                    leading: Image.asset(
                                                        "assets/icons/job_seeker.png",
                                                        width: 28,
                                                        color:
                                                            Color(0xFFFF9228)),
                                                    title: Text(
                                                        _profileController.profiles[
                                                                        'jobseeker']
                                                                    ['user']
                                                                ['firstname'] +
                                                            " " +
                                                            _profileController
                                                                        .profiles[
                                                                    'jobseeker']['user']
                                                                ['lastname'],
                                                        style:
                                                            GoogleFonts.poppins(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500)),
                                                    subtitle:
                                                        Text("Job Seeker"),
                                                    trailing: Radio(
                                                      value: 'jobseeker',
                                                      groupValue:
                                                          selectedProfile,
                                                      onChanged: (value) {
                                                        setState(() {
                                                          selectedProfile =
                                                              value.toString();
                                                        });
                                                      },
                                                    ),
                                                  ),
                                                  "jobseeker",
                                                  () {}),
                                            if (_profileController.profiles[
                                                    "privateclient"] !=
                                                null)
                                              _profileContainer(
                                                  ListTile(
                                                    leading: Image.asset(
                                                      "assets/icons/private.png",
                                                      width: 28,
                                                      color: Color(0xFFFF9228),
                                                    ),
                                                    title: Text(
                                                        _profileController.profiles[
                                                                        'privateclient']
                                                                    ['user']
                                                                ['firstname'] +
                                                            " " +
                                                            _profileController
                                                                        .profiles[
                                                                    'privateclient']['user']
                                                                ['lastname'],
                                                        style:
                                                            GoogleFonts.poppins(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500)),
                                                    subtitle:
                                                        Text("Private Client"),
                                                    trailing: Radio(
                                                      value: 'privateclient',
                                                      groupValue:
                                                          selectedProfile,
                                                      onChanged: (value) {
                                                        setState(() {
                                                          selectedProfile =
                                                              value.toString();
                                                          if (selectedProfile ==
                                                              "privateclient") {
                                                            Get.offAll(
                                                                PrivateClientHomepage());
                                                          }
                                                        });
                                                      },
                                                    ),
                                                  ),
                                                  "private", () {
                                                Get.offAll(
                                                    PrivateClientHomepage());
                                              }),
                                            if (_profileController
                                                    .profiles["company"] !=
                                                null)
                                              _profileContainer(
                                                  ListTile(
                                                    leading: Image.asset(
                                                      "assets/icons/company.png",
                                                      width: 28,
                                                      color: Color(0xFFFF9228),
                                                    ),
                                                    title: Text(
                                                        _profileController
                                                                    .profiles[
                                                                "company"]
                                                            ["company_name"],
                                                        style:
                                                            GoogleFonts.poppins(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500)),
                                                    subtitle: Text("Company"),
                                                    trailing: Radio(
                                                      value: 'company',
                                                      groupValue:
                                                          selectedProfile,
                                                      onChanged: (value) {
                                                        setState(() {
                                                          selectedProfile =
                                                              value.toString();
                                                          if (selectedProfile ==
                                                              "company") {
                                                            Get.off(
                                                                CompanyHomepage());
                                                          }
                                                        });
                                                      },
                                                    ),
                                                  ),
                                                  "company", () {
                                                Get.offAll(CompanyHomepage());
                                              }),
                                            if (_profileController.profiles[
                                                        "privateclient"] ==
                                                    null ||
                                                _profileController
                                                        .profiles["company"] ==
                                                    null)
                                              Column(
                                                children: [
                                                  GestureDetector(
                                                    onTap: () {
                                                      Navigator.of(context).push(
                                                          MaterialPageRoute(
                                                              builder:
                                                                  (context) =>
                                                                      Profiles()));
                                                    },
                                                    child: Padding(
                                                      padding: const EdgeInsets.all(15.0),
                                                      child: Container(
                                                        width: 120,
                                                        height: 30,
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      20),
                                                          color: Color(
                                                              0xFF130160),
                                                        ),
                                                        child: Center(
                                                          child: Text(
                                                              "ADD ACCOUNT",
                                                              style: GoogleFonts.poppins(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .white)),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                          ],
                                          GestureDetector(
                                            onTap: () {
                                              _userAuthenticationController
                                                  .logout();
                                            },
                                            child: Container(
                                              width: 100,
                                              height: 30,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        20),
                                                color: Color(0xFF130160),
                                              ),
                                              child: Center(
                                                child: Text("LOGOUT",
                                                    style:
                                                        GoogleFonts.poppins(
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold,
                                                            color: Colors
                                                                .white)),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                );
                              },
                            );
                          },
                          child: Image.asset("assets/icons/switch.png")),
                    )
                  ],
                ),
                Obx(() {
                  if (_jobSeekerController.jobseeker.isEmpty) {
                    return FutureBuilder(
                        future: _jobSeekerController.getJobSeeker(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return CircularProgressIndicator(
                              strokeWidth: 2,
                              strokeAlign: -5,
                            );
                          } else if (snapshot.hasError) {
                            return Text("Error ${snapshot.error}");
                          } else if (snapshot.hasData) {
                            var jobseekerData =
                                snapshot.data as Map<String, dynamic>;
                            _jobSeekerController.jobseeker.value =
                                jobseekerData;
                            String firstname =
                                jobseekerData["jobseeker"]["user"]["firstname"];
                            return Text(
                              firstname,
                            );
                          } else {
                            return Text("No data found");
                          }
                        });
                  } else {
                    var jobSeekerData = _jobSeekerController.jobseeker;
                    String firstname =
                        jobSeekerData["jobseeker"]["user"]["firstname"];
                    return Text(firstname,
                        style: GoogleFonts.poppins(fontSize: 20));
                  }
                }),
                SizedBox(height: 15),
                Expanded(
                  child: PageView(
                    controller: _pageController,
                    onPageChanged: (index) {
                      setState(() {
                        currentindex = index;
                      });
                    },
                    children: [
                      ExplorePage(),
                      ApplicationPage(),
                    ],
                  ),
                ),
                BottomNavigationBar(
                  currentIndex: currentindex,
                  onTap: (index) {
                    if (index == 2) {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => JobseekerProfile()));
                    } else {
                      setState(() {
                        currentindex = index;
                        _pageController.jumpToPage(index);
                      });
                    }
                  },
                  items: [
                    BottomNavigationBarItem(
                      icon: Icon(Icons.explore),
                      label: 'Explore',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.description),
                      label: 'Applications',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.person),
                      label: 'Profile',
                    ),
                  ],
                  selectedItemColor: Colors.orange,
                  unselectedItemColor: Colors.black,
                  showUnselectedLabels: true,
                  elevation: 0,
                  selectedLabelStyle:
                      GoogleFonts.poppins(fontWeight: FontWeight.w400),
                )
              ],
            ),
          ),
        ));
  }

  Widget _profileContainer(
      Widget child, String value, VoidCallback onNavigator) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedProfile = value;
        });
        onNavigator();
      },
      child: Container(
        child: child,
      ),
    );
  }
}
