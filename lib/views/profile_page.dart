import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  final String userEmail;

  const ProfilePage({super.key, required this.userEmail});

  @override
  Widget build(BuildContext context) {
    Color primaryColor = Color(0xFF6A3DBF);
    Color backgroundColor = Color(0xFFF5F4FF);

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: const Text(
          "Profile",
          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w600),
        ),
        backgroundColor: backgroundColor,
        elevation: 0,
        foregroundColor: Colors.black87,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Profile Card
            Container(
              padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 3))],
              ),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 36,
                    backgroundColor: primaryColor,
                    child: Text(userEmail[0].toUpperCase(),
                        style: const TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold)),
                  ),
                  const SizedBox(height: 12),
                  Text(userEmail,
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87)),
                  const SizedBox(height: 4),
                  const Text("Pengguna Stride", style: TextStyle(color: Colors.black54)),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        // Navigate to Edit Profile
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColor,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                      child: const Text("Edit Profil", style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Menu
            Column(
              children: [
                menuItem(
                  icon: Icons.history,
                  text: "Riwayat Aktivitas",
                  subtitle: "Lihat semua catatan lari Anda",
                  onTap: () {
                    // Navigate ke halaman riwayat aktivitas
                  },
                ),
                const SizedBox(height: 12),
                menuItem(
                  icon: Icons.logout,
                  text: "Keluar",
                  subtitle: "Logout dari akun",
                  iconColor: Colors.red,
                  textColor: Colors.red,
                  onTap: () {
                    // Logout action
                  },
                ),
              ],
            ),

            const SizedBox(height: 24),
            // Motivational card
            Container(
              width: double.infinity,
              height: 120,
              decoration: BoxDecoration(
                color: primaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Center(
                  child: Text(
                "Terus bergerak, capai versi terbaikmu!",
                style: TextStyle(color: primaryColor, fontWeight: FontWeight.bold),
              )),
            ),
          ],
        ),
      ),
    );
  }

  Widget menuItem(
      {required IconData icon,
      required String text,
      String? subtitle,
      Color iconColor = Colors.deepPurple,
      Color textColor = Colors.black87,
      VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 3))],
        ),
        child: Row(
          children: [
            Icon(icon, color: iconColor),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(text, style: TextStyle(color: textColor, fontWeight: FontWeight.bold)),
                    if (subtitle != null)
                      Text(subtitle, style: const TextStyle(color: Colors.black54, fontSize: 12)),
                  ]),
            ),
            const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.black38),
          ],
        ),
      ),
    );
  }
}