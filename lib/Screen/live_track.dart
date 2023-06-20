import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LiveTrackPage extends StatefulWidget {
  const LiveTrackPage({Key? key}) : super(key: key);

  @override
  _LiveTrackPageState createState() => _LiveTrackPageState();
}
DatabaseReference ref = FirebaseDatabase.instance.ref("users/123");
class _LiveTrackPageState extends State<LiveTrackPage> {


  Stream<DatabaseEvent> stream = ref.onValue;





  Completer<GoogleMapController> _controller = Completer();
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  Map<PolylineId, Polyline> polylines = {};
  PolylinePoints polylinePoints = PolylinePoints();
  List<LatLng> polylineCoordinates = [];
  double _originLatitude = 22.7196, _originLongitude = 75.8577;
  double _destLatitude = 23.2599, _destLongitude = 77.4126;
  String googleAPiKey = "AIzaSyBq52y-MtlJa6wtmzZ1XIz3LTbwBpaWXuU";


  late BitmapDescriptor myIcon;

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(22.7196, 75.8577),
    zoom: 14.4746,
  );

  static final CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(22.7196, 75.8577),
      // tilt: 59.440717697143555,
      zoom: 19);

  var dNewLat;
  var dNewLong;

  getDriverLocation()async{
    stream.listen((DatabaseEvent event) {
      dynamic a = event.snapshot.value;
      dNewLat = a["address"]["lat"];
      dNewLong = a["address"]["long"];
      print('Event Type: ${event.type}'); // DatabaseEventType.value;
    });
  }
  Timer mytimer = Timer.periodic(Duration(seconds: 5), (timer) {
    //code to run on every 5 seconds
  });

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BitmapDescriptor.fromAssetImage(
            ImageConfiguration(size: Size(10, 10)), 'assets/images/driver.png')
        .then((onValue) {
      myIcon = onValue;
    });
    getDriverLocation();
    _getPolyline();

  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: _kGooglePlex,
        markers: markers.values.toSet(),
        // polylines: Set<Polyline>.of(polylines.values),
        myLocationEnabled: true,
        // onMapCreated: _onMapCreated,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _driver(dNewLat , dNewLong);
        },
        child: Icon(Icons.center_focus_strong),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
  Future<void> _driver(dlat , dLong) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
    final marker = Marker(
      markerId: MarkerId('Driver'),
      position: LatLng(22.7196, 75.8577),
      icon: myIcon,
      infoWindow: InfoWindow(
        title: 'Driver Name',
        snippet: 'address',
      ),
    );
    setState(() {
      markers[MarkerId('place_name')] = marker;
    });
  }

  _addPolyLine() {
    PolylineId id = PolylineId("poly");
    Polyline polyline = Polyline(
      geodesic: true,
      jointType: JointType.round,
      width: 5,
        polylineId: id, color: Colors.red, points: polylineCoordinates);
    polylines[id] = polyline;
    setState(() {});
  }
  _getPolyline() async {
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        googleAPiKey,
        PointLatLng(_originLatitude, _originLongitude),
        PointLatLng(_destLatitude, _destLongitude),
        travelMode: TravelMode.driving , optimizeWaypoints: true);
    if (result.points.isNotEmpty) {
      print(result.points);
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    }
    _addPolyLine();
  }
}
