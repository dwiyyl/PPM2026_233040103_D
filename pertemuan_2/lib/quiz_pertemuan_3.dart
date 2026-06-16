import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb; 
import 'package:image_picker/image_picker.dart';
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

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String name = 'Dwi Yulianti';
  String role = 'Mahasiswa Teknik Informatika';
  String imageUrl = 'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png';
  String about = 'Saya suka belajar hal baru, terutama yang berkaitan dengan teknologi dan pengembangan aplikasi mobile.';
  String education = 'Universitas Pasundan — Semester 6\nIPK: 3.99';
  String contact = 'wiuwi@gmail.com\n+62 812-3456-7890';
  List<String> skills = ['UI/UX Design', 'Analisis Design', 'Java', 'SQL', 'Flutter'];
  String location = 'Bandung, Indonesia';

  // Bonus: Pengalaman data
  String expTitle = 'Mobile Develope';
  String expDesc = 'Mengembangkan aplikasi mobile menggunakan Flutter.';
  String expImageUrl = 'https://plus.unsplash.com/premium_photo-1685086785054-d047cdc0e525?fm=jpg&q=60&w=3000&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8bW9iaWxlJTIwZGV2ZWxvcG1lbnR8ZW58MHx8MHx8fDA%3D';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        title: const Text('Profil Saya'),
        centerTitle: true,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              decoration: const BoxDecoration(
                gradient: LinearGradient(colors: [Colors.indigo, Colors.blue]),
              ),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                child: CircleAvatar(
                  radius: 32,
                  backgroundImage: _safeImageProvider(imageUrl),
                ),
              ),
              accountName: Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
              accountEmail: Text(contact.split('\n')[0]),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Beranda'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Profil Saya'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(Icons.work_history),
              title: const Text('Upload Pengalaman'),
              onTap: () async {
                Navigator.pop(context);
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditExperiencePage(
                      currentTitle: expTitle,
                      currentDesc: expDesc,
                      currentImageUrl: expImageUrl,
                    ),
                  ),
                );

                if (result != null && mounted) {
                  setState(() {
                    expTitle = result['title'];
                    expDesc = result['desc'];
                    expImageUrl = result['imageUrl'];
                  });
                }
              },
            ),
            ListTile(
              leading: const Icon(Icons.widgets),
              title: const Text('Widget Gallery'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (_) => const GalleryHome()));
              },
            ),
          ],
        ),
      ),
      body: Container(
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
              Center(
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 55,
                      backgroundColor: Colors.white,
                      child: CircleAvatar(
                        radius: 50,
                        backgroundImage: _safeImageProvider(imageUrl),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(name, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                    Text(role, style: TextStyle(fontSize: 15, color: Colors.indigo.shade400)),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              Row(
                children: [
                  Expanded(child: _StatBox(label: 'Posts', value: '17')),
                  Expanded(child: _StatBox(label: 'Friends', value: '127')),
                  Expanded(child: _StatBox(label: 'Likes', value: '1.7K')),
                ],
              ),
              const SizedBox(height: 30),
              _SectionCard(icon: Icons.person_outline, title: 'Tentang Saya', content: about),
              _SectionCard(icon: Icons.school_outlined, title: 'Pendidikan', content: education),
              _SectionCard(icon: Icons.location_on_outlined, title: 'Lokasi', content: location),
              _SectionCard(icon: Icons.alternate_email, title: 'Kontak', content: contact),
              _SectionCard(
                icon: Icons.star_border_rounded,
                title: 'Skills',
                customContent: Wrap(
                  spacing: 8,
                  runSpacing: 4,
                  children: skills.map((skill) => Chip(label: Text(skill))).toList(),
                ),
              ),
              _SectionCard(
                icon: Icons.history_edu,
                title: 'Pengalaman',
                customContent: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) => Dialog(
                            backgroundColor: Colors.transparent,
                            insetPadding: const EdgeInsets.all(10),
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                InteractiveViewer(
                                  child: _safeImageWidget(expImageUrl),
                                ),
                                Positioned(
                                  top: 10,
                                  right: 10,
                                  child: CircleAvatar(
                                    backgroundColor: Colors.white,
                                    child: IconButton(
                                      icon: const Icon(Icons.close, color: Colors.black),
                                      onPressed: () => Navigator.pop(context),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      child: _safeImageWidget(expImageUrl, height: 200, fit: BoxFit.cover),
                    ),
                    const SizedBox(height: 12),
                    Text(expTitle, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 4),
                    Text(expDesc, style: TextStyle(color: Colors.grey.shade800, height: 1.5)),
                  ],
                ),
              ),
              const SizedBox(height: 80),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EditProfilePage(
                currentName: name,
                currentRole: role,
                currentImageUrl: imageUrl,
                currentAbout: about,
                currentEducation: education,
                currentContact: contact,
                currentSkills: skills.join(', '),
                currentLocation: location,
              ),
            ),
          );

          if (result != null && mounted) {
            setState(() {
              name = result['name'];
              role = result['role'];
              imageUrl = result['imageUrl'];
              about = result['about'];
              education = result['education'];
              contact = result['contact'];
              skills = (result['skills'] as String).split(',').map((s) => s.trim()).where((s) => s.isNotEmpty).toList();
              location = result['location'];
            });
          }
        },
        label: const Text('Edit Profil'),
        icon: const Icon(Icons.edit_note),
      ),
    );
  }

  // Fungsi helper untuk menampilkan Image Provider secara aman
  ImageProvider _safeImageProvider(String path) {
    if (path.startsWith('assets/')) {
      return AssetImage(path);
    }
    if (kIsWeb || path.startsWith('http') || path.startsWith('blob:')) {
      return NetworkImage(path);
    } else {
      return FileImage(File(path));
    }
  }

  // Fungsi helper untuk menampilkan Widget Image secara aman
  Widget _safeImageWidget(String path, {double? height, BoxFit fit = BoxFit.cover}) {
    if (path.isEmpty) return const SizedBox.shrink();

    if (path.startsWith('assets/')) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.asset(
          path,
          height: height,
          width: double.infinity,
          fit: fit,
          errorBuilder: (context, error, stackTrace) => Container(
              height: height,
              color: Colors.grey[300],
              child: const Icon(Icons.broken_image)),
        ),
      );
    }
    
    if (kIsWeb || path.startsWith('http') || path.startsWith('blob:')) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.network(
          path,
          height: height,
          width: double.infinity,
          fit: fit,
          errorBuilder: (context, error, stackTrace) => Container(height: height, color: Colors.grey[300], child: const Icon(Icons.broken_image)),
        ),
      );
    } else {
      return ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.file(
          File(path),
          height: height,
          width: double.infinity,
          fit: fit,
          errorBuilder: (context, error, stackTrace) => Container(height: height, color: Colors.grey[300], child: const Icon(Icons.broken_image)),
        ),
      );
    }
  }
}

