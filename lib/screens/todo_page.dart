import 'package:flutter/material.dart';
import 'package:todolist_app/helpers/database_helper.dart';
import 'package:todolist_app/models/todo.dart';
import 'package:todolist_app/widgets/todo_form.dart';
import 'package:todolist_app/widgets/todo_list_item.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animations/animations.dart';
import 'dart:ui';

class TodoPage extends StatefulWidget {
  const TodoPage({Key? key}) : super(key: key);

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> with SingleTickerProviderStateMixin {
  final TextEditingController _searchCtrl = TextEditingController();
  final DatabaseHelper dbHelper = DatabaseHelper();
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _searchCtrl.dispose();
    super.dispose();
  }

  Future<void> handleDelete(Todo todo) async {
    if (todo.id != null) {
      final deletedTodo = todo;
      await dbHelper.deleteTodo(todo.id!);
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Todo deleted', style: GoogleFonts.roboto(color: Colors.white)),
          action: SnackBarAction(
            label: 'Undo',
            textColor: Colors.amber,
            onPressed: () async {
              await dbHelper.addTodo(deletedTodo);
              setState(() {}); // Refresh UI setelah Undo
            },
          ),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.black87,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
      );

      setState(() {});
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to delete todo: Invalid ID', style: GoogleFonts.roboto(color: Colors.white)),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacementNamed(context, '/'); // Kembali ke LandingPage
        return false; // Mencegah keluar dari aplikasi
      },
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFF0F2027), Color(0xFF2C5364)],
            ),
          ),
          child: CustomScrollView(
            slivers: [
              _buildSliverAppBar(),
              SliverToBoxAdapter(child: _buildSearchBar()),
              SliverFadeTransition(
                opacity: _animation,
                sliver: _buildTodoList(),
              ),
            ],
          ),
        ),
        floatingActionButton: OpenContainer(
          transitionType: ContainerTransitionType.fade,
          openBuilder: (context, _) => TodoForm(
            todo: null,
            refreshList: () => setState(() {}),
          ),
          closedElevation: 6.0,
          closedShape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(16)),
          ),
          closedColor: Colors.white.withOpacity(0.1),
          closedBuilder: (context, openContainer) => FloatingActionButton.extended(
            onPressed: openContainer,
            icon: const Icon(Icons.add, color: Colors.white),
            label: Text("Add Todo", style: GoogleFonts.poppins(color: Colors.white)),
            backgroundColor: Colors.transparent,
          ),
        ),
      ),
    );
  }

  Widget _buildSliverAppBar() {
    return SliverAppBar(
      expandedHeight: 120.0,
      floating: false,
      pinned: true,
      backgroundColor: Colors.transparent,
      flexibleSpace: FlexibleSpaceBar(
        title: Text(
          'Todo List Pro',
          style: GoogleFonts.poppins(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        background: ClipRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              color: Colors.black.withOpacity(0.1),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(30),
              border: Border.all(color: Colors.white.withOpacity(0.2)),
            ),
            child: TextField(
              controller: _searchCtrl,
              onChanged: (_) => setState(() {}),
              style: GoogleFonts.roboto(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'Search todos...',
                hintStyle: GoogleFonts.roboto(color: Colors.white70),
                prefixIcon: const Icon(Icons.search, color: Colors.white70),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTodoList() {
    return StreamBuilder<List<Todo>>(
      stream: dbHelper.getAllTodos(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SliverFillRemaining(
            child: Center(child: CircularProgressIndicator(color: Colors.white)),
          );
        }

        if (snapshot.hasError) {
          return SliverFillRemaining(
            child: Center(child: Text("Error: ${snapshot.error}", style: GoogleFonts.roboto(color: Colors.white))),
          );
        }

        final todos = snapshot.data ?? [];
        final filteredTodos = todos.where((todo) =>
            todo.nama.toLowerCase().contains(_searchCtrl.text.toLowerCase()) ||
            todo.deskripsi.toLowerCase().contains(_searchCtrl.text.toLowerCase())).toList();

        if (filteredTodos.isEmpty) {
          return SliverFillRemaining(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.task, size: 64, color: Colors.white.withOpacity(0.7)),
                  const SizedBox(height: 16),
                  Text(
                    'No todos found',
                    style: GoogleFonts.roboto(fontSize: 18, color: Colors.white.withOpacity(0.7)),
                  ),
                ],
              ),
            ),
          );
        }

        return SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: TodoListItem(
                  todo: filteredTodos[index],
                  onDelete: handleDelete,
                  onToggle: (todo) async {
                    todo.done = !todo.done;
                    await dbHelper.updateTodo(todo);
                    setState(() {});
                  },
                  onEdit: (todo) => showTodoForm(context, todo, () => setState(() {})),
                ),
              );
            },
            childCount: filteredTodos.length,
          ),
        );
      },
    );
  }
}
