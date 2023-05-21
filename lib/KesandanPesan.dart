import 'package:flutter/material.dart';
import 'package:project_akhir_tpm_teori/HomePage.dart';
import 'package:project_akhir_tpm_teori/Login.dart';
import 'package:project_akhir_tpm_teori/Profil.dart';

class KesanPesanPage extends StatefulWidget {
  const KesanPesanPage({Key? key}) : super(key: key);

  @override
  State<KesanPesanPage> createState() => _KesanPesanPageState();
}

class _KesanPesanPageState extends State<KesanPesanPage> {
  int _currentIndex = 0;

  final List<String> kesanList = [
    'Materi yang diajarkan sangat jelas.',
    'Dosen sangat membantu dalam menjelaskan konsep-konsep mobile secara teori.',
    'Project Akhir yang tidak berkelompok membuat kami menjadi lebih mandiri.',
    'Pencetak rekor dengan soal kuis terbanyak sepanjang sejarah saya kuliah.',
    'Bismillah, dengan izin Allah dan dengan kemurahan hati bapak izinkan saya mendapat nilai A .',
  ];

  final List<String> pesanList = [
    'Bikin soal Kuis nya yang ada di PPT aja pak, saya semalaman baca PPT ternyata soalnya tidak ada di PPT.',
    'Materi yang terlalu teoritis, perlu lebih banyak contoh praktis.',
  ];

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: Text('Kesan dan Pesan'),
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
      body: ListView.builder(
        itemCount: kesanList.length + pesanList.length,
        itemBuilder: (context, index) {
          if (index < kesanList.length) {
            // Item Kesan
            return Card(
              child: ListTile(
                leading: Icon(Icons.thumb_up, color: Colors.orange),
                title: Text('Kesan'),
                subtitle: Text(kesanList[index]),
              ),
            );
          } else {
            // Item Pesan
            final pesanIndex = index - kesanList.length;
            return Card(
              child: ListTile(
                leading: Icon(Icons.thumb_down, color: Colors.orange),
                title: Text('Pesan'),
                subtitle: Text(pesanList[pesanIndex]),
              ),
            );
          }
        },
      ),
    );
  }
}
