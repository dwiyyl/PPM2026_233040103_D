import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

// MODEL
class Catatan {
  final String judul;
  final String isi;
  final String kategori;
  final String email;
  final DateTime dibuatPada;

  Catatan({
    required this.judul,
    required this.isi,
    required this.kategori,
    required this.email,
    required this.dibuatPada,
  });

  // Tugas 1
  Catatan copyWith({
    String? judul,
    String? isi,
    String? kategori,
    String? email,
    DateTime? dibuatPada,
  }) {
    return Catatan(
      judul: judul ?? this.judul,
      isi: isi ?? this.isi,
      kategori: kategori ?? this.kategori,
      email: email ?? this.email,
      dibuatPada: dibuatPada ?? this.dibuatPada,
    );
  }
}

// ROOT APP (THEME & ROUTING)
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const Color primaryColor = Color(0xFFAEB5FF);

    return MaterialApp(
      title: 'Catatan Mahasiswa',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorSchemeSeed: primaryColor,
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFF8FAFC),

        // AppBar Baru
        appBarTheme: const AppBarTheme(
          backgroundColor: primaryColor,
          foregroundColor: Color(0xFF1E293B),
          centerTitle: false,
          elevation: 0,
          titleTextStyle: TextStyle(
            color: Color(0xFF1E293B),
            fontSize: 18,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5,
          ),
          iconTheme: IconThemeData(color: Color(0xFF1E293B)),
          actionsIconTheme: IconThemeData(color: Color(0xFF1E293B)),
        ),

        // Input Form yang Lebih Clean
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: primaryColor, width: 2),
          ),
        ),

        // Style Tombol Simpan
        filledButtonTheme: FilledButtonThemeData(
          style: FilledButton.styleFrom(
            backgroundColor: primaryColor,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),

        // Style Tombol Kembali
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            foregroundColor: primaryColor,
            side: const BorderSide(color: primaryColor, width: 1.5),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            padding: const EdgeInsets.symmetric(vertical: 14),
          ),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage(),
      },
      onGenerateRoute: (settings) {
        switch (settings.name) {
        // Tugas 1
          case '/tambah':
            final catatanLama =
            settings.arguments is Catatan ? settings.arguments as Catatan : null;
            return MaterialPageRoute(
              builder: (_) => TambahCatatanPage(catatanLama: catatanLama),
            );
          case '/detail':
            if (settings.arguments is! Catatan) return null;
            final catatan = settings.arguments as Catatan;
            return MaterialPageRoute(
              builder: (_) => DetailCatatanPage(catatan: catatan),
            );
        }
        return null;
      },
    );
  }
}

