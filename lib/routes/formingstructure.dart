import 'package:flutter/material.dart';

class GreenArea extends StatelessWidget {
  List<String> names = <String>[
    'Marina Shopping Center',
    'Royal Golf Anfa',
    'Ancienne Medina',
    'Sindibad',
    'Parc Isesco Murdokh',
  ];
  List<String> images = <String>[
    'assets/marina.jpg',
    'assets/golfAnfa.jpg',
    'assets/oldTown.jpg',
    'assets/sindibad.jpg',
    'assets/murdokh.jpg',
  ];
  List<String> prices = <String>[
    'marina shopping center',
    'Royal Golf Anfa',
    'Ancienne Medina',
    'a parc for everyone',
    'Parc Isesco Murdokh',

  ];

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text('Green Area'),
          centerTitle: true,
          backgroundColor: Colors.green,
        ),
        body: Container(
          child: ListView.separated(
            itemBuilder: (context, index) {
              return Container(
                height: 140,
                child: Row(
                  children: [
                    Container(
                        width: 200,
                        child: Image.asset(images[index], fit: BoxFit.fill)),
                    Padding(
                      padding: const EdgeInsets.only(left: 30),
                      child: Column(
                        children: [
                          Text(
                            names[index],
                          ),
                          SizedBox(
                            height: 6,
                          ),
                          Text(
                            prices[index].toString(),
                          ),
                          SizedBox(
                            height: 6,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              );
            },
            itemCount: names.length,
            separatorBuilder: (BuildContext context, int index) {
              return SizedBox(
                height: 15,
              );
            },
          ),
        ),
      );
}
