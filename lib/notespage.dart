import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:shimmer/shimmer.dart';
import 'notedetail.dart';

class NotesPage extends StatefulWidget {
  final String userId;
  const NotesPage({required this.userId, Key? key}) : super(key: key);

  @override
  _NotesPageState createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  List notes = [];
  bool isLoading = true;
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();

  Future<void> fetchNotes() async {
    try {
      final url = Uri.parse("https://notepad-6lla.vercel.app/notes/${widget.userId}");
      final res = await http.get(url);

      if (res.statusCode == 200) {
        final data = jsonDecode(res.body);
        if (mounted) {
          setState(() {
            notes = data;
            isLoading = false;
          });
        }
      }
    } catch (e) {
      debugPrint("❌ Error fetching notes: $e");
      setState(() => isLoading = false);
    }
  }

  Future<void> addNote() async {
    if (_titleController.text.isEmpty || _contentController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter title and content")),
      );
      return;
    }

    try {
      final url = Uri.parse("https://notepad-6lla.vercel.app/notes");
      final res = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "userId": widget.userId,
          "title": _titleController.text,
          "content": _contentController.text,
        }),
      );

      if (res.statusCode == 200) {
        _titleController.clear();
        _contentController.clear();
        fetchNotes();
      }
    } catch (e) {
      debugPrint("❌ Error adding note: $e");
    }
  }

  @override
  void initState() {
    super.initState();
    fetchNotes();
  }

  Widget shimmerLoader() {
    return ListView.builder(
      itemCount: 6,
      itemBuilder: (_, __) => Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          child: ListTile(
            title: Container(height: 16, width: 100, color: Colors.white),
            subtitle: Container(height: 14, width: 200, color: Colors.white),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Notes", style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
        backgroundColor: const Color(0xFF6C63FF),
      ),
      backgroundColor: const Color(0xFFF5F5F5),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              elevation: 6,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  children: [
                    TextField(
                      controller: _titleController,
                      decoration: const InputDecoration(
                        labelText: "Title",
                        prefixIcon: Icon(Icons.title),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: _contentController,
                      decoration: const InputDecoration(
                        labelText: "Content",
                        prefixIcon: Icon(Icons.notes),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton.icon(
                      icon: const Icon(Icons.add),
                      label: Text("Add Note", style: GoogleFonts.poppins()),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF00BFA6),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      onPressed: addNote,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: isLoading
                ? shimmerLoader()
                : notes.isEmpty
                ? Center(
              child: Text("No notes yet",
                  style: GoogleFonts.poppins(fontSize: 18, color: Colors.grey[700])),
            )
                : ListView.builder(
              itemCount: notes.length,
              itemBuilder: (_, i) {
                final note = notes[i];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => NoteDetailPage(note: note),
                      ),
                    );
                  },
                  child: Hero(
                    tag: note["_id"],
                    child: Card(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      elevation: 4,
                      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      child: ListTile(
                        title: Text(note["title"] ?? "",
                            style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
                        subtitle: Text(
                          note["content"] ?? "",
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.poppins(),
                        ),
                        trailing: const Icon(Icons.arrow_forward_ios),
                      ),
                    ),
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
