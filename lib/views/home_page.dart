import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/activity_model.dart';
import '../viewmodels/activity_viewmodel.dart';

import 'activity_detail_page.dart';
import 'add_activity_page.dart';
import 'profile_page.dart';

class HomePage extends StatefulWidget {
  final String userEmail;

  const HomePage({super.key, required this.userEmail});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  bool _isFabActive = false;

  void _onTabSelected(int index) {
    setState(() {
      _selectedIndex = index;
      _isFabActive = false;
    });
  }

  void _onAddPressed() async {
    final newActivity = await Navigator.push<ActivityModel>(
      context,

      MaterialPageRoute(builder: (context) => const AddActivityPage()),
    );

    if (newActivity != null) {
      Provider.of<ActivityViewModel>(
        context,
        listen: false,
      ).addActivity(newActivity);

      // NOTIFIKASI BERHASIL TAMBAH
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Aktivitas berhasil ditambahkan"),
          backgroundColor: Colors.green,
        ),
      );
    }

    setState(() {
      _isFabActive = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    Color backgroundColor = const Color(0xFFF5F4FF);

    Widget bodyContent = Container();

    if (_selectedIndex == 0) {
      bodyContent = SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,

                children: [
                  CircleAvatar(
                    backgroundColor: Colors.deepPurple,

                    child: Text(
                      widget.userEmail[0].toUpperCase(),

                      style: const TextStyle(color: Colors.white),
                    ),
                  ),

                  IconButton(
                    icon: const Icon(
                      Icons.notifications,
                      color: Colors.black87,
                    ),
                    onPressed: () {},
                  ),
                ],
              ),

              const SizedBox(height: 12),

              Text(
                "Halo, ${widget.userEmail}",

                style: const TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),

              const SizedBox(height: 4),

              const Text(
                "Siap untuk lari hari ini? 💪",

                style: TextStyle(color: Colors.black54),
              ),

              const SizedBox(height: 20),

              // Ringkasan Minggu Ini
              const Text(
                "Ringkasan Minggu Ini",

                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),

              const SizedBox(height: 12),

              Consumer<ActivityViewModel>(
                builder: (context, vm, child) {
                  final stats = vm.computeStats();

                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _statCard(
                        "Jarak",
                        "${stats['totalDistance']}",
                        "km",
                        Colors.purple,
                        Icons.directions_run,
                      ),
                      _statCard(
                        "Durasi",
                        stats['totalDuration'],
                        "jam",
                        Colors.blue,
                        Icons.access_time,
                      ),
                      _statCard(
                        "Kalori",
                        "${stats['totalCalories']}",
                        "kcal",
                        Colors.orange,
                        Icons.local_fire_department,
                      ),
                      _statCard(
                        "Aktivitas",
                        "${stats['totalActivities']}",
                        "kali",
                        Colors.green,
                        Icons.show_chart,
                      ),
                    ],
                  );
                },
              ),

              const SizedBox(height: 20),

              // Recent Activities
              const Text(
                "Aktivitas Terakhir",

                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),

              const SizedBox(height: 12),

              Consumer<ActivityViewModel>(
                builder: (context, vm, child) {
                  return Column(
                    children: vm.activities
                        .map((act) => activityCard(act))
                        .toList(),
                  );
                },
              ),
            ],
          ),
        ),
      );
    } else if (_selectedIndex == 1) {
      bodyContent = ProfilePage(userEmail: widget.userEmail);
    }

    return Scaffold(
      backgroundColor: backgroundColor,
      body: bodyContent,

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      floatingActionButton: FloatingActionButton(
        onPressed: _onAddPressed,

        backgroundColor: _isFabActive
            ? Colors.orange.shade700
            : Colors.grey.shade700,

        child: const Icon(Icons.add),
      ),

      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 6,
        color: backgroundColor,

        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,

          children: [
            IconButton(
              icon: Icon(
                Icons.home,

                color: _selectedIndex == 0 ? Colors.orange : Colors.black87,
              ),

              onPressed: () => _onTabSelected(0),
            ),

            const SizedBox(width: 48),

            IconButton(
              icon: Icon(
                Icons.person,

                color: _selectedIndex == 1 ? Colors.orange : Colors.black87,
              ),

              onPressed: () => _onTabSelected(1),
            ),
          ],
        ),
      ),
    );
  }

  Widget _statCard(
    String title,
    String value,
    String unit,
    Color color,
    IconData icon,
  ) {
    return Container(
      padding: const EdgeInsets.all(12),

      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
      ),

      width: 85,

      child: Column(
        children: [
          Icon(icon, color: color),

          const SizedBox(height: 6),

          Text(
            title,

            style: const TextStyle(color: Colors.black54, fontSize: 12),
          ),

          const SizedBox(height: 4),

          Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),

          Text(unit, style: TextStyle(color: color, fontSize: 10)),
        ],
      ),
    );
  }

  Widget activityCard(ActivityModel act) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,

          MaterialPageRoute(builder: (_) => ActivityDetailPage(activity: act)),
        );
      },

      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(14),

        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),

          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 6,
              offset: Offset(0, 3),
            ),
          ],
        ),

        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: Colors.deepPurple.withOpacity(0.2),

              child: const Icon(Icons.directions_run, color: Colors.deepPurple),
            ),

            const SizedBox(width: 12),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  Text(
                    act.title,

                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),

                  const SizedBox(height: 4),

                  Text(
                    "${act.date} • ${act.time}",

                    style: const TextStyle(color: Colors.black54, fontSize: 12),
                  ),
                ],
              ),
            ),

            Column(
              crossAxisAlignment: CrossAxisAlignment.end,

              children: [
                Text(
                  act.distance,

                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 4),

                Text(
                  "${act.duration} • ${act.pace}",

                  style: const TextStyle(color: Colors.black54, fontSize: 12),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
