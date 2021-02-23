import 'package:flutter/material.dart';
import 'package:internationalization/localization/languageDelegate.dart';
import 'package:internationalization/presentation/widgets/customDropdown.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l = LanguageDelegate.of(context);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blueAccent,
          title: Text(l.translate('title')),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 50,
              ),
              Container(
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: CustomDropdown())),
     
              SizedBox(
                height: 30,
              ),
              Container(
                  margin: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(11),
                      color: Colors.white,
                      border: Border.all(color: Colors.grey[300]),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.blueAccent, offset: Offset(2, 6))
                      ]),
                  child: Text(
                    l.translate('investigation'),
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  )),
            ],
          ),
        ));
  }
}
