import 'package:flutter/material.dart';

class ErrorPage extends StatelessWidget {
  const ErrorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
      ),
      body:  Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(
              Icons.error_outline_sharp,
              color: Colors.red,
              size: 60,
            ),
            Text("An error occurred"),
            Text("Select another category of questions e.g easy, to see if the error goes away")
          ],
        ),
      ),
    );
  }
}
