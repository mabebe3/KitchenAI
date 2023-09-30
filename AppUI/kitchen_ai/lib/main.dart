import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://utspprqavxxctaxueeoc.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InV0c3BwcnFhdnh4Y3RheHVlZW9jIiwicm9sZSI6ImFub24iLCJpYXQiOjE2OTYwMzkxODIsImV4cCI6MjAxMTYxNTE4Mn0.MprNvKqpz-nP1klscESPvZcq5rfNnOcXhiHhG7ic8c0',
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'recipies',
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _future = Supabase.instance.client
      .from('recipie_list')
      .select<List<Map<String, dynamic>>>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _future,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          final recipie_list = snapshot.data!;
          return ListView.builder(
            itemCount: recipie_list.length,
            itemBuilder: ((context, index) {
              final recipies = recipie_list[index];
              return ListTile(
                title: Text(recipies['title']),
              );
            }),
          );
        },
      ),
    );
  }
}
