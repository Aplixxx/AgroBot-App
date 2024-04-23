import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'AgroApp',
      theme: ThemeData(
        primaryColor: Colors.amber,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: RealTimeData(),
    );
  }
}

class RealTimeData extends StatelessWidget {
  RealTimeData({super.key});
  final ref = FirebaseDatabase.instance.ref('DHT_11');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text("AgroApp")),
      ),
      body: Column(
        children: [
          Expanded(
            child: FirebaseAnimatedList(
              query: ref,
              itemBuilder: (context, snapshot, animation, index) {
                return Card(
                  color: const Color.fromARGB(255, 181, 187, 115),
                  child: ListTile(
                    title: Text(snapshot.child('Name').value.toString()),
                    subtitle: Text(snapshot.child('Data').value.toString()),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
