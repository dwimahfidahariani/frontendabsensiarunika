import 'package:flutter/material.dart';

class DataManagementPage extends StatefulWidget {
  const DataManagementPage({super.key});

  @override
  State<DataManagementPage> createState() => _DataManagementPageState();
}

class _DataManagementPageState extends State<DataManagementPage> {
  final List<Map<String, String>> data = [
    {"No": "1", "Name": "Andi Wijaya", "Email": "andi@example.com", "Role": "Admin", "Position": "Manager", "Company": "ABC Corp"},
    {"No": "2", "Name": "Budi Santoso", "Email": "budi@example.com", "Role": "Staff", "Position": "Operator", "Company": "XYZ Ltd"},
    {"No": "3", "Name": "Siti Aminah", "Email": "siti@example.com", "Role": "User", "Position": "Assistant", "Company": "QRS Inc"},
  ];

  void _showAddDataDialog() {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController emailController = TextEditingController();
    final TextEditingController roleController = TextEditingController();
    final TextEditingController positionController = TextEditingController();
    final TextEditingController companyController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Tambah Data"),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(labelText: "Nama"),
                ),
                TextField(
                  controller: emailController,
                  decoration: const InputDecoration(labelText: "Email"),
                ),
                TextField(
                  controller: roleController,
                  decoration: const InputDecoration(labelText: "Role"),
                ),
                TextField(
                  controller: positionController,
                  decoration: const InputDecoration(labelText: "Position"),
                ),
                TextField(
                  controller: companyController,
                  decoration: const InputDecoration(labelText: "Company"),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Batal"),
            ),
            ElevatedButton(
              onPressed: () {
                if (nameController.text.isNotEmpty &&
                    emailController.text.isNotEmpty &&
                    roleController.text.isNotEmpty &&
                    positionController.text.isNotEmpty &&
                    companyController.text.isNotEmpty) {
                  setState(() {
                    data.add({
                      "No": (data.length + 1).toString(),
                      "Name": nameController.text,
                      "Email": emailController.text,
                      "Role": roleController.text,
                      "Position": positionController.text,
                      "Company": companyController.text,
                    });
                  });
                  Navigator.pop(context);
                }
              },
              child: const Text("Simpan"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFDEE0E4),
        elevation: 0,
        title: const Text(
          "LOGO",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            letterSpacing: 2,
          ),
        ),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'notifikasi') {
                _showNotificationPanel(context);
              } else if (value == 'akun') {
                _showAccountDialog(context);
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'notifikasi',
                child: Row(
                  children: [
                    Icon(Icons.notifications, color: Colors.black54),
                    SizedBox(width: 8),
                    Text("Notifikasi"),
                  ],
                ),
              ),
              const PopupMenuItem(
                value: 'akun',
                child: Row(
                  children: [
                    Icon(Icons.account_circle, color: Colors.black54),
                    SizedBox(width: 8),
                    Text("Profil Saya"),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Data Management",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              ElevatedButton.icon(
                onPressed: _showAddDataDialog,
                icon: const Icon(Icons.add),
                label: const Text("Tambah Data"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                  side: const BorderSide(color: Colors.black54),
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  textStyle: const TextStyle(fontSize: 14),
                ),
              ),
              const SizedBox(height: 20),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  headingRowColor: WidgetStateProperty.all(Colors.grey.shade50),
                  dataRowColor: WidgetStateProperty.all(Colors.white),
                  columns: const [
                    DataColumn(label: Text("No")),
                    DataColumn(label: Text("Name")),
                    DataColumn(label: Text("Email")),
                    DataColumn(label: Text("Role")),
                    DataColumn(label: Text("Position")),
                    DataColumn(label: Text("Company")),
                    DataColumn(label: Text("Action")),
                  ],
                  rows: data.map(
                    (item) {
                      return DataRow(
                        cells: [
                          DataCell(Text(item["No"]!)),
                          DataCell(Text(item["Name"]!)),
                          DataCell(Text(item["Email"]!)),
                          DataCell(Text(item["Role"] ?? "-")),
                          DataCell(Text(item["Position"] ?? "-")),
                          DataCell(Text(item["Company"] ?? "-")),
                          DataCell(
                            Row(
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.edit, color: Colors.blue),
                                  onPressed: () {},
                                ),
                                IconButton(
                                  icon: const Icon(Icons.delete, color: Colors.red),
                                  onPressed: () {
                                    setState(() {
                                      data.remove(item);
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                  ).toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showNotificationPanel(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) => Container(
        height: 200,
        padding: const EdgeInsets.all(16),
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Notifikasi",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Divider(),
            ListTile(title: Text("Ada update baru")),
          ],
        ),
      ),
    );
  }

  void _showAccountDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.account_circle, size: 60, color: Colors.black54),
            const SizedBox(height: 10),
            const Text(
              "Andi Wijaya",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5),
            const Text("andi@example.com"),
            const Text("Divisi: IT Support"),
            const Text("Status: Active"),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.logout, size: 18),
              label: const Text("Logout"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
                side: const BorderSide(color: Colors.black),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
