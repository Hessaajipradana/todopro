import 'package:flutter/material.dart';
import 'package:todolist_app/helpers/database_helper.dart';
import 'package:todolist_app/models/todo.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:ui';

class TodoForm extends StatefulWidget {
  final Todo? todo;
  final Function refreshList;

  const TodoForm({Key? key, this.todo, required this.refreshList}) : super(key: key);

  @override
  _TodoFormState createState() => _TodoFormState();
}

class _TodoFormState extends State<TodoForm> {
  final TextEditingController _namaCtrl = TextEditingController();
  final TextEditingController _deskripsiCtrl = TextEditingController();
  final DatabaseHelper _dbHelper = DatabaseHelper();
  bool _isNewTodo = true;

  @override
  void initState() {
    super.initState();
    if (widget.todo != null) {
      _namaCtrl.text = widget.todo!.nama;
      _deskripsiCtrl.text = widget.todo!.deskripsi;
      _isNewTodo = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFF0F2027),
                Color(0xFF2C5364),
              ],
            ),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.white.withOpacity(0.2)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.5),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  _isNewTodo ? "Add New Todo" : "Edit Todo",
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 20),
                _buildTextField(
                  controller: _namaCtrl,
                  hint: "Todo Name",
                  icon: Icons.task_alt,
                ),
                const SizedBox(height: 16),
                _buildTextField(
                  controller: _deskripsiCtrl,
                  hint: "Description",
                  icon: Icons.description,
                  maxLines: 3,
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text(
                        "Cancel",
                        style: GoogleFonts.roboto(color: Colors.white70),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: _saveTodo,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      ),
                      child: Text(
                        _isNewTodo ? "Add" : "Save",
                        style: GoogleFonts.roboto(fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    int maxLines = 1,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.white.withOpacity(0.2)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        maxLines: maxLines,
        style: GoogleFonts.roboto(color: Colors.white),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: GoogleFonts.roboto(color: Colors.white70),
          prefixIcon: Icon(icon, color: Colors.white70),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        ),
      ),
    );
  }

  void _saveTodo() async {
    if (_namaCtrl.text.isEmpty || _deskripsiCtrl.text.isEmpty) {
      _showSnackBar('Please fill in all fields', isError: true);
      return;
    }

    try {
      if (_isNewTodo) {
        await _dbHelper.addTodo(Todo(_namaCtrl.text, _deskripsiCtrl.text));
      } else {
        widget.todo!.nama = _namaCtrl.text;
        widget.todo!.deskripsi = _deskripsiCtrl.text;
        await _dbHelper.updateTodo(widget.todo!);
      }

      Navigator.pop(context);
      widget.refreshList();
      _showSnackBar(_isNewTodo ? 'Todo added successfully' : 'Todo updated successfully');
    } catch (e) {
      _showSnackBar('An error occurred. Please try again.', isError: true);
    }
  }

  void _showSnackBar(String message, {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message, style: GoogleFonts.roboto(color: Colors.white)),
        backgroundColor: isError ? Colors.red : Colors.green,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
}

void showTodoForm(BuildContext context, Todo? todo, Function refreshList) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return TodoForm(todo: todo, refreshList: refreshList);
    },
  );
}
