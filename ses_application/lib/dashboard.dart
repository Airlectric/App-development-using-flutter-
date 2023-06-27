import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  bool showCourses = true;
  bool showGrades = true;
  bool showAssignments = true;
  bool showProjects = true;
  bool showTimetable = true;

  final List<Map<String, dynamic>> enrolledCourses = [
    {'id': 1, 'name': 'Data Structures', 'credit': '3'},
    {'id': 2, 'name': 'CBAS 210', 'credit': '3'},
    {'id': 3, 'name': 'Digital Circuits Design', 'credit': '3'},
    {'id': 4, 'name': 'Differential Equations', 'credit': '4'},
    {'id': 5, 'name': 'Software Engineering', 'credit': '3'},
    {'id': 6, 'name': 'Data communications', 'credit': '3'},
  ];

  final List<Map<String, dynamic>> previousSemesterResults = [
    {'id': 1, 'course': 'Python', 'credit': '3', 'grade': 'A'},
    {'id': 2, 'course': 'Discrete Maths', 'credit': '3', 'grade': 'A'},
    {'id': 3, 'course': 'Digital Circuits', 'credit': '3', 'grade': 'A'},
  ];

  double calculateGPA() {
    final Map<String, double> gradePoints = {
      'A': 4.0,
      'B': 3.0,
      'C': 2.0,
      'D': 1.0,
      'F': 0.0,
    };

    double totalCredits = 0;
    double totalGradePoints = 0;

    previousSemesterResults.forEach((result) {
      final double credit = double.parse(result['credit'].toString());
      final double gradePoint = gradePoints[result['grade'].toString()]!;

      totalCredits += credit;
      totalGradePoints += credit * gradePoint;
    });

    final double gpa = totalGradePoints / totalCredits;
    return double.parse(gpa.toStringAsFixed(2));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[900],
        title: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Image.asset(
                'lib/assets/new_ses.png',
                height: 30.0,
              ),
            ),
            Text('Dashboard'),
          ],
        ),
      ),
      body: Container(
        color: Color(0xFFE8EDF5),
        child: ListView(
          padding: EdgeInsets.all(20.0),
          children: [
            _buildProfileSection(),
            SizedBox(height: 20.0),
            _buildNavigationSection(),
            SizedBox(height: 20.0),
            if (showCourses) _buildCoursesSection(),
            if (showGrades) _buildGradesSection(),
            if (showAssignments) _buildAssignmentsSection(),
            if (showProjects) _buildProjectsSection(),
            if (showTimetable) _buildTimetableSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileSection() {
    return Card(
      elevation: 2.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Container(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 40,
              backgroundImage: AssetImage('lib/assets/dp.png'),
            ),
            SizedBox(height: 10.0),
            Text(
              'John Doe',
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5.0),
            Text(
              'Student',
              style: TextStyle(fontSize: 16.0, color: Colors.grey[600]),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavigationSection() {
    return Card(
      elevation: 2.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Container(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Navigation',
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20.0),
            _buildNavigationItem(
              icon: Icons.book,
              title: 'Courses',
              value: showCourses,
              onChanged: (value) {
                setState(() {
                  showCourses = value;
                });
              },
            ),
            _buildNavigationItem(
              icon: Icons.grade,
              title: 'Grades',
              value: showGrades,
              onChanged: (value) {
                setState(() {
                  showGrades = value;
                });
              },
            ),
            _buildNavigationItem(
              icon: Icons.assignment,
              title: 'Assignments',
              value: showAssignments,
              onChanged: (value) {
                setState(() {
                  showAssignments = value;
                });
              },
            ),
            _buildNavigationItem(
              icon: Icons.work,
              title: 'Projects',
              value: showProjects,
              onChanged: (value) {
                setState(() {
                  showProjects = value;
                });
              },
            ),
            _buildNavigationItem(
              icon: Icons.event,
              title: 'Timetable',
              value: showTimetable,
              onChanged: (value) {
                setState(() {
                  showTimetable = value;
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavigationItem({
    required IconData icon,
    required String title,
    required bool value,
    required Function(bool) onChanged,
  }) {
    return Row(
      children: [
        Icon(
          icon,
          size: 30.0,
          color: Colors.grey[600],
        ),
        SizedBox(width: 10.0),
        Expanded(
          child: Text(
            title,
            style: TextStyle(fontSize: 18.0),
          ),
        ),
        Switch(
          value: value,
          onChanged: onChanged,
        ),
      ],
    );
  }

  Widget _buildCoursesSection() {
    return Card(
      elevation: 2.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Container(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Enrolled Courses',
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20.0),
            for (final course in enrolledCourses)
              ListTile(
                title: Text(course['name']),
                subtitle: Text('Credit: ${course['credit']}'),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildGradesSection() {
    double gpa = calculateGPA();

    return Card(
      elevation: 2.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Container(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Previous Semester Results',
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20.0),
            for (final result in previousSemesterResults)
              ListTile(
                title: Text(result['course']),
                subtitle: Text(
                    'Credit: ${result['credit']} Grade: ${result['grade']}'),
              ),
            SizedBox(height: 20.0),
            Text(
              'GPA: $gpa',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAssignmentsSection() {
    final List<Map<String, dynamic>> assignments = [
      {'id': 1, 'title': 'Assignment 1', 'dueDate': 'June 30, 2023'},
      {'id': 2, 'title': 'Assignment 2', 'dueDate': 'July 7, 2023'},
      {'id': 3, 'title': 'Assignment 3', 'dueDate': 'July 14, 2023'},
    ];

    return Card(
      elevation: 2.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Container(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Assignments',
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20.0),
            for (final assignment in assignments)
              ListTile(
                title: Text(assignment['title']),
                subtitle: Text('Due Date: ${assignment['dueDate']}'),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildProjectsSection() {
    final List<Map<String, dynamic>> projects = [
      {'id': 1, 'title': 'Project 1', 'dueDate': 'July 21, 2023'},
      {'id': 2, 'title': 'Project 2', 'dueDate': 'July 28, 2023'},
      {'id': 3, 'title': 'Project 3', 'dueDate': 'August 4, 2023'},
    ];

    return Card(
      elevation: 2.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Container(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Projects',
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20.0),
            for (final project in projects)
              ListTile(
                title: Text(project['title']),
                subtitle: Text('Due Date: ${project['dueDate']}'),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildTimetableSection() {
    return Card(
      elevation: 2.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Container(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Timetable',
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20.0),
            // Add your timetable widget here
          ],
        ),
      ),
    );
  }
}
