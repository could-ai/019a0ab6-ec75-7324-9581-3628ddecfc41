import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Medical Notes | Way to Career with Sheik',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Arial',
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String selectedCategory = 'All';
  String searchQuery = '';

  final List<Map<String, String>> notes = [
    {
      'title': 'Anatomy Notes',
      'description': 'Clear diagrams and explanations for MBBS 1st year students.',
      'category': 'MBBS',
    },
    {
      'title': 'Pharmacology Notes',
      'description': 'Complete Pharm D pharmacology unit-wise notes.',
      'category': 'PharmD',
    },
    {
      'title': 'Microbiology Notes',
      'description': 'Comprehensive microbiology notes for paramedical students.',
      'category': 'Paramedical',
    },
    {
      'title': 'Nursing Fundamentals',
      'description': 'Basic nursing principles and practices.',
      'category': 'Nursing',
    },
    {
      'title': 'Allied Health Sciences',
      'description': 'Essential notes for allied health professionals.',
      'category': 'Allied',
    },
    {
      'title': 'Physiotherapy Techniques',
      'description': 'Advanced physiotherapy methods and exercises.',
      'category': 'Physiotherapy',
    },
    {
      'title': 'Biotechnology Basics',
      'description': 'Fundamental concepts in biotechnology.',
      'category': 'Biotech',
    },
    {
      'title': 'Pathology Notes',
      'description': 'Detailed pathology notes for medical students.',
      'category': 'MBBS',
    },
    {
      'title': 'Clinical Pharmacy',
      'description': 'Practical pharmacy notes for Pharm D students.',
      'category': 'PharmD',
    },
    {
      'title': 'Radiology Basics',
      'description': 'Introduction to radiology for paramedical courses.',
      'category': 'Paramedical',
    },
  ];

  List<Map<String, String>> get filteredNotes {
    return notes.where((note) {
      final matchesCategory = selectedCategory == 'All' || note['category'] == selectedCategory;
      final matchesSearch = note['title']!.toLowerCase().contains(searchQuery.toLowerCase()) ||
          note['description']!.toLowerCase().contains(searchQuery.toLowerCase());
      return matchesCategory && matchesSearch;
    }).toList();
  }

  void filterNotes(String category) {
    setState(() {
      selectedCategory = category;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF0077B6),
              Color(0xFF00B4D8),
              Color(0xFFCAF0F8),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Header
              Container(
                color: const Color(0xFF023E8A),
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                child: const Column(
                  children: [
                    Text(
                      'Way to Career with Sheik',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 8),
                    Text(
                      'All Medical & Paramedical Course Notes',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              // Navigation
              Container(
                color: const Color(0xFF0096C7),
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildNavButton('All Courses', 'All'),
                      _buildNavButton('MBBS', 'MBBS'),
                      _buildNavButton('Pharm D', 'PharmD'),
                      _buildNavButton('Paramedical', 'Paramedical'),
                      _buildNavButton('Nursing', 'Nursing'),
                      _buildNavButton('Allied Health', 'Allied'),
                      _buildNavButton('Physiotherapy', 'Physiotherapy'),
                      _buildNavButton('Biotechnology', 'Biotech'),
                    ],
                  ),
                ),
              ),
              // Search Bar
              Padding(
                padding: const EdgeInsets.all(20),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search notes or subjects...',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Color(0xFF0096C7), width: 2),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Color(0xFF0096C7), width: 2),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Color(0xFF0096C7), width: 2),
                    ),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  ),
                  onChanged: (value) {
                    setState(() {
                      searchQuery = value;
                    });
                  },
                ),
              ),
              // Notes Grid
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20,
                      childAspectRatio: 0.75,
                    ),
                    itemCount: filteredNotes.length,
                    itemBuilder: (context, index) {
                      final note = filteredNotes[index];
                      return _buildNoteCard(note);
                    },
                  ),
                ),
              ),
              // Footer
              Container(
                color: const Color(0xFF023E8A),
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                child: const Center(
                  child: Text(
                    'Subscribe to our YouTube channel for more updates!',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavButton(String text, String category) {
    final isSelected = selectedCategory == category;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5),
      child: ElevatedButton(
        onPressed: () => filterNotes(category),
        style: ElevatedButton.styleFrom(
          backgroundColor: isSelected ? const Color(0xFFCAF0F8) : Colors.white,
          foregroundColor: const Color(0xFF023E8A),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          elevation: 0,
        ),
        child: Text(
          text,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _buildNoteCard(Map<String, String> note) {
    return Card(
      elevation: 4,
      shadowColor: Colors.black.withOpacity(0.2),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              note['title']!,
              style: const TextStyle(
                color: Color(0xFF0077B6),
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Text(
              note['description']!,
              style: const TextStyle(
                color: Color(0xFF003049),
                fontSize: 14,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Download functionality coming soon!')),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF0077B6),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              ),
              child: const Text('Download PDF'),
            ),
          ],
        ),
      ),
    );
  }
}