class EditProfilePage extends StatefulWidget {
  final String currentName, currentRole, currentImageUrl, currentAbout, currentEducation, currentContact, currentSkills, currentLocation;
  const EditProfilePage({super.key, required this.currentName, required this.currentRole, required this.currentImageUrl, required this.currentAbout, required this.currentEducation, required this.currentContact, required this.currentSkills, required this.currentLocation});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  late TextEditingController nameController, roleController, aboutController, educationController, contactController, skillsController, locationController;
  late String imageUrl;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.currentName);
    roleController = TextEditingController(text: widget.currentRole);
    aboutController = TextEditingController(text: widget.currentAbout);
    educationController = TextEditingController(text: widget.currentEducation);
    contactController = TextEditingController(text: widget.currentContact);
    skillsController = TextEditingController(text: widget.currentSkills);
    locationController = TextEditingController(text: widget.currentLocation);
    imageUrl = widget.currentImageUrl;
  }

  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) setState(() => imageUrl = image.path);
  }

  void _handleSave() {
    Navigator.pop(context, {
      'name': nameController.text,
      'role': roleController.text,
      'imageUrl': imageUrl,
      'about': aboutController.text,
      'education': educationController.text,
      'contact': contactController.text,
      'skills': skillsController.text,
      'location': locationController.text
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        title: const Text('Edit Profil'),
        actions: [
          IconButton(icon: const Icon(Icons.check_circle_outline, size: 28), onPressed: _handleSave),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header: Foto Profil
            Center(
              child: Stack(
                alignment: Alignment.bottomRight,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.indigo.shade100, width: 4),
                      boxShadow: [
                        BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 10, offset: const Offset(0, 5))
                      ],
                    ),
                    child: CircleAvatar(
                      radius: 65,
                      backgroundColor: Colors.white,
                      backgroundImage: _safeImageProvider(imageUrl),
                    ),
                  ),
                  GestureDetector(
                    onTap: _pickImage,
                    child: CircleAvatar(
                      backgroundColor: Colors.indigo,
                      radius: 20,
                      child: const Icon(Icons.camera_alt, color: Colors.white, size: 20),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),

            _buildSectionHeader('Informasi Dasar'),
            _buildTextField(nameController, 'Nama Lengkap', Icons.person_outline),
            _buildTextField(roleController, 'Pekerjaan / Peran', Icons.work_outline),
            _buildTextField(locationController, 'Lokasi', Icons.location_on_outlined),

            const SizedBox(height: 12),
            _buildSectionHeader('Deskripsi & Pendidikan'),
            _buildTextField(aboutController, 'Tentang Saya', Icons.info_outline, maxLines: 3),
            _buildTextField(educationController, 'Riwayat Pendidikan', Icons.school_outlined, maxLines: 2),

            const SizedBox(height: 12),
            _buildSectionHeader('Kontak & Skill'),
            _buildTextField(contactController, 'Kontak (Email/HP)', Icons.alternate_email, maxLines: 2),
            _buildTextField(skillsController, 'Skills (Pisahkan dengan koma)', Icons.star_border),

            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _handleSave,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.indigo,
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 56),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                elevation: 2,
              ),
              child: const Text('Simpan Perubahan', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16, left: 4),
      child: Text(
        title.toUpperCase(),
        style: TextStyle(color: Colors.indigo.shade700, fontWeight: FontWeight.bold, fontSize: 12, letterSpacing: 1.2),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label, IconData icon, {int maxLines = 1}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: TextField(
        controller: controller,
        maxLines: maxLines,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon, color: Colors.indigo.shade400),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: Colors.grey.shade300)),
          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: Colors.grey.shade200)),
          focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Colors.indigo, width: 2)),
          labelStyle: TextStyle(color: Colors.grey.shade600),
        ),
      ),
    );
  }

  ImageProvider _safeImageProvider(String path) {
    if (path.startsWith('assets/')) {
      return AssetImage(path);
    }
    if (kIsWeb || path.startsWith('http') || path.startsWith('blob:')) return NetworkImage(path);
    return FileImage(File(path));
  }
}

