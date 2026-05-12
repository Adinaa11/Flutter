import 'package:flutter/material.dart';

class ActivityDetailPage extends StatelessWidget {
  final Map<String, dynamic> activity;
  const ActivityDetailPage({super.key, required this.activity});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F4FF),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black87),
        title: const Text("Detail Aktivitas", style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold)),
        actions: const [Icon(Icons.more_vert, color: Colors.black87)],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Header Card
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFF6A3DBF),
                borderRadius: BorderRadius.circular(28),
              ),
              child: Row(
                children: [
                  Container(
                    width: 64,
                    height: 64,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Icon(Icons.directions_run, color: Color(0xFF6A3DBF), size: 36),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(activity['title'], style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            const Icon(Icons.calendar_month_rounded, size: 16, color: Colors.white70),
                            const SizedBox(width: 6),
                            Text(activity['date'], style: const TextStyle(color: Colors.white70)),
                            const SizedBox(width: 12),
                            const Icon(Icons.access_time_rounded, size: 16, color: Colors.white70),
                            const SizedBox(width: 6),
                            Text(activity['time'], style: const TextStyle(color: Colors.white70)),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Text("Selesai", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                  )
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Ringkasan
            Align(
              alignment: Alignment.centerLeft,
              child: const Text("Ringkasan", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87)),
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(28),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Merapikan jarak
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      _StatItem(icon: Icons.location_on_outlined, title: "Jarak", value: activity['distance'], unit: "km", color: const Color(0xFF6A3DBF)),
                      _StatItem(icon: Icons.access_time_rounded, title: "Durasi", value: activity['duration'], unit: "jam", color: const Color(0xFF3B82F6)),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      _StatItem(icon: Icons.speed_rounded, title: "Pace Rata-rata", value: activity['pace'], unit: "/km", color: const Color(0xFFF59E0B)),
                      _StatItem(icon: Icons.local_fire_department_rounded, title: "Kalori", value: activity['calories'] ?? "1256", unit: "kcal", color: const Color(0xFF22C55E)),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Catatan
            Align(
              alignment: Alignment.centerLeft,
              child: const Text("Catatan", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87)),
            ),
            const SizedBox(height: 12),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
              ),
              child: Text(activity['note'] ?? "Tidak ada catatan tambahan.", style: const TextStyle(color: Colors.black54)),
            ),

            const SizedBox(height: 28),

            // Tombol Update & Delete
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.delete_outline_rounded, color: Colors.red),
                    label: const Text("Hapus", style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      side: const BorderSide(color: Colors.red, width: 1.4),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.edit_outlined, color: Colors.white),
                    label: const Text("Update", style: TextStyle(fontWeight: FontWeight.bold)),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      backgroundColor: const Color(0xFF6A3DBF),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  final String unit;
  final Color color;

  const _StatItem({super.key, required this.icon, required this.title, required this.value, required this.unit, required this.color});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(radius: 28, backgroundColor: color.withOpacity(0.15), child: Icon(icon, color: color, size: 28)),
        const SizedBox(height: 8),
        Text(title, textAlign: TextAlign.center, style: const TextStyle(color: Colors.black54)),
        const SizedBox(height: 4),
        Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black87)),
        Text(unit, style: TextStyle(color: color, fontWeight: FontWeight.bold)),
      ],
    );
  }
}