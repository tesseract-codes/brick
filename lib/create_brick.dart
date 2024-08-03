import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'brick_provider.dart';
import 'brick.dart';

class CreateBrickScreen extends StatefulWidget {
  @override
  _CreateBrickScreenState createState() => _CreateBrickScreenState();
}

class _CreateBrickScreenState extends State<CreateBrickScreen> {
  final _formKey = GlobalKey<FormState>();
  String _heading = '';
  String _message = '';
  int _intervalDays = 1;
  TimeOfDay _timeOfDay = TimeOfDay.now();

  void _saveForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      // Assuming _timeOfDay is the TimeOfDay instance, and _selectedDate is a DateTime instance for the selected date.
      final DateTime now = DateTime.now();
      final DateTime scheduledDateTime = DateTime(
        now.year,
        now.month,
        now.day,
        _timeOfDay.hour,
        _timeOfDay.minute,
      );

      final newBrick = Brick(
        heading: _heading,
        message: _message,
        intervalDays: _intervalDays,
        time: scheduledDateTime, // Use scheduledDateTime instead of _timeOfDay
        isActive: true,
      );

      Provider.of<BrickProvider>(context, listen: false).addBrick(newBrick);

      Navigator.of(context).pop();
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Brick'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(labelText: 'Heading'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a heading';
                  }
                  return null;
                },
                onSaved: (value) {
                  _heading = value!;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Message'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a message';
                  }
                  return null;
                },
                onSaved: (value) {
                  _message = value!;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Interval Days'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || int.tryParse(value) == null || int.parse(value) <= 0) {
                    return 'Please enter a valid number of days';
                  }
                  return null;
                },
                onSaved: (value) {
                  _intervalDays = int.parse(value!);
                },
              ),
              ListTile(
                title: Text('Time: ${_timeOfDay.format(context)}'),
                trailing: Icon(Icons.keyboard_arrow_down),
                onTap: _pickTime,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveForm,
                child: Text('Save Brick'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _pickTime() async {
    TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _timeOfDay,
    );
    if (picked != null) {
      setState(() {
        _timeOfDay = picked;
      });
    }
  }
}
