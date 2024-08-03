# Brick - Notification App

## Overview

**Brick** is a productivity tool designed to help users set up daily reminders. The app allows users to create "Bricks," which are reminders consisting of a heading, message, and specific notification time. Users can set Bricks to repeat at custom intervals, ensuring they receive reminders even if the app is closed or the phone is off. 

## Features

- **Create Custom Bricks**: Users can create multiple reminders, each with a unique heading, message, and scheduled time.
- **Recurring Notifications**: Set reminders to repeat daily or at custom intervals, ensuring that important tasks are never forgotten.
- **Toggle Bricks On/Off**: Easily enable or disable Bricks as needed.
- **Notifications**: Receive push notifications for each active Brick, even when the app is not running.
- **User-Friendly Interface**: Simple and intuitive UI to manage and view all active and inactive Bricks.

## How It Works

1. **Creating a Brick**:
   - Tap the "+" button to add a new Brick.
   - Enter the heading and message for the reminder.
   - Set the time of day and the interval (in days) for the notification.
   - Save the Brick to activate the reminder.

2. **Managing Bricks**:
   - View a list of all created Bricks on the home screen.
   - Toggle the switch to activate or deactivate individual Bricks.
   - Edit or delete Bricks as needed.

3. **Notifications**:
   - Receive notifications at the specified times, reminding you of the task or message you set.
   - Notifications will repeat based on the interval set for each Brick.

## Technical Code Details

### Architecture

The app is developed using **Flutter**, a UI toolkit for building natively compiled applications for mobile from a single codebase. It utilizes a **Provider** package for state management and **flutter_local_notifications** for scheduling notifications.

### Key Components

- **Main.dart**: The entry point of the app. It initializes the app and sets up the routes.
- **Brick.dart**: A model class representing a Brick, containing attributes such as heading, message, time, and interval.
- **BrickProvider.dart**: A state management class that handles the creation, updating, deletion, and persistence of Bricks using SharedPreferences.
- **NotificationHelper.dart**: A helper class responsible for setting up and managing notifications, including scheduling and canceling them.

### Notifications

Notifications are scheduled using the `flutter_local_notifications` plugin. The `NotificationHelper` class includes methods to initialize the notification system, schedule notifications with a specific time and interval, and handle boot completion to reschedule notifications.

### Data Persistence

Bricks are stored using the `shared_preferences` package. The BrickProvider class manages the serialization and deserialization of Brick objects to and from JSON format, ensuring data persistence across app launches.

### Example Code Snippet

```dart
// Schedule a notification
NotificationHelper.scheduleNotification(
  id: brick.id,
  title: brick.heading,
  body: brick.message,
  intervalInDays: brick.intervalDays,
  timeOfDay: brick.time,
);

// Initialize notifications
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationHelper.initialize();
  runApp(MyApp());
}
```

## Permissions

The app requests the following permissions:
- **Vibration**: To provide haptic feedback for notifications.
- **Receive Boot Completed**: To reschedule notifications after the device restarts.

## Installation

1. Download the app from the Google Play Store (or install via APK).
2. Open the app and grant the necessary permissions.
3. Start creating your Bricks and receive timely reminders!

## Contributing

We welcome contributions to enhance the app's features and functionality. Please refer to the [Contributing Guidelines](CONTRIBUTING.md) for more information.
