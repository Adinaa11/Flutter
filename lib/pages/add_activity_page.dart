import 'package:flutter/material.dart';

class AddActivityPage extends StatefulWidget {
  const AddActivityPage({super.key});

  @override
  State<AddActivityPage> createState() => _AddActivityPageState();
}

class _AddActivityPageState extends State<AddActivityPage> {
  final TextEditingController keteranganController = TextEditingController();
  final TextEditingController jarakController = TextEditingController();
  final TextEditingController durasiController = TextEditingController();
  final TextEditingController paceController = TextEditingController();
  final TextEditingController catatanController = TextEditingController();

  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();

  Future<void> pickDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() => selectedDate = picked);
    }
  }

  Future<void> pickTime() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (picked != null) {
      setState(() => selectedTime = picked);
    }
  }

  void _saveActivity() {
    if (keteranganController.text.isEmpty) return; // minimal validasi
    final activity = {
      "title": keteranganController.text,
      "date": "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}",
      "time": selectedTime.format(context),
      "distance": jarakController.text,
      "duration": durasiController.text,
      "pace": paceController.text,
      "calories": "0",
      "note": catatanController.text,
    };
    Navigator.pop(context, activity); // kirim data kembali ke HomePage
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tambah Aktivitas"),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        elevation: 1,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Keterangan
            TextField(
              controller: keteranganController,
              decoration: InputDecoration(
                labelText: "Keterangan",
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            const SizedBox(height: 12),

            // Tanggal
            InkWell(
              onTap: pickDate,
              child: InputDecorator(
                decoration: InputDecoration(
                  labelText: "Tanggal",
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("${selectedDate.day}/${selectedDate.month}/${selectedDate.year}"),
                    Icon(Icons.calendar_today, color: Colors.grey[600]),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),

            // Waktu
            InkWell(
              onTap: pickTime,
              child: InputDecorator(
                decoration: InputDecoration(
                  labelText: "Waktu Mulai",
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(selectedTime.format(context)),
                    Icon(Icons.access_time, color: Colors.grey[600]),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),

            // Jarak
            TextField(
              controller: jarakController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Jarak (km)",
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            const SizedBox(height: 12),

            // Durasi
            TextField(
              controller: durasiController,
              decoration: InputDecoration(
                labelText: "Durasi",
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            const SizedBox(height: 12),

            // Pace
            TextField(
              controller: paceController,
              decoration: InputDecoration(
                labelText: "Pace (menit/km)",
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            const SizedBox(height: 12),

            // Catatan
            TextField(
              controller: catatanController,
              decoration: InputDecoration(
                labelText: "Catatan (opsional)",
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            const SizedBox(height: 20),

            // Tombol Simpan
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _saveActivity,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF6A3DBF),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: const Text("Simpan", style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}