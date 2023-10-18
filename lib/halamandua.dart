import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HalamanDua extends StatefulWidget {
  const HalamanDua({super.key});

  @override
  State<HalamanDua> createState() => _HalamanDuaState();
}

class _HalamanDuaState extends State<HalamanDua> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  late Future<double> _hasil;

  @override
  void initState() {
    super.initState();
    _hasil = _prefs.then((SharedPreferences prefs) {
      return prefs.getDouble('hasil') ?? 0.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FutureBuilder<double>(
        future: _hasil,
        builder: (BuildContext context, AsyncSnapshot<double> snapshot) {
          return Text(snapshot.data.toString());
        },
      ),
    );
  }
}
