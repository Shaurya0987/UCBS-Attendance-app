import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ucbs_attendance_app/colors/colors.dart';

class RoleSelection extends StatefulWidget {
  const RoleSelection({super.key});

  @override
  State<RoleSelection> createState() => _RoleSelectionState();
}

class _RoleSelectionState extends State<RoleSelection> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgDark,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 30),

              // Title
              Text(
                'Choose Your Role',
                style: GoogleFonts.poppins(
                  fontSize: 32,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),

              const SizedBox(height: 10),

              Text(
                "Select how you want to continue.\nYour experience will be customized based on your role.",
                style: GoogleFonts.poppins(
                  fontSize: 15,
                  color: AppColors.textSecondary,
                  height: 1.4,
                ),
              ),

              const SizedBox(height: 40),

              // TEACHER CARD
              RoleSelectionContainer(
                role: 'Teacher',
                subtitle:
                    "• Manage class attendance instantly\n"
                    "• View student performance analytics\n"
                    "• Create announcements & control sessions",
                icon: Icons.school_rounded,
                color: AppColors.accentBlue,
                ontap: () {},
              ),

              // STUDENT CARD
              RoleSelectionContainer(
                role: 'Student',
                subtitle:
                    "• Mark attendance using face recognition\n"
                    "• Track daily & monthly attendance\n"
                    "• Receive important class updates",
                icon: Icons.person_rounded,
                color: AppColors.accentPurple,
                ontap: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class RoleSelectionContainer extends StatefulWidget {
  final VoidCallback ontap;
  final String role;
  final String subtitle;
  final IconData icon;
  final Color color;

  const RoleSelectionContainer({
    super.key,
    required this.role,
    required this.subtitle,
    required this.icon,
    required this.color,
    required this.ontap,
  });

  @override
  State<RoleSelectionContainer> createState() => _RoleSelectionContainerState();
}

class _RoleSelectionContainerState extends State<RoleSelectionContainer> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 180),
      curve: Curves.easeOut,
      margin: const EdgeInsets.only(bottom: 22),
      child: GestureDetector(
        onTapDown: (_) => setState(() => _pressed = true),
        onTapUp: (_) => setState(() => _pressed = false),
        onTapCancel: () => setState(() => _pressed = false),
        onTap: widget.ontap,
        child: AnimatedContainer(
          duration: Duration(milliseconds: 200),
          transform: Matrix4.identity()..scaleAdjoint(_pressed ? 0.97 : 1.0),
          height: 190,
          decoration: BoxDecoration(
            color: widget.color.withValues(alpha: 0.10),
            borderRadius: BorderRadius.circular(30),
            border: Border.all(
              color: widget.color.withValues(alpha: 0.5),
              width: 1.5,
            ),
            boxShadow: [
              BoxShadow(
                color: widget.color.withValues(alpha: 0.15),
                blurRadius: 20,
                offset: Offset(0, 6),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                width: 120,
                decoration: BoxDecoration(
                  color: widget.color.withValues(alpha: 0.25),
                  borderRadius: const BorderRadius.horizontal(
                    left: Radius.circular(30),
                  ),
                ),
                child: Icon(widget.icon, size: 60, color: Colors.white),
              ),

              // Text Area
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.role,
                        style: GoogleFonts.poppins(
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        widget.subtitle,
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: AppColors.textSecondary,
                          height: 1.35,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
