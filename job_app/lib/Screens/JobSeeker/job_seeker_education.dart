// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:job_app/Controllers/JobSeeker/education_controller.dart';
import 'package:job_app/Screens/JobSeeker/Jobseeker/jobseeker_profile.dart';
import 'package:job_app/Screens/JobSeeker/job_seeker_experience.dart';
import 'package:job_app/Widgets/JobSeeker/build_text_form.dart';

class JobSeekerCreateSecond extends StatefulWidget {
  final bool isediting;
  const JobSeekerCreateSecond({super.key, this.isediting = false});

  @override
  State<JobSeekerCreateSecond> createState() => _JobSeekerCreateSecondState();
}

class _JobSeekerCreateSecondState extends State<JobSeekerCreateSecond> {
  final EducationController _educationController =
      Get.put(EducationController());
  final TextEditingController _institutionController = TextEditingController();
  final TextEditingController _levelofeducation = TextEditingController();
  final TextEditingController _field = TextEditingController();
  final TextEditingController _startDate = TextEditingController();
  final TextEditingController _edndate = TextEditingController();
  final TextEditingController _description = TextEditingController();
  var educationDetails = {};
  final box = GetStorage();
  DateTime? selectedDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            margin: EdgeInsets.only(right: 25, left: 25, bottom: 25, top: 50),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Add Education",
                  style: GoogleFonts.poppins(
                      color: Color(0xFF150B3D),
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Text(
                    "Showcase your academic background, including the institution you attended and the degrees you earned."),
                SizedBox(height: 20),
                buildTextFormField("Institution name", _institutionController),
                SizedBox(height: 10),
                buildTextFormField("Level of education", _levelofeducation),
                SizedBox(height: 10),
                buildTextFormField("Field of study", _field),
                SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: buildDateField("Start Date", _startDate),
                    ),
                    SizedBox(width: 20),
                    Expanded(
                      child: buildDateField("End Date", _edndate),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                buildTextFormField("Description", _description),
                SizedBox(height: 40),
                Center(
                  child: GestureDetector(
                    onTap: () async {
                      int jobseeker = box.read("jobseekerId");
                      List<int> educationIds = _educationController
                          .educationDetails
                          .map<int>((education) {
                        return education["id"];
                      }).toList();
                      await _educationController.updateeducation(
                          jobseekerid: jobseeker,
                          educationid: educationIds[0],
                          institution: _institutionController.text.trim(),
                          field: _field.text.trim(),
                          eduLevel: _levelofeducation.text.trim(),
                          eduStart: _startDate.text.trim(),
                          eduEnd: _edndate.text.trim(),
                          eduDescription: _description.text.trim());
                    },
                    child: Container(
                      margin: EdgeInsets.only(top: 30, bottom: 20),
                      width: 266,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Color(0xFF130160).withOpacity(0.7),
                      ),
                      child: Center(
                        child: Text("SAVE",
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.bold,
                                color: Colors.white)),
                      ),
                    ),
                  ),
                ),
                if (widget.isediting)
                  Obx(() {
                    if (_educationController.updatedSucsessfully.value ==
                        true) {
                      Future.delayed(Duration.zero, () {
                        sucessfullyUpdated(context);
                      });
                    }
                    return SizedBox.shrink();
                  }),
                if (!widget.isediting)
                  Center(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => JobSeekerExperience()));
                      },
                      child: Container(
                        margin: EdgeInsets.only(bottom: 80),
                        width: 266,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Color(0xFF130160).withOpacity(0.7),
                        ),
                        child: Center(
                          child: Text("NOT NOW",
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white)),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void sucessfullyUpdated(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text("Success", style: GoogleFonts.poppins()),
              content: Text("Education updated sucessfully",
                  style: GoogleFonts.poppins()),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      Navigator.of(context).pop();
                      Navigator.of(context).pop();
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: ((context) => JobseekerProfile())));
                      _educationController.updatedSucsessfully.value = false;
                    },
                    child: Text(
                      "Ok",
                      style: GoogleFonts.poppins(),
                    ))
              ],
            ));
  }
}
