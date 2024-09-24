import 'package:course_app/models/course.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CourseDetailScreen extends StatefulWidget {
  final Course course;
  CourseDetailScreen({required this.course});

  @override
  State<CourseDetailScreen> createState() => _CourseDetailScreenState();
}

class _CourseDetailScreenState extends State<CourseDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.course.title,
          style: GoogleFonts.roboto(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.course.title, style: GoogleFonts.roboto(fontSize: 24, fontWeight: FontWeight.bold),),
            const SizedBox(height: 10,),
            Text(widget.course.subtitle, style: GoogleFonts.roboto(fontSize: 16),),
            const SizedBox(height: 8,),
            Text(widget.course.description, style: GoogleFonts.roboto(fontSize: 16),),
          ],
        ),
      ),
    );
  }
}