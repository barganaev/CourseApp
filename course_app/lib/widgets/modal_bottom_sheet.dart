import 'package:course_app/models/course.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AddCourseBottomSheet extends StatefulWidget {
  final Function(Course) onAdd;

  AddCourseBottomSheet({required this.onAdd});

  @override
  State<AddCourseBottomSheet> createState() => _AddCourseBottomSheetState();
}

class _AddCourseBottomSheetState extends State<AddCourseBottomSheet> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _subtitleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _subtitleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Add New Course', style: GoogleFonts.roboto(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: 16),
            Text('Title:', style: GoogleFonts.roboto(fontSize: 18)),
            TextField(
              controller: _titleController,
              decoration: InputDecoration(hintText: 'Enter course title'),
            ),
            Text('Subtitle:', style: GoogleFonts.roboto(fontSize: 18)),
            TextField(
              controller: _subtitleController,
              decoration: InputDecoration(hintText: 'Enter course subtitle'),
            ),
            SizedBox(height: 16),
            Text('Description:', style: GoogleFonts.roboto(fontSize: 18)),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(hintText: 'Enter course description'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final newCourse = Course(
                  _titleController.text,
                  _subtitleController.text,
                  _descriptionController.text,
                );
                widget.onAdd(newCourse);
              },
              child: Text('Add Course', style: GoogleFonts.roboto()),
            ),
          ],
        ),
      ),
    );
  }
}