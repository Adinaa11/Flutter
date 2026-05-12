import 'package:flutter/material.dart';
import 'activity_detail_page.dart';
import 'add_activity_page.dart';
import 'profile_page.dart'; // Pastikan file ini ada

class HomePage extends StatefulWidget {
  final String userEmail;
  HomePage({required this.userEmail});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  bool _isFabActive = false;

  // Dummy activity data
  final List<Map<String, dynamic>> activities = [
    {'title': 'Lari Pagi', 'date': '20 Juni 2025', 'time': '06:15', 'distance': '20.0 km', 'duration':'2:00:00', 'pace': '6\'00"/km', 'calories': '1200', 'note':'Lari pagi santai'},
    {'title': 'Easy Run', 'date': '18 Juni 2025', 'time': '06:45', 'distance': '10.2 km', 'duration':'1:02:30', 'pace': '6\'07"/km', 'calories': '600'},
    {'title': 'Lari Sore', 'date': '16 Juni 2025', 'time': '16:30', 'distance': '7.5 km', 'duration':'45:20', 'pace': '6\'02"/km', 'calories': '400'},
  ];

  void _onTabSelected(int index) {
    setState(() {
      _selectedIndex = index;
      _isFabActive = false;
    });
  }

  void _onAddPressed() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AddActivityPage()),
    );

    if (result != null) {
      setState(() {
        activities.insert(0, result);
        _isFabActive = true; // Highlight FAB saat baru tambah
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Color backgroundColor = Color(0xFFF5F4FF);

    // Inisialisasi bodyContent dengan default supaya tidak null
    Widget bodyContent = Container();

    // Pilih bodyContent sesuai selectedIndex
    if (_selectedIndex == 0) {
      // Home Page
      bodyContent = SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.deepPurple,
                    child: Text(widget.userEmail[0].toUpperCase(), style: TextStyle(color: Colors.white)),
                  ),
                  IconButton(icon: Icon(Icons.notifications, color: Colors.black87), onPressed: () {}),
                ],
              ),
              SizedBox(height: 12),
              Text("Halo, ${widget.userEmail}", style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold, fontSize: 20)),
              SizedBox(height: 4),
              Text("Siap untuk lari hari ini? 💪", style: TextStyle(color: Colors.black54)),
              SizedBox(height: 20),

              // Ringkasan Minggu Ini
              Text("Ringkasan Minggu Ini", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87)),
              SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _statCard("Jarak", "37.7", "km", Colors.purple, Icons.directions_run),
                  _statCard("Durasi", "3:47:50", "jam", Colors.blue, Icons.access_time),
                  _statCard("Kalori", "2.560", "kcal", Colors.orange, Icons.local_fire_department),
                  _statCard("Aktivitas", "3", "kali", Colors.green, Icons.show_chart),
                ],
              ),
              SizedBox(height: 20),

              // Recent Activities
              Text("Aktivitas Terakhir", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87)),
              SizedBox(height: 12),
              Column(children: activities.map((act) => activityCard(act)).toList()),
            ],
          ),
        ),
      );
    } else if (_selectedIndex == 1) {
      // Profile Page
      bodyContent = ProfilePage(userEmail: widget.userEmail);
    }

    return Scaffold(
      backgroundColor: backgroundColor,
      body: bodyContent,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: _onAddPressed,
        backgroundColor: _isFabActive ? Colors.orange.shade700 : Colors.grey.shade700,
        child: Icon(Icons.add),
      ),
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 6,
        color: backgroundColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: Icon(Icons.home, color: _selectedIndex == 0 ? Colors.orange : Colors.black87),
              onPressed: () => _onTabSelected(0),
            ),
            SizedBox(width: 48),
            IconButton(
              icon: Icon(Icons.person, color: _selectedIndex == 1 ? Colors.orange : Colors.black87),
              onPressed: () => _onTabSelected(1),
            ),
          ],
        ),
      ),
    );
  }

  Widget _statCard(String title, String value, String unit, Color color, IconData icon) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
      ),
      width: 80,
      child: Column(
        children: [
          Icon(icon, color: color),
          SizedBox(height: 6),
          Text(title, style: TextStyle(color: Colors.black54, fontSize: 12)),
          SizedBox(height: 4),
          Text(value, style: TextStyle(fontWeight: FontWeight.bold)),
          Text(unit, style: TextStyle(color: color, fontSize: 10)),
        ],
      ),
    );
  }

  Widget activityCard(Map<String, dynamic> act) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (_) => ActivityDetailPage(activity: act)));
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 12),
        padding: EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 3))],
        ),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: Colors.deepPurple.withOpacity(0.2),
              child: Icon(Icons.directions_run, color: Colors.deepPurple),
            ),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(act['title'], style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black87)),
                  SizedBox(height: 4),
                  Text("${act['date']} • ${act['time']}", style: TextStyle(color: Colors.black54, fontSize: 12)),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(act['distance'], style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 4),
                Text("${act['duration']} • ${act['pace']}", style: TextStyle(color: Colors.black54, fontSize: 12)),
              ],
            )
          ],
        ),
      ),
    );
  }
}