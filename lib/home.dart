import 'package:flutter/material.dart';
import 'package:watermark/pages/alarms.dart';
import 'package:watermark/pages/completed_tasks.dart';
import 'package:watermark/pages/data_entry.dart';
import 'package:watermark/pages/pending_tasks.dart';
import 'package:watermark/widgets/custom_nav_bar.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);


  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;
  String title = "Orders";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            title,
            style: TextStyle(
              fontFamily: "Poppins",
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.bold,
              fontSize: 16.0,
              color: Color(0xff777777),
            ),
          ),
          backgroundColor: Colors.white,
        ),
        body: getBody(),
        bottomNavigationBar: _buildBottomBar());
  }

  Widget _buildBottomBar() {

    return CustomAnimatedBottomBar(
      containerHeight: 60,
      backgroundColor: Color(0xff1C52DB),
      selectedIndex: _currentIndex,
      showElevation: true,
      itemCornerRadius: 7,
      curve: Curves.easeIn,
      onItemSelected: (index) => setState((){
        _currentIndex = index;
        setTitle();
      }),
      items: <BottomNavyBarItem>[
        BottomNavyBarItem(
          icon: Icons.data_usage,
          title: 'Data Entry',
          activeColor: Colors.white,
          inactiveColor: Colors.white,
          textAlign: TextAlign.center,
        ),
        BottomNavyBarItem(
          icon: Icons.assignment_late,
          title: 'Pending',
          activeColor: Colors.white,
          inactiveColor: Colors.white,
          textAlign: TextAlign.center,
        ),
        BottomNavyBarItem(
          icon: Icons.access_time,
          title: 'Completed',
          activeColor: Colors.white,
          inactiveColor: Colors.white,
          textAlign: TextAlign.center,
        ),
        BottomNavyBarItem(
          icon: Icons.timer_rounded,
          title: 'Alarms',
          activeColor: Colors.white,
          inactiveColor: Colors.white,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  void setTitle(){
    List<String> titles = ["Orders", "Pending Tasks", "Completed Tasks", "Alarms"];
    setState(() {
      this.title = titles[_currentIndex];
    });
  }


  Widget getBody() {
    List<Widget> pages = [
      DataEntry(),
      PendingTasks(),
      CompletedTasks(),
      Alarms(),
    ];
    return IndexedStack(
      index: _currentIndex,
      children: pages,
    );
  }
}
