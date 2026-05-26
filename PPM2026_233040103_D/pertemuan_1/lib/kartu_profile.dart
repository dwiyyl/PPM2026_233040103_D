import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Hello Flutter'),
          backgroundColor: Colors.blue,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('👋', style: TextStyle(fontSize: 50)),
              const SizedBox(height: 10),
              const Text(
                'Halo, uwi!',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text('Selamat datang di Praktikum Pemograman Mobile'),
              const SizedBox(height: 20),

              // Container Kartu Profil Biru
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: const Column(
                  children: [
                    Text('NIM: 233040103', style: TextStyle(color: Colors.white)),
                    Text('Prodi: Teknik Informatika', style: TextStyle(color: Colors.white)),
                    Text('Semester: 6', style: TextStyle(color: Colors.white)),
                  ],
                ),
              ),

              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {},
                child: const Text('Tap Saya'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}