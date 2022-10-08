import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quiz_app/screens/details.dart';
import 'package:quiz_app/shared/spacings.dart';
import '../models/categories.dart';

class CategoryCard extends StatelessWidget {
  Category? category;
  CategoryCard({Key? key, this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return Detail(
                category: category,
              );
            }));
          },
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            elevation: 3,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Hero(
                    tag: '${category!.id}',
                    child: Container(
                      decoration: BoxDecoration(
                        
                        image: DecorationImage(
                        
                          fit: BoxFit.cover,
                          image: AssetImage('images/${category!.id}.png'),
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      margin: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 5),
                      height: size.height / 5.7,
                      constraints: BoxConstraints(
                        maxHeight: size.height / 4.5,
                      ),
                      width: size.width / 3,
                    ),
                  ),
                  addHorizontalSpacing(40),
                  Expanded(
                    child: Text(
                      category!.name!,
                      style: GoogleFonts.lato(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        addVerticalSpacing(10),
      ],
    );
  }
}
