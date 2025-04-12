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
      home: MyWidget(),
    );
  }
}

class MyWidget extends StatefulWidget {
  @override
  _MyWidgetState createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  int _selectedIndex = 0;
  final List<Map<String, String>> _notes = []; // Stores notes with categories

  @override
  Widget build(BuildContext context) {
    return MyHomePage(
      selectedIndex: _selectedIndex,
      notes: _notes,
      onNewNote: (newNote, category) {
        setState(() {
          _notes.add({"title": newNote, "category": category});
        });
      },
      onDeleteNote: (index) {
        setState(() {
          _notes.removeAt(index);
        });
      },
      onPageChange: (index) {
        setState(() {
          _selectedIndex = index;
        });
      },
    );
  }
}

class MyHomePage extends StatelessWidget {
  final int selectedIndex;
  final List<Map<String, String>> notes;
  final Function(String, String) onNewNote;
  final Function(int) onDeleteNote;
  final Function(int) onPageChange;

  const MyHomePage({
    super.key,
    required this.selectedIndex,
    required this.notes,
    required this.onNewNote,
    required this.onDeleteNote,
    required this.onPageChange,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: selectedIndex,
        children: [
          NotesPage(
            notes: notes,
            onNewNote: onNewNote,
            onDeleteNote: onDeleteNote,
          ),
          HomePage(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: onPageChange,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.notes),
            label: "Notes",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: "Setting",
          ),
        ],
        selectedItemColor: const Color(0xFF0D47A1),
        unselectedItemColor: Colors.grey,
        showSelectedLabels: true,
        showUnselectedLabels: true,
      ),
    );
  }
}

class NotesPage extends StatefulWidget {
  final List<Map<String, String>> notes;
  final Function(String, String) onNewNote;
  final Function(int) onDeleteNote;

  const NotesPage({
    super.key,
    required this.notes,
    required this.onNewNote,
    required this.onDeleteNote,
  });

  @override
  _NotesPageState createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notebook App"),
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: const Color(0xFF0D47A1),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [Tab(text: "All Notes"), Tab(text: "Categories")],
          labelColor: Colors.blue,
          unselectedLabelColor: Colors.grey,
          indicatorColor: Colors.blue,
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          AllNotesPage(
            notes: widget.notes,
            onDeleteNote: widget.onDeleteNote,
          ),
          CategoriesPage(
            notes: widget.notes,
            onDeleteNote: widget.onDeleteNote,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddNoteBottomSheet(context);
        },
        backgroundColor: const Color(0xFF0D47A1),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  void _showAddNoteBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return AddNoteBottomSheet(
          onNoteAdded: widget.onNewNote,
        );
      },
    );
  }
}

class AllNotesPage extends StatelessWidget {
  final List<Map<String, String>> notes;
  final Function(int) onDeleteNote;

  const AllNotesPage(
      {super.key, required this.notes, required this.onDeleteNote});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            "All Notes",
            style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF0D47A1)),
          ),
        ),
        Expanded(
          child: notes.isEmpty
              ? const Center(child: Text("No notes available"))
              : ListView.builder(
                  itemCount: notes.length,
                  itemBuilder: (context, index) {
                    return Card(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      child: ListTile(
                        title: Text(notes[index]["title"]!),
                        subtitle:
                            Text("Category: ${notes[index]["category"]!}"),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            onDeleteNote(index);
                          },
                        ),
                      ),
                    );
                  },
                ),
        ),
      ],
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Center();
  }
}

class AddNoteBottomSheet extends StatefulWidget {
  final Function(String, String) onNoteAdded;

  const AddNoteBottomSheet({super.key, required this.onNoteAdded});

  @override
  _AddNoteBottomSheetState createState() => _AddNoteBottomSheetState();
}

class _AddNoteBottomSheetState extends State<AddNoteBottomSheet> {
  final TextEditingController _noteController = TextEditingController();
  String _selectedCategory = "General";

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text("Add a New Note",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          TextField(
              controller: _noteController,
              decoration: const InputDecoration(labelText: "Note Title")),
          DropdownButton<String>(
            value: _selectedCategory,
            items: ["General", "Work", "Personal", "Study"]
                .map((cat) => DropdownMenuItem(value: cat, child: Text(cat)))
                .toList(),
            onChanged: (value) {
              setState(() {
                _selectedCategory = value!;
              });
            },
          ),
          ElevatedButton(
            onPressed: () {
              if (_noteController.text.isNotEmpty) {
                widget.onNoteAdded(_noteController.text, _selectedCategory);
                Navigator.pop(context);
              }
            },
            child: const Text("Save"),
          ),
        ],
      ),
    );
  }
}

class CategoriesPage extends StatelessWidget {
  final List<Map<String, String>> notes;
  final Function(int) onDeleteNote;

  const CategoriesPage({
    super.key,
    required this.notes,
    required this.onDeleteNote,
  });

  @override
  Widget build(BuildContext context) {
    // Group notes by category
    Map<String, List<Map<String, String>>> categorizedNotes = {};
    for (var note in notes) {
      String category = note['category'] ?? "General";
      if (!categorizedNotes.containsKey(category)) {
        categorizedNotes[category] = [];
      }
      categorizedNotes[category]!.add(note);
    }

    // Define your 4 categories
    List<String> categories = ["General", "Work", "Personal", "Study"];

    return ListView.builder(
      itemCount: categories.length,
      itemBuilder: (context, index) {
        String category = categories[index];
        List<Map<String, String>> notesInCategory =
            categorizedNotes[category] ?? [];

        return ExpansionTile(
          title: Text(
            category,
            style: const TextStyle(fontSize: 20, color: Color(0xFF0D47A1)),
          ),
          children: notesInCategory.isEmpty
              ? [const ListTile(title: Text("No notes in this category"))]
              : notesInCategory.asMap().entries.map((entry) {
                  int noteIndex = notes.indexOf(entry.value);
                  return ListTile(
                    title: Text(entry.value['title']!),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        onDeleteNote(noteIndex);
                      },
                    ),
                  );
                }).toList(),
        );
      },
    );
  }
}