// HOME PAGE
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // === STATE DATA ===
  final List<Catatan> _catatan = [
    Catatan(
      judul: 'Belajar Flutter',
      isi: 'Mempelajari Stateful Widget, Form, dan Navigation.',
      kategori: 'Kuliah',
      email: 'mahasiswa_if@gmail.com',
      dibuatPada: DateTime.now(),
    ),
    Catatan(
      judul: 'Tugas Praktikum Pemograman Game',
      isi: 'Kumpulkan Progres Tugas Besar dengan GDD (Game Design Document)',
      kategori: 'Tugas',
      email: 'mahasiswa_if@gmail.com',
      dibuatPada: DateTime.now(),
    ),
    Catatan(
      judul: 'Tugas Praktikum Pemograman Mobile',
      isi: 'Kerjakan tugas mandiri pertemuan 4, serta kumpulkan link repository Git berisi project.',
      kategori: 'Tugas',
      email: 'mahasiswa_if@gmail.com',
      dibuatPada: DateTime.now(),
    ),
  ];

  // Tugas 2
  String _filterKategori = 'Semua';
  final _kategoriOpsi = const ['Semua', 'Kuliah', 'Tugas', 'Pribadi', 'Lainnya'];

  List<Catatan> get _catatanTerfilter {
    if (_filterKategori == 'Semua') return _catatan;
    return _catatan.where((c) => c.kategori == _filterKategori).toList();
  }

  String _formatTanggal(DateTime dt) {
    const bulan = ['', 'Jan', 'Feb', 'Mar', 'Apr', 'Mei', 'Jun', 'Jul', 'Agu', 'Sep', 'Okt', 'Nov', 'Des'];
    return '${dt.day} ${bulan[dt.month]} ${dt.year}';
  }

  // Fungsi Helper untuk generate inisial (Contoh: "Belajar Flutter" -> "BF")
  String _getInisial(String judul) {
    if (judul.trim().isEmpty) return '?';

    // Pecah judul berdasarkan spasi
    List<String> kata = judul.trim().split(' ');

    // Ambil huruf pertama dari kata pertama, ubah jadi kapital
    String inisial = kata[0][0].toUpperCase();

    // Jika ada kata kedua, ambil huruf pertamanya juga
    if (kata.length > 1 && kata[1].isNotEmpty) {
      inisial += kata[1][0].toUpperCase();
    }

    return inisial;
  }

  Future<void> _bukaTambahCatatan() async {
    final hasil = await Navigator.pushNamed(context, '/tambah');

    if (hasil is Catatan) {
      setState(() => _catatan.add(hasil));
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Catatan "${hasil.judul}" ditambahkan')),
      );
    }
  }

  // Tugas 1
  Future<void> _bukaEditCatatan(Catatan catatanLama) async {
    final hasil = await Navigator.pushNamed(
      context,
      '/tambah',
      arguments: catatanLama,
    );

    if (hasil is Catatan) {
      setState(() {
        final index = _catatan.indexOf(catatanLama);
        if (index != -1) _catatan[index] = hasil;
      });
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Catatan "${hasil.judul}" diperbarui')),
      );
    }
  }

  void _hapusCatatan(Catatan c) {
    setState(() => _catatan.remove(c));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Catatan "${c.judul}" dihapus')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final tampil = _catatanTerfilter;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Catatan Mahasiswa'),
        actions: [
          // Tugas 2: Dropdown Filter di AppBar Home
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: DropdownButton<String>(
              value: _filterKategori,
              underline: const SizedBox(),
              dropdownColor: const Color(0xFFAEB5FF),
              style: const TextStyle(color: Color(0xFF1E293B), fontSize: 14, fontWeight: FontWeight.bold),
              icon: const Icon(Icons.filter_list_rounded, color: Color(0xFF1E293B)),
              items: _kategoriOpsi
                  .map((k) => DropdownMenuItem(
                value: k,
                child: Text(k, style: const TextStyle(color: Color(0xFF1E293B))),
              ))
                  .toList(),
              onChanged: (v) => setState(() => _filterKategori = v!),
            ),
          ),
        ],
      ),
      body: tampil.isEmpty
          ? _EmptyState(isFiltered: _filterKategori != 'Semua', kategori: _filterKategori)
          : ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        itemCount: tampil.length,
        itemBuilder: (context, i) {
          final c = tampil[i];
          return Card(
            margin: const EdgeInsets.only(bottom: 10),
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              title: Text(
                c.judul,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              subtitle: Padding(
                padding: const EdgeInsets.only(top: 4.0),
                child: Text('${c.kategori} • ${_formatTanggal(c.dibuatPada)}', style: TextStyle(color: Colors.grey.shade600)),
              ),
              leading: CircleAvatar(
                backgroundColor: const Color(0xFFAEB5FF).withOpacity(0.2),
                foregroundColor: const Color(0xFFAEB5FF),
                child: Text(_getInisial(c.judul), style: const TextStyle(fontWeight: FontWeight.bold)),
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit_outlined, color: Color(0xFFAEB5FF)),
                    onPressed: () => _bukaEditCatatan(c),
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete_outline, color: Colors.redAccent),
                    onPressed: () => _hapusCatatan(c),
                  ),
                ],
              ),
              onTap: () async {
                // Tugas 1
                final hasil = await Navigator.pushNamed(context, '/detail', arguments: c);
                if (hasil is Catatan) {
                  setState(() {
                    final index = _catatan.indexOf(c);
                    if (index != -1) _catatan[index] = hasil;
                  });
                  if (!mounted) return;
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Catatan "${hasil.judul}" diperbarui')),
                  );
                }
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _bukaTambahCatatan,
        child: const Icon(Icons.add),
      ),
    );
  }
}

