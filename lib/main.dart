import 'dart:async';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:splash_screen_view/SplashScreenView.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 5),
        () => Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => SecondSplashScreen())));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blueGrey.shade900,
      child:FlutterLogo(),
      //Image.asset("assets/c.jpg", scale: 5,  ),
    );
  }
}

class SecondSplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SplashScreenView(
        navigateRoute: HomeScreen(),
        duration: 3000,
        imageSize: 200,
        imageSrc: 'assets/c.jpg',
        backgroundColor: Colors.white,

      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime pickedDate;
  TimeOfDay time;

  @override
  void initState() {
    super.initState();
    pickedDate = DateTime.now();
    time = TimeOfDay.now();
  }

  @override
  Widget build(BuildContext context) {
    _pickDate() async {
      DateTime date = await showDatePicker(
        context: context,
        firstDate: DateTime(DateTime.now().year - 10),
        lastDate: DateTime(DateTime.now().year + 10),
        initialDate: pickedDate,
        helpText: "Select Date",
      );
      if (date != null)
        setState(() {
          pickedDate = date;
        });
    }

    _pickTime() async {
      TimeOfDay t = await showTimePicker(context: context, initialTime: time);

      if (t != null)
        setState(() {
          time = t;
        });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
           backgroundColor: Colors.blueGrey.shade900,
          content:
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            Text(
                "Date: ${pickedDate.day}/${pickedDate.month}/${pickedDate.year}"),
            SizedBox(
              width: 80,
            ),
            Text("Time: ${time.hour}:${time.minute}")
          ]),
          action: SnackBarAction(
            label: "",
            textColor: Colors.white,
            onPressed: () {},
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      appBar: AppBar(
        title: Text("DateTimePicker"),
        centerTitle: true,
        backgroundColor: Colors.blueGrey.shade900,
      ),
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text(
            "Time: ${time.hour}:${time.minute}",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            "Date: ${pickedDate.day}/${pickedDate.month}/${pickedDate.year}",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
            InkWell(
              child:ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: Text(
                  "Select Date And Time",
                  style: TextStyle(
                    color: Colors.white,
                    backgroundColor: Colors.blueGrey.shade800,
                    fontSize: 25.0,
                  ),
                ),
              ),
              onTap: () {
                _pickDate().then((value) => _pickTime());
              },
            ),
          ]),
          // HomeScreen(),
        ]),
      ),
    );
  }
}
