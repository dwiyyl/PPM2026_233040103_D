import 'package:flutter/material.dart';
import 'gallery_widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.indigo,
      ),
      home: const ProfilePage(),
    );
  }
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC), 
      appBar: AppBar(
        title: const Text('Profil Saya'),
        centerTitle: true,
        actions: [
          IconButton(icon: const Icon(Icons.search), onPressed: () {}),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.indigo, Colors.blue],
                ),
              ),
              child: Text(
                'Menu Utama',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            const ListTile(leading: Icon(Icons.home), title: Text('Beranda')),
            const ListTile(leading: Icon(Icons.person), title: Text('Profil')),
            ListTile(
              leading: const Icon(Icons.widgets),
              title: const Text('Widget Gallery'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const GalleryHome()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Pengaturan'),
              onTap: () {
                Navigator.pop(context);
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Pengaturan'),
                    content: const Text('Halaman pengaturan belum tersedia.'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Oke'),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
      body: Container(
        // Task 2: Background Gradien Soft
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFEEF2FF), Color(0xFFE0E7FF)],
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // === HEADER PROFIL ===
              Center(
                child: Column(
                  children: [
                    const CircleAvatar(
                      radius: 55,
                      backgroundColor: Colors.white,
                      child: CircleAvatar(
                        radius: 50,
                        // Task 1: Menggunakan NetworkImage (GitHub identicon)
                        backgroundImage: NetworkImage( 'https://github.githubassets.com/images/modules/logos_page/GitHub-Mark.png'),

                      ),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Dwi Yulianti',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Mahasiswa Teknik Informatika',
                      style: TextStyle(fontSize: 15, color: Colors.indigo.shade400),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              // === STATISTIK ===
              Row(
                children: [
                  Expanded(child: _StatBox(label: 'Posts', value: '17')),
                  Expanded(child: _StatBox(label: 'Friends', value: '127')),
                  Expanded(child: _StatBox(label: 'Likes', value: '1.7K')),
                ],
              ),
              const SizedBox(height: 30),
              // === SECTION CARDS ===
              const _SectionCard(
                icon: Icons.person_outline,
                title: 'Tentang Saya',
                content: 'Saya suka belajar hal baru, terutama yang berkaitan dengan teknologi dan pengembangan aplikasi mobile.',
              ),
              const _SectionCard(
                icon: Icons.school_outlined,
                title: 'Pendidikan',
                content: 'Universitas Pasundan — Semester 5\nIPK: 3.99',
              ),
              const _SectionCard(
                icon: Icons.alternate_email,
                title: 'Kontak',
                content: 'wiuwi@gmail.com\n+62 812-3456-7890',
              ),
              // Task 3: Section "Skills" dengan Wrap & 5 Chips
              _SectionCard(
                icon: Icons.star_border_rounded,
                title: 'Skills',
                customContent: Wrap(
                  spacing: 8,
                  runSpacing: 4,
                  children: const [
                    Chip(label: Text('UI/UX Design')),
                    Chip(label: Text('Analisis Design')),
                    Chip(label: Text('Java')),
                    Chip(label: Text('SQL')),
                  ],
                ),
              ),
              const SizedBox(height: 80),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Edit profil belum tersedia')),
          );
        },
        label: const Text('Edit Profil'),
        icon: const Icon(Icons.edit_note),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: 1,
        onDestinationSelected: (i) {},
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home_outlined), label: 'Home'),
          NavigationDestination(icon: Icon(Icons.person_pin), label: 'Profil'),
          NavigationDestination(icon: Icon(Icons.message_outlined), label: 'Pesan'),
          NavigationDestination(icon: Icon(Icons.settings_outlined), label: 'Setting'),
        ],
      ),
    );
  }
}

class _StatBox extends StatelessWidget {
  final String label;
  final String value;
  const _StatBox({required this.label, required this.value});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(value, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.indigo)),
        const SizedBox(height: 4),
        Text(label, style: TextStyle(color: Colors.grey.shade600, fontSize: 13)),
      ],
    );
  }
}

class _SectionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? content;
  final Widget? customContent;

  const _SectionCard({
    required this.icon,
    required this.title,
    this.content,
    this.customContent,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shadowColor: Colors.black12,
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: Colors.indigo, size: 28),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  if (customContent != null)
                    customContent!
                  else if (content != null)
                    Text(content!, style: TextStyle(color: Colors.grey.shade800, height: 1.5)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
