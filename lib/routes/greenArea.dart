import 'package:flutter/material.dart';
import 'package:greenforma/routes/googleMap/directions_model.dart';
import 'package:greenforma/routes/googleMap/directions_repository.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class formingStruc extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  GoogleMapController _controller;

  List<Marker> allMarkers = [];

  PageController _pageController;

  int prevPage;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    marKers.forEach((element) {
      allMarkers.add(Marker(
          markerId: MarkerId(element.markernamePlace),
          draggable: false,
          infoWindow:
          InfoWindow(title: element.markernamePlace, snippet: element.address),
          position: element.locationCoords));
    });
    _pageController = PageController(initialPage: 1, viewportFraction: 0.8)
      ..addListener(_onScroll);
  }

  void _onScroll() {
    if (_pageController.page.toInt() != prevPage) {
      prevPage = _pageController.page.toInt();
      moveCamera();
    }
  }

  _locationShopList(index) {
    return AnimatedBuilder(
      animation: _pageController,
      builder: (BuildContext context, Widget widget) {
        double value = 1;
        if (_pageController.position.haveDimensions) {
          value = _pageController.page - index;
          value = (1 - (value.abs() * 0.3) + 0.06).clamp(0.0, 1.0);
        }
        return Center(
          child: SizedBox(
            height: Curves.easeInOut.transform(value) * 125.0,
            width: Curves.easeInOut.transform(value) * 350.0,
            child: widget,
          ),
        );
      },
      child: InkWell(
          onTap: () {
            // moveCamera();
          },
          child: Stack(children: [
            Center(
                child: Container(
                    margin: EdgeInsets.symmetric(
                      horizontal: 10.0,
                      vertical: 20.0,
                    ),
                    height: 125.0,
                    width: 275.0,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black54,
                            offset: Offset(0.0, 4.0),
                            blurRadius: 10.0,
                          ),
                        ]),
                    child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: Colors.white),
                        child: Row(children: [
                          Container(
                              height: 90.0,
                              width: 90.0,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(10.0),
                                      topLeft: Radius.circular(10.0)),
                                  image: DecorationImage(
                                      image: NetworkImage(
                                          marKers[index].thumbNail),
                                      fit: BoxFit.cover))),
                          SizedBox(width: 5.0),
                          Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  marKers[index].markernamePlace,
                                  style: TextStyle(
                                      fontSize: 12.5,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  marKers[index].address,
                                  style: TextStyle(
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.w600),
                                ),
                                Container(
                                  width: 170.0,
                                  child: Text(
                                    marKers[index].description,
                                    style: TextStyle(
                                        fontSize: 11.0,
                                        fontWeight: FontWeight.w300),
                                  ),
                                )
                              ])
                        ]))))
          ])),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Maps'),
          centerTitle: true,
        ),
        body: Stack(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height - 50.0,
              width: MediaQuery.of(context).size.width,
              child: GoogleMap(
                initialCameraPosition: CameraPosition(
                    target: LatLng(33.589886,-7.603869), zoom: 12.0),
                markers: Set.from(allMarkers),
                onMapCreated: mapCreated,
              ),
            ),
            Positioned(
              bottom: 20.0,
              child: Container(
                height: 200.0,
                width: MediaQuery.of(context).size.width,
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: marKers.length,
                  itemBuilder: (BuildContext context, int index) {
                    return _locationShopList(index);
                  },
                ),
              ),
            )
          ],
        ));
  }

  void mapCreated(controller) {
    setState(() {
      _controller = controller;
    });
  }

  moveCamera() {
    _controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: marKers[_pageController.page.toInt()].locationCoords,
        zoom: 14.0,
        bearing: 45.0,
        tilt: 45.0)));
  }
}



class location {
  String markernamePlace;
  String address;
  String description;
  String thumbNail;
  LatLng locationCoords;

  location(
      {this.markernamePlace,
        this.address,
        this.description,
        this.thumbNail,
        this.locationCoords});
}

final List<location> marKers = [
  location(
      markernamePlace: 'Marina Shopping Center',
      address: 'J94H+MV Casablanca',
      description:
      'marina shopping center',
      locationCoords: LatLng(33.607534, -7.621407),
      thumbNail: 'https://lh5.googleusercontent.com/p/AF1QipM8515X8KBwcsHeFHXNdK3ebSLuOni4paw_ZnH1=w408-h306-k-no'
  ),
  location(
      markernamePlace: 'Royal Golf Anfa',
      address: 'Casablanca',
      description:
      'H8PV+P76, Casablanca 20250',
      locationCoords: LatLng(33.587774, -7.656924),
      thumbNail: 'https://lh5.googleusercontent.com/p/AF1QipMSR_FYuy_zHGY3cNPN0EZ6__Cihn3jGD9IWvRH=w408-h261-k-no'
  ),
  location(
      markernamePlace: 'Ancienne Medina',
      address: 'casablanca',
      description:
      'Medina old town',
      locationCoords: LatLng(33.600416, -7.626200),
      thumbNail: 'https://lh5.googleusercontent.com/p/AF1QipMUMGLz614cXU86VXMUcwW50N3lKqLJg34m5yb_=w408-h276-k-no'
  ),
  location(
      markernamePlace: 'Sindibad',
      address: 'ain diab casablanca',
      description:
      'a parc for everyone.',
      locationCoords: LatLng(33.580232, -7.693514),
      thumbNail: 'https://lh5.googleusercontent.com/p/AF1QipPJFKut_Vkxez9K0zh_YsQFScaYFQcuXTNYCgts=w408-h306-k-no'
  ),
  location(
      markernamePlace: 'Parc Isesco Murdokh',
      address: 'Habous, Casablanca',
      description:
      'jardin murdokh.',
      locationCoords: LatLng(33.580004, -7.613787),
      thumbNail: 'https://lh5.googleusercontent.com/p/AF1QipOv-1lKzAoaVcjpHJLC8WsiRBKJCvDP5YiprfGi=w408-h306-k-no'
  )
];