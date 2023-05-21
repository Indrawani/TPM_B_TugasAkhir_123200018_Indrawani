import 'package:flutter/material.dart';
import 'package:project_akhir_tpm_teori/HomePage.dart';
import 'package:project_akhir_tpm_teori/KesandanPesan.dart';
import 'package:project_akhir_tpm_teori/Login.dart';

class HalamanProfil extends StatefulWidget {
  const HalamanProfil({Key? key}) : super(key: key);

  @override
  State<HalamanProfil> createState() => _HalamanProfilState();
}

class _HalamanProfilState extends State<HalamanProfil> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: Text('My Profile'),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        backgroundColor: colorScheme.surface,
        selectedItemColor: Colors.orange,
        unselectedItemColor: colorScheme.onSurface.withOpacity(.60),
        selectedLabelStyle: textTheme.caption,
        unselectedLabelStyle: textTheme.caption,
        onTap: (value) {
          if (value == 1) {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HalamanProfil())); // Navigasi ke halaman profil
          } else if (value == 2) {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => KesanPesanPage())); // Navigasi ke halaman kesan dan pesan
          } else if (value == 3) {
            AlertDialog alert = AlertDialog(
              title: Text("Logout"),
              content: Container(
                child: Text("Apakah Anda Yakin Ingin Logout?"),
              ),
              actions: [
                TextButton(
                  child: Text("Yes"),
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => LoginPage()),
                    );
                  },
                ),
                TextButton(
                  child: Text("No"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
            showDialog(context: context, builder: (context) => alert);
          } else {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HalamanUtama()));
          }
          // Respond to item press.
          setState(() => _currentIndex = value);
        },
        items: [
          BottomNavigationBarItem(
            title: Text('Halaman Utama'),
            icon: Icon(Icons.home),
          ),
          BottomNavigationBarItem(
            title: Text('Profil'),
            icon: Icon(Icons.person),
          ),
          BottomNavigationBarItem(
            title: Text('Kesan & Pesan'),
            icon: Icon(Icons.message),
          ),
          BottomNavigationBarItem(
            title: Text('Logout'),
            icon: Icon(Icons.logout),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                backgroundImage: AssetImage (
                    'images/iin.jpg'
                ),
                radius: 80,
              ),
              SizedBox(height: 16),
              Text(
                'INDRAWANI',
                style: TextStyle (
                    fontSize: 20, fontWeight: FontWeight.bold
                ),
              ),
              SizedBox(height: 8),
              Text(
                '123200018',
                style: TextStyle (
                    fontSize: 16
                ),
              ),
              SizedBox(height: 24),
              Card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListTile(
                      title: Text('Details Profile '),
                    ),
                    Divider(),
                    ListTile(
                      leading: Icon(
                        Icons.account_circle,
                        color: Colors.orange,
                      ),
                      title: Text('Nama'),
                      subtitle: Text('Indrawani'),
                    ),
                    Divider(),
                    ListTile(
                      leading: Icon(
                        Icons.school,
                        color: Colors.orange,
                      ),
                      title: Text('Kelas'),
                      subtitle: Text('Teknologi dan Pemprograman Mobile IF-B'),
                    ),
                    SizedBox(height: 16),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      // Navigasi ke halaman Kesan
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => KesanPesanPage()));
                    },
                    child: Text('Kesan & Pesan'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}