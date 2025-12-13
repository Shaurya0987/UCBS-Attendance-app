// ignore_for_file: deprecated_member_use

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ucbs_attendance_app/colors/colors.dart';

class TeacherLogin extends StatefulWidget {
  const TeacherLogin({super.key});

  @override
  State<TeacherLogin> createState() => _TeacherLoginState();
}

class _TeacherLoginState extends State<TeacherLogin> {
  double opacity = 0.0;
  @override
  void initState() {
    Future.delayed(Duration(milliseconds: 500), () {
      setState(() {
        opacity = 1.0;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgDark,
      body: Stack(
        children: [
          Positioned(
            top: -10,
            right: -10,
            child: SvgPicture.asset(
              'assets/images/Shape 1.svg',
              width: 120,
              height: 120,
              color: Colors.deepOrange.withOpacity(0.7),
            ),
          ),
          Positioned(
            top: 650,
            right: -20,
            child: SvgPicture.asset(
              'assets/images/Shape 5.svg',
              width: 120,
              height: 120,
              color: Colors.deepOrange.withOpacity(0.7),
            ),
          ),
          Positioned(
            top: 80,
            left: -15,
            child: SvgPicture.asset(
              'assets/images/Shape 15.svg',
              width: 130,
              height: 130,
              color: Colors.deepOrange.withOpacity(0.7),
            ),
          ),
          Positioned(
            top: 450,
            left: -20,
            child: SvgPicture.asset(
              'assets/images/Shape 2.svg',
              width: 130,
              height: 130,
              color: Colors.deepOrange.withOpacity(0.7),
            ),
          ),

          Positioned(
            top: 100,
            left: 20,
            right: 20,
            child: AnimatedOpacity(
              opacity: opacity,

              duration: Duration(milliseconds: 1000),
              child: ClipRect(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                  child: Container(
                    height: 700,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.10),
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(
                        color: Colors.white.withOpacity(0.2),
                        width: 1,
                      ),
                    ),
                    child: Column(
                      children: [
                        SizedBox(height: 30),
                        Text(
                          'Enter Your Details',
                          style: GoogleFonts.dmSans(
                            color: AppColors.textPrimary,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Data will be pushed to Supabase \nwhen ai detects you as a human',
                          style: GoogleFonts.dmSans(
                            color: AppColors.textSecondary,
                            fontSize: 15,
                          ),
                        ),
                        SizedBox(height: 50),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Container(
                            height: 80,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.grey.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                ),
                                child: TextField(
                                  style: TextStyle(
                                    color: AppColors.textSecondary,
                                  ),
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hint: Text(
                                      'Enter Name',
                                      style: TextStyle(
                                        color: AppColors.textFaded,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
