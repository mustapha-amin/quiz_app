import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quiz_app/constants.dart';
import 'package:quiz_app/shared/category_card.dart';
import '../models/categories.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Category> categories = trivia_categories['categories']!
      .map((e) => Category.fromJson(e))
      .toList();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("Quizzly", style: GoogleFonts.lato(fontSize: 30),),
        elevation: 0,
      ),
      body: ListView.builder (
        physics: const BouncingScrollPhysics(),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          Category category = categories[index];
          return CategoryCard(
            category: category,
          );
        },
      ),
    );
  }
}
