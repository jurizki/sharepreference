import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'halamandua.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Demo',
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  final TextEditingController _angka1 = TextEditingController();
  final TextEditingController _angka2 = TextEditingController();
  final TextEditingController _operasi = TextEditingController();
  late double hasil;

  Future<void> _cariHasil() async {
    final SharedPreferences prefs = await _prefs;

    setState(() {
      prefs.setDouble('hasil', hasil);
    });

    // ignore: use_build_context_synchronously
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const HalamanDua(),
      ),
    );
  }

  void _hitung() {
    int bilangan1 = int.parse(_angka1.text);
    int bilangan2 = int.parse(_angka2.text);
    switch (_operasi.text) {
      case "+":
        setState(() {
          hasil = (bilangan1 + bilangan2).toDouble();
        });
      case "-":
        setState(() {
          hasil = (bilangan1 - bilangan2).toDouble();
        });
      case "*":
        setState(() {
          hasil = (bilangan1 * bilangan2).toDouble();
        });
      case "/":
        setState(() {
          hasil = bilangan1 / bilangan2;
        });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 400),
        child: Column(
          children: [
            const Text('nomor pertama'),
            TextField(
              controller: _angka1,
            ),
            const SizedBox(height: 32),
            const Text('nomor kedua'),
            TextField(
              controller: _angka2,
            ),
            const SizedBox(height: 32),
            const Text('operasi'),
            TextField(
              controller: _operasi,
            ),
            const SizedBox(height: 32),
            TextButton(onPressed: _hitung, child: const Text("Hitung")),
            TextButton(onPressed: _cariHasil, child: const Text("Lihat hasil")),
          ],
        ),
      ),
    );
  }
}