class EditExperiencePage extends StatefulWidget {
  final String currentTitle, currentDesc, currentImageUrl;
  const EditExperiencePage({super.key, required this.currentTitle, required this.currentDesc, required this.currentImageUrl});
  @override
  State<EditExperiencePage> createState() => _EditExperiencePageState();
}

class _EditExperiencePageState extends State<EditExperiencePage> {
  late TextEditingController titleController, descController;
  late String imageUrl;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.currentTitle);
    descController = TextEditingController(text: widget.currentDesc);
    imageUrl = widget.currentImageUrl;
  }

  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) setState(() => imageUrl = image.path);
  }

  void _handleSave() {
    Navigator.pop(context, {
      'title': titleController.text,
      'desc': descController.text,
      'imageUrl': imageUrl,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Upload Pengalaman', style: TextStyle(fontSize: 18)),
        actions: [
          TextButton.icon(
            onPressed: _handleSave,
            icon: const Icon(Icons.save, size: 18),
            label: const Text('Simpan'),
            style: TextButton.styleFrom(foregroundColor: Colors.indigo),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Area Upload Gambar (Kotak Ungu Muda sesuai gambar)
            GestureDetector(
              onTap: _pickImage,
              child: Container(
                width: double.infinity,
                height: 200,
                decoration: BoxDecoration(
                  color: const Color(0xFFF5F3FF),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.indigo.withOpacity(0.1)),
                ),
                child: imageUrl.isNotEmpty && !imageUrl.contains('pixabay') && !imageUrl.contains('unsplash')
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: _safeImageWidget(imageUrl),
                      )
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.add_photo_alternate_outlined, size: 48, color: Colors.indigo.shade300),
                          const SizedBox(height: 12),
                          Text(
                            'Ketuk untuk pilih gambar',
                            style: TextStyle(color: Colors.indigo.shade400, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'dari galeri perangkat kamu',
                            style: TextStyle(color: Colors.indigo.shade200, fontSize: 12),
                          ),
                        ],
                      ),
              ),
            ),
            const SizedBox(height: 32),
            const Text(
              'Informasi Pengalaman',
              style: TextStyle(color: Colors.indigo, fontWeight: FontWeight.bold, fontSize: 14),
            ),
            const SizedBox(height: 16),
            // Input Judul
            TextField(
              controller: titleController,
              decoration: InputDecoration(
                labelText: 'Judul *',
                prefixIcon: const Icon(Icons.title),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Input Deskripsi
            TextField(
              controller: descController,
              maxLines: 5,
              decoration: InputDecoration(
                labelText: 'Deskripsi',
                alignLabelWithHint: true,
                prefixIcon: const Icon(Icons.description),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
              ),
            ),
            const SizedBox(height: 32),
            // Tombol Simpan Bawah
            SizedBox(
              width: double.infinity,
              height: 54,
              child: ElevatedButton.icon(
                onPressed: _handleSave,
                icon: const Icon(Icons.save),
                label: const Text('Simpan Pengalaman', style: TextStyle(fontWeight: FontWeight.bold)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF5D5FEF),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    titleController.dispose();
    descController.dispose();
    super.dispose();
  }

  Widget _safeImageWidget(String path) {
    if (path.isEmpty) return const Icon(Icons.image, size: 50);
    if (path.startsWith('assets/')) {
      return Image.asset(path, fit: BoxFit.cover, errorBuilder: (c, e, s) => const Icon(Icons.broken_image, size: 50));
    }
    if (kIsWeb || path.startsWith('http') || path.startsWith('blob:')) return Image.network(path, fit: BoxFit.cover, errorBuilder: (c, e, s) => const Icon(Icons.broken_image, size: 50));
    return Image.file(File(path), fit: BoxFit.cover, errorBuilder: (c, e, s) => const Icon(Icons.broken_image, size: 50));
  }
}

class _StatBox extends StatelessWidget {
  final String label, value;
  const _StatBox({required this.label, required this.value});
  @override
  Widget build(BuildContext context) {
    return Column(children: [Text(value, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.indigo)), const SizedBox(height: 4), Text(label, style: TextStyle(color: Colors.grey.shade600, fontSize: 13))]);
  }
}

class _SectionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? content;
  final Widget? customContent;
  const _SectionCard({required this.icon, required this.title, this.content, this.customContent});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.indigo.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Garis Aksen Indigo di Samping
              Container(width: 4, color: Colors.indigo.shade400),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.indigo.shade50,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Icon(icon, color: Colors.indigo, size: 22),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              title.toUpperCase(),
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w800,
                                color: Colors.indigo.shade300,
                                letterSpacing: 1.1,
                              ),
                            ),
                            const SizedBox(height: 4),
                            if (customContent != null)
                              customContent!
                            else if (content != null)
                              Text(
                                content!,
                                style: const TextStyle(
                                  fontSize: 15,
                                  color: Color(0xFF1E293B),
                                  height: 1.4,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
