import 'package:flutter/material.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> history = [
      {"activity": "Check In", "time": "28 Sep 2025 • 08:01"},
      {"activity": "Check Out", "time": "28 Sep 2025 • 16:29"},
      {"activity": "Izin", "time": "27 Sep 2025 • 09:00"},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Riwayat Absensi",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFF254669),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: history.length,
        itemBuilder: (context, index) {
          final item = history[index];
          return Card(
            child: ListTile(
              leading: const Icon(Icons.access_time, color: Colors.blue),
              title: Text(item["activity"] ?? ""),
              subtitle: Text(item["time"] ?? ""),
            ),
          );
        },
      ),
    );
  }
}
