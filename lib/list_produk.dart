import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:project_akhir_tpm_teori/HomePage.dart';
import 'package:project_akhir_tpm_teori/KesandanPesan.dart';
import 'package:project_akhir_tpm_teori/Login.dart';
import 'package:project_akhir_tpm_teori/Profil.dart';
import 'package:project_akhir_tpm_teori/details_produk.dart';

class Meal {
  final String id;
  final String name;
  final String category;
  final String area;
  final String thumbnail;

  Meal({
    required this.id,
    required this.name,
    required this.category,
    required this.area,
    required this.thumbnail
  });

  factory Meal.fromJson(Map<String, dynamic> json) {
    return Meal(
      id: json['idMeal'],
      name: json['strMeal'],
      category: json['strCategory'],
      area: json['strArea'],
      thumbnail: json['strMealThumb'],
    );
  }
}

class MealList extends StatefulWidget {
  const MealList({Key? key}) : super(key: key);

  @override
  _MealListState createState() => _MealListState();
}

class _MealListState extends State<MealList> {
  int _currentIndex = 0;

  List<Meal> meals = [];
  bool isLoading = true;
  String searchText = "";

  @override
  void initState() {
    super.initState();
    getDataFromApi();
  }

  Future<void> getDataFromApi() async {
    final response = await http.get(Uri.parse(
        'https://www.themealdb.com/api/json/v1/1/search.php?s=$searchText'));
    if (response.statusCode == 200) {
      final List<dynamic> mealList = json.decode(response.body)['meals'];
      setState(() {
        meals = mealList.map((meal) => Meal.fromJson(meal)).toList();
        isLoading = false;
      });
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Meal List'),
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                decoration: const InputDecoration(
                  labelText: "Search by name",
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  setState(() {
                    searchText = value;
                  });
                  getDataFromApi();
                },
              ),
            ),
            Expanded(
              child: isLoading
                  ? const Center(
                child: CircularProgressIndicator(),
              )
                  : ListView(
                children: <Widget>[
              GridView.builder(
              shrinkWrap: true,
                physics: const AlwaysScrollableScrollPhysics(), // Ubah physics ke AlwaysScrollableScrollPhysics()
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.7,
                ),
                itemCount: meals.length,
                itemBuilder: (BuildContext context, int index) {
                  // Item builder code
                      return Card(
                        margin: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            Expanded(
                              child: meals[index].thumbnail != null
                                  ? Image.network(
                                meals[index].thumbnail,
                                fit: BoxFit.cover,
                              )
                                  : Container(),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    meals[index].name,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 8.0),
                                  Text(
                                    "Category: ${meals[index].category}",
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(
                                    "Area: ${meals[index].area}",
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 8.0),
                                  ElevatedButton(
                                    onPressed: () {
                                      // Menampilkan tampilan detail menggunakan API yang sama
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              MealDetailPage(
                                                  meal: meals[index]),
                                        ),
                                      );
                                    },
                                    child: const Text('Detail'),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}