// EMPTY STATE WIDGET
class _EmptyState extends StatelessWidget {
  final bool isFiltered;
  final String kategori;

  const _EmptyState({this.isFiltered = false, this.kategori = ''});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.notes_outlined, size: 80, color: Colors.grey.shade300),
          const SizedBox(height: 16),
          Text(
            isFiltered ? 'Tidak ada catatan\nkategori "$kategori"' : 'Belum ada catatan',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18, color: Colors.grey[600], fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 8),
          Text(
            isFiltered ? 'Coba pilih kategori lain atau tambah catatan baru' : 'Tap tombol Tambah untuk membuat catatan baru',
            style: TextStyle(fontSize: 13, color: Colors.grey[400]),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

// TAMBAH / EDIT CATATAN PAGE (REUSE MODE)
class TambahCatatanPage extends StatefulWidget {
  final Catatan? catatanLama; // Null = Tambah, Ada isi = Edit

  const TambahCatatanPage({super.key, this.catatanLama});

  @override
  State<TambahCatatanPage> createState() => _TambahCatatanPageState();
}

class _TambahCatatanPageState extends State<TambahCatatanPage> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _judulCtrl;
  late final TextEditingController _isiCtrl;
  late final TextEditingController _emailCtrl;

  late String _kategori;
  final _kategoriOpsi = const ['Kuliah', 'Tugas', 'Pribadi', 'Lainnya'];

  bool get _isEditMode => widget.catatanLama != null;

  @override
  void initState() {
    super.initState();
    final lama = widget.catatanLama;
    // Tugas 1
    _judulCtrl = TextEditingController(text: lama?.judul ?? '');
    _isiCtrl = TextEditingController(text: lama?.isi ?? '');
    _emailCtrl = TextEditingController(text: lama?.email ?? '');
    _kategori = lama?.kategori ?? 'Kuliah';
  }

  @override
  void dispose() {
    _judulCtrl.dispose();
    _isiCtrl.dispose();
    _emailCtrl.dispose();
    super.dispose();
  }

  void _simpan() {
    if (!_formKey.currentState!.validate()) return;

    final hasil = Catatan(
      judul: _judulCtrl.text.trim(),
      isi: _isiCtrl.text.trim(),
      kategori: _kategori,
      email: _emailCtrl.text.trim(),
      dibuatPada: widget.catatanLama?.dibuatPada ?? DateTime.now(), // Pertahankan tgl asli jika edit
    );

    Navigator.pop(context, hasil);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_isEditMode ? 'Edit Catatan' : 'Tambah Catatan'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            // Field Judul
            TextFormField(
              controller: _judulCtrl,
              textCapitalization: TextCapitalization.sentences,
              decoration: const InputDecoration(labelText: 'Judul', prefixIcon: Icon(Icons.title)),
              validator: (v) {
                if (v == null || v.trim().isEmpty) return 'Judul wajib diisi';
                if (v.trim().length < 3) return 'Minimal 3 karakter';
                return null;
              },
            ),
            const SizedBox(height: 16),

            // Dropdown Kategori
            DropdownButtonFormField<String>(
              value: _kategori,
              decoration: const InputDecoration(labelText: 'Kategori', prefixIcon: Icon(Icons.category_outlined)),
              items: _kategoriOpsi.map((k) => DropdownMenuItem(value: k, child: Text(k))).toList(),
              onChanged: (v) => setState(() => _kategori = v!),
            ),
            const SizedBox(height: 16),

            // Tugas 3
            TextFormField(
              controller: _emailCtrl,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                labelText: 'Email Pengirim',
                prefixIcon: Icon(Icons.email_outlined),
                hintText: 'contoh@gmail.com',
              ),
              validator: (v) {
                if (v == null || v.trim().isEmpty) return 'Email wajib diisi';
                // Pattern Regex Validasi Format Email
                final emailRegex = RegExp(r'^[a-zA-Z0-9._%+\-]+@[a-zA-Z0-9.\-]+\.[a-zA-Z]{2,}$');
                if (!emailRegex.hasMatch(v.trim())) {
                  return 'Format email tidak valid (contoh: nama@gmail.com)';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),

            // Field Isi
            TextFormField(
              controller: _isiCtrl,
              maxLines: 5,
              textCapitalization: TextCapitalization.sentences,
              decoration: const InputDecoration(labelText: 'Isi Catatan', prefixIcon: Icon(Icons.notes), alignLabelWithHint: true),
              validator: (v) => (v == null || v.trim().isEmpty) ? 'Isi wajib diisi' : null,
            ),
            const SizedBox(height: 24),

            // Tombol Aksi Dinamis
            FilledButton.icon(
              onPressed: _simpan,
              style: FilledButton.styleFrom(
                foregroundColor: const Color(0xFF1E293B),
              ),
              label: Text(_isEditMode ? 'Simpan Perubahan' : 'Simpan Catatan'),
            ),
          ],
        ),
      ),
    );
  }
}

