import 'package:flutter/material.dart';
import 'package:todolist_app/models/todo.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:ui';

class TodoListItem extends StatelessWidget {
  final Todo todo;
  final Function(Todo) onDelete;
  final Function(Todo) onToggle;
  final Function(Todo) onEdit;

  const TodoListItem({
    Key? key,
    required this.todo,
    required this.onDelete,
    required this.onToggle,
    required this.onEdit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(todo.id.toString()),
      background: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.red.withOpacity(0.3),
              borderRadius: BorderRadius.circular(15),
            ),
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.only(right: 20),
            child: const Icon(Icons.delete, color: Colors.white),
          ),
        ),
      ),
      direction: DismissDirection.endToStart,
      onDismissed: (_) => onDelete(todo),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: Colors.white.withOpacity(0.2)),
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              leading: Checkbox(
                value: todo.done,
                onChanged: (_) => onToggle(todo),
                activeColor: Colors.white.withOpacity(0.7),
                checkColor: Colors.blue,
              ),
              title: Text(
                todo.nama,
                style: GoogleFonts.roboto(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                  decoration: todo.done ? TextDecoration.lineThrough : null,
                ),
              ),
              subtitle: Text(
                todo.deskripsi,
                style: GoogleFonts.roboto(
                  fontSize: 14,
                  color: Colors.white70,
                ),
              ),
              trailing: IconButton(
                icon: const Icon(Icons.edit, color: Colors.white70),
                onPressed: () => onEdit(todo),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

