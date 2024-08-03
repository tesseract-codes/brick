import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'brick_provider.dart';
import 'create_brick.dart';
import 'brick.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bricks'),
      ),
      body: Consumer<BrickProvider>(
        builder: (context, brickProvider, child) {
          return ListView.builder(
            itemCount: brickProvider.bricks.length,
            itemBuilder: (context, index) {
              final brick = brickProvider.bricks[index];
              return ListTile(
                title: Text(brick.heading),
                subtitle: Text('Every ${brick.intervalDays} day(s) at ${brick.time}'),
                trailing: Switch(
                  value: brick.isActive,
                  onChanged: (value) {
                    brickProvider.toggleBrickStatus(index);
                  },
                ),
                onTap: () {
                  // Navigate to edit brick screen (if needed)
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => CreateBrickScreen(),
          ),
        );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
