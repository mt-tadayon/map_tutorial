import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final List<int> expenses = [];

  TextEditingController _controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _controller,
                  decoration: InputDecoration(
                    labelText: 'Add Your Expenses',
                  ),
                ),
              ),
              IconButton(
                onPressed: () {
                  ///Add expenses in the table
                },
                icon: Icon(
                  Icons.add_circle,
                  size: 42,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
