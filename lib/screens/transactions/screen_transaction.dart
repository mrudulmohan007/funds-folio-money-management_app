import 'package:flutter/material.dart ';

class ScreenTransaction extends StatelessWidget {
  const ScreenTransaction({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: ((context, index) {
        return Card(
          child: ListTile(
            leading: Text('12 dec'),
            title: Text('10000'),
            subtitle: Text('Travel'),
          ),
        );
      }),
      separatorBuilder: (context, index) {
        return const SizedBox(
          height: 10,
        );
      },
      itemCount: 10,
    );
  }
}
