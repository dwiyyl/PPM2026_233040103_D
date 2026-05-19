import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Container(
          width: 200,
          height: 200,
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.blue.withOpacity(0.3),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: const Center(
            child: Text(
              'Box',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        padding: EdgeInsets.zero, // Menghilangkan padding bawaan agar tidak sempit
        child: Container(
          height: 100, // Memberi tinggi yang cukup untuk ikon besar
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _itemMenu(Icons.home, 'Home', Colors.red, 25),
              _itemMenu(Icons.receipt_long, 'Orders', Colors.green, 45),
              _itemMenu(Icons.favorite, 'Saved', Colors.purple, 15),
              _itemMenu(Icons.account_box_rounded, 'Profile', Colors.grey, 25),
            ],
          ),
        ),
      ),
    ),
  ));
}

Widget _itemMenu(IconData icon, String label, Color color, double size) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Icon(icon, color: color, size: size),
      const SizedBox(height: 4),
      Text(
        label,
        style: TextStyle(color: color, fontSize: 12),
      ),
    ],
  );
}