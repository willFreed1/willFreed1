import 'package:flutter/material.dart';

class GreenArea extends StatelessWidget {
  List<String> names = <String>[
    'speed',
    'speed',
    'speed',
    'speed',
    'speed',
  ];
  List<String> images = <String>[
    'assets/greenforma.PNG',
    'assets/greenforma.PNG',
    'assets/greenforma.PNG',
    'assets/greenforma.PNG',
    'assets/greenforma.PNG',
  ];
  List<int> prices = <int>[
    100,
    200,
    300,
    4,
    5,
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
                             Text (names[index],),
                             SizedBox(
                               height: 6,
                             ),
                            Text (prices[index].toString(),),
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
            itemCount: names.length, separatorBuilder: (BuildContext context, int index) {
              return SizedBox(height: 15,);
          },
          ),
        ),
      );
}
