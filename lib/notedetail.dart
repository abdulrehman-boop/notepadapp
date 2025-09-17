import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NoteDetailPage extends StatelessWidget {
  final Map note;
  const NoteDetailPage({required this.note, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(note["title"] ?? "Note",
            style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
        backgroundColor: const Color(0xFF6C63FF),
      ),
      backgroundColor: const Color(0xFFF5F5F5),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Hero(
          tag: note["_id"],
          child: Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            elevation: 8,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Text(
                note["content"] ?? "",
                style: GoogleFonts.poppins(fontSize: 18, height: 1.6, color: Colors.black87),
              ),
            ),
          ),
        ),
      ),
    );
  }
}