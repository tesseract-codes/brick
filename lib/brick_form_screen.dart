import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'brick_provider.dart';
import 'brick.dart';

class BrickFormScreen extends StatefulWidget {
  final Brick? existingBrick;
  final int? index;

  BrickFormScreen({this.existingBrick, this.index});

  @override
  _BrickFormScreenState createState() => _BrickFormScreenState();
}

class _BrickFormScreenState extends State<BrickFormScreen> {
  final _formKey = GlobalKey<FormState>();
  late String _heading;
  late String _message;
  late TimeOfDay _time;
  late int _intervalDays;
  late bool _isActive;

  @override
  void initState() {
    super.initState();
    if (widget.existingBrick != null) {
      _heading = widget.existingBrick!.heading;
      _message = widget.existingBrick!.message;
      _time = TimeOfDay.fromDateTime(widget.existingBrick!.time);
      _intervalDays = widget.existingBrick!.intervalDays;
      _isActive = widget.existingBrick!.isActive;
    } else {
      _heading = '';
      _message = '';
      _time = TimeOfDay.now();
      _intervalDays = 1;
      _isActive = true;
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _time,
    );
    if (picked != null && picked != _time) {
      setState(() {
        _time = picked;
      });
    }
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final newBrick = Brick(
        heading: _heading,
        message: _message,
        time: DateTime(0, 0, 0, _time.hour, _time.minute),
        intervalDays: _intervalDays,
        isActive: _isActive,
      );

      if (widget.existingBrick != null) {
        Provider.of<BrickProvider>(context, listen: false).updateBrick(widget.index!, newBrick);
      } else {
        Provider.of<BrickProvider>(context, listen: false).addBrick(newBrick);
      }

      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.existingBrick != null ? 'Edit Brick' : 'New Brick'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              TextFormField(
                initialValue: _heading,
                decoration: InputDecoration(labelText: 'Heading'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a heading';
                  }
                  return null;
                },
                onSaved: (value) {
                  _heading = value!;
                },
              ),
              TextFormField(
                initialValue: _message,
                decoration: InputDecoration(labelText: 'Message'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a message';
                  }
                  return null;
                },
                onSaved: (value) {
                  _message = value!;
                },
              ),
              ListTile(
                title: Text('Time: ${_time.format(context)}'),
                trailing: Icon(Icons.keyboard_arrow_down),
                onTap: () => _selectTime(context),
              ),
              TextFormField(
                initialValue: _intervalDays.toString(),
                decoration: InputDecoration(labelText: 'Interval (Days)'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter an interval';
                  }
                  if (int.tryParse(value) == null || int.parse(value) <= 0) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
                onSaved: (value) {
                  _intervalDays = int.parse(value!);
                },
              ),
              SwitchListTile(
                title: Text('Active'),
                value: _isActive,
                onChanged: (value) {
                  setState(() {
                    _isActive = value;
                  });
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitForm,
                child: Text(widget.existingBrick != null ? 'Update' : 'Create'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
