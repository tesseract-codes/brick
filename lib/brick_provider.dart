import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'brick.dart';
import 'notification_helper.dart';
import 'package:flutter/material.dart';


class BrickProvider with ChangeNotifier {
  List<Brick> _bricks = [];

  List<Brick> get bricks => _bricks;

  BrickProvider() {
    _loadBricks();
  }

  void _loadBricks() async {
    final prefs = await SharedPreferences.getInstance();
    final brickList = prefs.getString('bricks');
    if (brickList != null) {
      _bricks = List<Brick>.from(
        (json.decode(brickList) as List).map((i) => Brick.fromJson(i)),
      );
      notifyListeners();
    }
  }

  void _saveBricks() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('bricks', json.encode(_bricks));
  }

  void addBrick(Brick brick) {
    _bricks.add(brick);
    _saveBricks();
    notifyListeners();
    _scheduleBrickNotification(brick);
  }

  void updateBrick(int index, Brick brick) {
    _bricks[index] = brick;
    _saveBricks();
    notifyListeners();
    _scheduleBrickNotification(brick);
  }

  void toggleBrickStatus(int index) {
    _bricks[index].isActive = !_bricks[index].isActive;
    _saveBricks();
    notifyListeners();
    if (_bricks[index].isActive) {
      _scheduleBrickNotification(_bricks[index]);
    } else {
      NotificationHelper.cancelNotification(index);
    }
  }

  void removeBrick(int index) {
    NotificationHelper.cancelNotification(index);
    _bricks.removeAt(index);
    _saveBricks();
    notifyListeners();
  }

  void _scheduleBrickNotification(Brick brick) {
    if (brick.isActive) {
      final TimeOfDay timeOfDay = TimeOfDay(hour: brick.time.hour, minute: brick.time.minute);

      NotificationHelper.scheduleNotification(
        id: _bricks.indexOf(brick),
        title: brick.heading,
        body: brick.message,
        intervalInDays: brick.intervalDays,
        timeOfDay: timeOfDay,
      );
    }
  }

}
