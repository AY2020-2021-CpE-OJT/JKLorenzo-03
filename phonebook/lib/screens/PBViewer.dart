import 'package:flutter/material.dart';
import 'package:phonebook/structures/PBData.dart';
import '../helpers/DB.dart';

class PBViewer extends StatelessWidget {
  const PBViewer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final data = DB.pull();
    final text_style = const TextStyle(fontSize: 18.0);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Phonebook: View Contacts'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView(
          children: data.map((this_data) {
            return Column(
              children: [
                Row(
                  children: [
                    Icon(Icons.person),
                    Text(
                      '${this_data.first_name} ${this_data.last_name}',
                      style: text_style,
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.phone),
                    Text(
                      this_data.phone_numbers.join('\n'),
                      style: text_style,
                    ),
                  ],
                )
              ],
            );
          }).toList(),
        ),
      ),
    );
  }
}
