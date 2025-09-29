import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Image and Button Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool showFirstImage = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Image and Button Demo')),
      body: Stack(
        children: [
          Image.asset(
            showFirstImage ? 'assets/image1.jpg' : 'assets/image2.jpg',
            fit: BoxFit.cover, 
            height: double.infinity,
            width: double.infinity,
            alignment: Alignment.center,
          ),
          Container(
            color: Colors.black.withOpacity(0.5),
            height: double.infinity,
            width: double.infinity,
          ),
          Center(
            child: Text(
              'Welcome to Flutter',
              style: TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('SnackBar shown!')),
                );
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.blue,  
                fixedSize: Size(200, 50), 
              ),
              child: Text(
                'Show SnackBar',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
            SizedBox(height: 10),
            TextButton(
              onPressed: () {
              },
              style: TextButton.styleFrom(
                primary: Colors.green,  
                fixedSize: Size(200, 50),  
              ),
              child: Text(
                'Go to Second Screen',
                style: TextStyle(fontSize: 16),
              ),
            ),
            SizedBox(height: 10),
            OutlinedButton(
              onPressed: () {
                setState(() {
                  showFirstImage = !showFirstImage; 
                });
              },
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: Colors.black),
                fixedSize: Size(200, 50), 
              ),
              child: Text(
                'Toggle Image',
                style: TextStyle(fontSize: 16, color: Colors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