// DETAIL CATATAN PAGE
class DetailCatatanPage extends StatelessWidget {
  final Catatan catatan;
  const DetailCatatanPage({super.key, required this.catatan});

  String _formatTanggal(DateTime dt) {
    const bulan = ['', 'Januari', 'Februari', 'Maret', 'April', 'Mei', 'Juni', 'Juli', 'Agustus', 'September', 'Oktober', 'November', 'Desember'];
    return '${dt.day} ${bulan[dt.month]} ${dt.year}, ${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Catatan'),
        actions: [
          // Tugas 1: Tombol Edit di Detail → Arahkan ke form dengan data lama
          IconButton(
            icon: const Icon(Icons.edit_outlined),
            tooltip: 'Edit catatan',
            onPressed: () async {
              final hasil = await Navigator.pushNamed(
                context,
                '/tambah',
                arguments: catatan, // Melempar data objek saat ini ke form edit
              );
              if (hasil is Catatan && context.mounted) {
                Navigator.pop(context, hasil); // Mengirim balik objek terbaru ke Home
              }
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(catatan.judul, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),

            // Komponen Badge Kategori Baru
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: const Color(0xFFAEB5FF).withOpacity(0.15),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                catatan.kategori,
                style: const TextStyle(color: Color(0xFFAEB5FF), fontWeight: FontWeight.bold, fontSize: 12),
              ),
            ),
            const SizedBox(height: 16),

            // Metadata Row (Tanggal & Email)
            Row(
              children: [
                const Icon(Icons.access_time, size: 16, color: Colors.grey),
                const SizedBox(width: 6),
                Text(_formatTanggal(catatan.dibuatPada), style: TextStyle(color: Colors.grey[600], fontSize: 13)),
              ],
            ),
            const SizedBox(height: 6),
            Row(
              children: [
                const Icon(Icons.email_outlined, size: 16, color: Colors.grey),
                const SizedBox(width: 6),
                Text(catatan.email, style: TextStyle(color: Colors.grey[600], fontSize: 13)),
              ],
            ),
            const Divider(height: 40, thickness: 1),

            // Isi Catatan
            Text(catatan.isi, style: const TextStyle(fontSize: 16, height: 1.6, color: Colors.black87)),
            const SizedBox(height: 40),

            // Tombol Kembali
            SizedBox(
              width: double.infinity,
              child: FilledButton.icon(
                onPressed: () => Navigator.pop(context),
                style: FilledButton.styleFrom(
                  foregroundColor: const Color(0xFF1E293B),
                ),
                label: const Text('Kembali ke Daftar'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
