import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lab 3: Layout Basics',
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            'Lab 3: Layout Basics',
            style: TextStyle(
              color: Colors.white, 
              fontWeight: FontWeight.bold,
              fontSize: 20, 
            ),
          ),
          backgroundColor: Colors.teal, 
        ),
        backgroundColor: Colors.grey[300], 
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(16), 
                decoration: BoxDecoration(
                  color: Colors.blue, 
                  borderRadius: BorderRadius.circular(12), 
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2), 
                      offset: Offset(2, 2), 
                      blurRadius: 6, 
                  ],
                ),
                child: Center(
                  child: Text(
                    'Welcome to Flutter!',
                    textAlign: TextAlign.center, 
                    style: TextStyle(
                      color: Colors.white, 
                      fontSize: 18,
                      fontWeight: FontWeight.bold, 
                  ),
                ),
              ),
              SizedBox(height: 16),
              Container(
                padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20), 
                decoration: BoxDecoration(
                  color: Colors.green, 
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: Colors.white, 
                    width: 2, 
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween, 
                  children: [
                    Text(
                      'Left Text',
                      style: TextStyle(
                        color: Colors.white, 
                        fontSize: 16, 
                      ),
                    ),
                    Text(
                      'Right Text',
                      style: TextStyle(
                        color: Colors.white, 
                        fontSize: 16, 
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
