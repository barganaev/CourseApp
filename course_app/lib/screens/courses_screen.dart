import 'package:course_app/helpers/database_helper.dart';
import 'package:course_app/models/course.dart';
import 'package:course_app/screens/course_detail_screen.dart';
import 'package:course_app/widgets/modal_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CoursesScreen extends StatefulWidget {
  const CoursesScreen({super.key});

  @override
  State<CoursesScreen> createState() => _CoursesScreenState();
}

class _CoursesScreenState extends State<CoursesScreen> {
  final DatabaseHelper? _databaseHelper = DatabaseHelper();
  List<Course>? _courses = [];

  @override
  void initState() {
    super.initState();
    _loadCourses();
  }

  Future<void> _loadCourses() async {
    List<Course> courses = await _databaseHelper!.getCourses();
    print('---------> Loaded courses: $courses <---------');
    setState(() {
      _courses = courses;
    });
  }

  void _addCourse() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return AddCourseBottomSheet(
          onAdd: (Course course) async {
            await _databaseHelper?.insertCourse(course);
            await _loadCourses();
            Navigator.pop(context);
          },
        );
      },
    );
  }

  void _deleteCourse(int id) async {
    if (id == null) {
      // Handle the case where ID is null
      print("Cannot delete course: ID is null.");
      return;
    }

    final shouldDelete = await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Confirm Deletion'),
        content: Text('Are you sure you want to delete this course?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text('Delete'),
          ),
        ],
      ),
    );

    if (shouldDelete) {
      await _databaseHelper?.deleteCourse(id);
      _loadCourses();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Courses', 
          style: GoogleFonts.roboto(),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _addCourse,
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: _courses?.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(_courses![index].title, style: GoogleFonts.roboto()),
            subtitle: Text(_courses![index].subtitle),
            trailing: IconButton(
              icon: Icon(Icons.delete, color: Colors.red,),
              onPressed: () {
                _deleteCourse(_courses![index].id!);
              },
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CourseDetailScreen(course: _courses![index]),
                ),
              );
            },
          );
        },
      ),
    );
  }
}