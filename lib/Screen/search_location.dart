import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_place/google_place.dart';

class SearchLocationPage extends StatefulWidget {
  const SearchLocationPage({Key? key}) : super(key: key);

  @override
  _SearchLocationPageState createState() => _SearchLocationPageState();
}

class _SearchLocationPageState extends State<SearchLocationPage> {
  String location = "";

  search() async {
    var googlePlace = GooglePlace("AIzaSyBOhH-_4E4BPqgKR21SUOcMwqpzo_Cmt7o");
    var result = await googlePlace.search.getTextSearch(location);
    print(result.toString());
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Location"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(label: Text("Search")),
              onChanged: (value) {
                setState(() {
                  location = value;
                });
              },
            ),
          ),
          Expanded(
            child: FutureBuilder(
                future: search(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: ClampingScrollPhysics(),
                      itemCount: snapshot.data.results.length,
                      itemBuilder: (BuildContext context, int index) {
                        var data = snapshot.data.results[index];
                        return Column(
                          children: [
                            ListTile(
                              dense:true,
                              onTap: () async {
                                List<Placemark> placemarks =
                                    await placemarkFromCoordinates(
                                        data.geometry.location.lat,
                                        data.geometry.location.lng);
                                if (placemarks.isNotEmpty) {
                                  Navigator.pop(context, [
                                    placemarks,
                                    data.geometry.location.lat,
                                    data.geometry.location.lng
                                  ]);
                                }
                              },
                              leading: Icon(Icons.location_on_outlined),
                              title: Text(data.formattedAddress , style: TextStyle(
                                fontSize: 12
                              ),),
                            ),
                            Divider()
                          ],
                        );
                      },
                    );
                  } else if (snapshot.hasError) {
                    return Center(child: Text("No Place"));
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                }),
          )
        ],
      ),
    );
  }
}
