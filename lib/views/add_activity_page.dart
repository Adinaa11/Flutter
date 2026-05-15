import 'package:flutter/material.dart';

import '../models/activity_model.dart';

class AddActivityPage extends StatefulWidget {
  final ActivityModel? activity;

  const AddActivityPage({super.key, this.activity});

  @override
  State<AddActivityPage> createState() => _AddActivityPageState();
}

class _AddActivityPageState extends State<AddActivityPage> {
  final TextEditingController keteranganController = TextEditingController();

  final TextEditingController jarakController = TextEditingController();

  final TextEditingController jamController = TextEditingController();

  final TextEditingController menitController = TextEditingController();

  final TextEditingController detikController = TextEditingController();

  final TextEditingController paceController = TextEditingController();

  final TextEditingController catatanController = TextEditingController();

  DateTime selectedDate = DateTime.now();

  TimeOfDay selectedTime = TimeOfDay.now();

  @override
  void initState() {
    super.initState();

    // MODE EDIT
    if (widget.activity != null) {
      final act = widget.activity!;

      keteranganController.text = act.title;

      jarakController.text = act.distance.replaceAll(" km", "");

      paceController.text = act.pace.replaceAll("'00\"/km", "");

      catatanController.text = act.note ?? "";

      // SPLIT DURASI
      final durationParts = act.duration.split(":");

      if (durationParts.length == 3) {
        jamController.text = durationParts[0];

        menitController.text = durationParts[1];

        detikController.text = durationParts[2];
      }
    }
  }

  Future<void> pickDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  Future<void> pickTime() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );

    if (picked != null) {
      setState(() {
        selectedTime = picked;
      });
    }
  }

  void _saveActivity() {
    if (keteranganController.text.isEmpty) return;

    final duration =
        "${jamController.text.padLeft(2, '0')}:"
        "${menitController.text.padLeft(2, '0')}:"
        "${detikController.text.padLeft(2, '0')}";

    final activity = ActivityModel(
      title: keteranganController.text,

      date: "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}",

      time: selectedTime.format(context),

      distance: "${jarakController.text} km",

      duration: duration,

      pace: "${paceController.text}'00\"/km",

      calories: "0",

      note: catatanController.text,
    );

    Navigator.pop(context, activity);
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.activity != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(isEdit ? "Edit Aktivitas" : "Tambah Aktivitas"),

        backgroundColor: Colors.white,

        foregroundColor: Colors.black87,

        elevation: 1,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),

        child: Column(
          children: [
            // KETERANGAN
            TextField(
              controller: keteranganController,

              decoration: InputDecoration(
                labelText: "Keterangan",

                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),

            const SizedBox(height: 12),

            // TANGGAL
            InkWell(
              onTap: pickDate,

              child: InputDecorator(
                decoration: InputDecoration(
                  labelText: "Tanggal",

                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),

                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,

                  children: [
                    Text(
                      "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}",
                    ),

                    Icon(Icons.calendar_today, color: Colors.grey[600]),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 12),

            // WAKTU
            InkWell(
              onTap: pickTime,

              child: InputDecorator(
                decoration: InputDecoration(
                  labelText: "Waktu Mulai",

                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
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

            // JARAK
            TextField(
              controller: jarakController,

              keyboardType: TextInputType.number,

              decoration: InputDecoration(
                labelText: "Jarak (km)",

                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),

            const SizedBox(height: 12),

            // DURASI
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: jamController,

                    keyboardType: TextInputType.number,

                    decoration: InputDecoration(
                      labelText: "Jam",

                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),

                const SizedBox(width: 10),

                Expanded(
                  child: TextField(
                    controller: menitController,

                    keyboardType: TextInputType.number,

                    decoration: InputDecoration(
                      labelText: "Menit",

                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),

                const SizedBox(width: 10),

                Expanded(
                  child: TextField(
                    controller: detikController,

                    keyboardType: TextInputType.number,

                    decoration: InputDecoration(
                      labelText: "Detik",

                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            // PACE
            TextField(
              controller: paceController,

              keyboardType: TextInputType.number,

              decoration: InputDecoration(
                labelText: "Pace (menit/km)",

                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),

            const SizedBox(height: 12),

            // CATATAN
            TextField(
              controller: catatanController,

              decoration: InputDecoration(
                labelText: "Catatan (opsional)",

                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // BUTTON
            SizedBox(
              width: double.infinity,

              child: ElevatedButton(
                onPressed: _saveActivity,

                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF6A3DBF),

                  foregroundColor: Colors.white,

                  padding: const EdgeInsets.symmetric(vertical: 14),

                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),

                child: Text(
                  isEdit ? "Update" : "Simpan",

                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
