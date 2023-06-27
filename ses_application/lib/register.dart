import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class RegistrationForm extends StatefulWidget {
  @override
  _RegistrationFormState createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? genderValue;
  DateTime? selectedDate;
  bool submitted = false;

  void handleSubmit() {
    if (_formKey.currentState!.validate()) {
      // Perform registration logic here

      setState(() {
        submitted = true;
      });
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (pickedDate != null) {
      setState(() {
        selectedDate = pickedDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[900],
        title: Text('Register an SES account.'),
        centerTitle: true,
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(20.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your first name';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: 'First name',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 20.0),
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your last name';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: 'Last name',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 20.0),
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }
                      // Add additional email validation logic if required
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 20.0),
                  DropdownButtonFormField<String>(
                    value: genderValue,
                    onChanged: (newValue) {
                      setState(() {
                        genderValue = newValue!;
                      });
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please select your gender';
                      }
                      return null;
                    },
                    items: [
                      DropdownMenuItem<String>(
                        value: '', // Add a default value
                        child: Text('Select gender'),
                      ),
                      DropdownMenuItem<String>(
                        value: 'Male',
                        child: Text('Male'),
                      ),
                      DropdownMenuItem<String>(
                        value: 'Female',
                        child: Text('Female'),
                      ),
                      DropdownMenuItem<String>(
                        value: 'Other',
                        child: Text('Other'),
                      ),
                    ],
                    decoration: InputDecoration(
                      labelText: 'Gender',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 20.0),
                  GestureDetector(
                    onTap: () => _selectDate(context),
                    child: InputDecorator(
                      decoration: InputDecoration(
                        labelText: 'Date of Birth',
                        border: OutlineInputBorder(),
                      ),
                      child: Text(selectedDate != null
                          ? DateFormat('yyyy-MM-dd').format(selectedDate!)
                          : 'Select date'),
                    ),
                  ),
                  SizedBox(height: 20.0),
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your address';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: 'Address',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 20.0),
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your phone number';
                      }
                      // Add additional phone number validation logic if required
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: 'Phone Number',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 20.0),
                  TextFormField(
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      // Add additional password validation logic if required
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: 'Password',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 20.0),
                  TextFormField(
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please confirm your password';
                      }
                      if (value != 'password') {
                        return 'Passwords do not match';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: 'Confirm Password',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 20.0),
                  ElevatedButton(
                    onPressed: handleSubmit,
                    style: ElevatedButton.styleFrom(
                      primary: Color.fromARGB(255, 42, 28, 238), // Set the button color to blue
                      padding: EdgeInsets.symmetric(
                          vertical: 16.0,
                          horizontal: 24.0), // Increase the padding
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(8.0), // Set the border radius
                      ),
                    ),
                    child: Text(
                      'Register',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white, // Set the text color to white
                      ),
                    ),
                  ),
                  SizedBox(height: 20.0),
                  if (submitted)
                    Container(
                      padding: EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      child: Text(
                        'Registration successful! Welcome!',
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
