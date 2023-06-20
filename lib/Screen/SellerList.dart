import 'package:cached_network_image/cached_network_image.dart';
import 'package:eshop_multivendor/Helper/Color.dart';
import 'package:eshop_multivendor/Helper/Session.dart';
import 'package:eshop_multivendor/Helper/String.dart';
import 'package:eshop_multivendor/Model/Section_Model.dart';
import 'package:eshop_multivendor/Provider/HomeProvider.dart';
import 'package:eshop_multivendor/Provider/UserProvider.dart';
import 'package:eshop_multivendor/Screen/SubCategory.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';

import 'HomePage.dart';
import 'Seller_Details.dart';

class SellerList extends StatefulWidget {
  final catId;
  final subId;
  final catName;
  final getByLocation;

  const SellerList(
      {Key? key, this.catId, this.subId, this.catName, this.getByLocation})
      : super(key: key);

  @override
  _SellerListState createState() => _SellerListState();
}

class _SellerListState extends State<SellerList> {
  List<Product> sellerLists = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSeller();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(getTranslated(context, 'SHOP_BY_SELLER')!, context),
      body: ListView.builder(
        itemCount: sellerLists.length,
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        physics: ClampingScrollPhysics(),
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
            child: GestureDetector(
              onTap: () async {
                if(sellerLists[index].online == "1"){
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SubCategory(
                            title: sellerLists[index].store_name.toString(),
                            sellerId: sellerLists[index].seller_id.toString(),
                            sellerData: sellerLists[index],
                            catId: widget.catId,
                          )));
                } else {
                  setSnackbar("Store Close!");
                }

                // if (widget.subId == null) {
                //   await Navigator.push(
                //       context,
                //       MaterialPageRoute(
                //         builder: (context) => ProductList(
                //           name: widget.catName,
                //           id: widget.catId,
                //           tag: false,
                //           fromSeller: false,
                //         ),
                //       ));
                // } else {
                //   await Navigator.push(
                //       context,
                //       MaterialPageRoute(
                //         builder: (context) => SubCategory(
                //           title: widget.catName,
                //         ),
                //       ));
                // }

                // Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //         builder: (context) => SellerProfile(
                //               sellerStoreName:
                //               sellerLists[index].store_name ?? "",
                //               sellerRating:
                //               sellerLists[index].seller_rating ?? "",
                //               sellerImage:
                //               sellerLists[index].seller_profile ?? "",
                //               sellerName: sellerLists[index].seller_name ?? "",
                //               sellerID: sellerLists[index].seller_id,
                //               storeDesc: sellerLists[index].store_description,
                //             )));
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: Container(
                      // decoration: BoxDecoration(
                      //     borderRadius: BorderRadius.circular(10),
                      //     image: DecorationImage(
                      //         fit: BoxFit.cover,
                      //         // opacity: .05,
                      //         image: NetworkImage(
                      //             sellerList[index].seller_profile!))
                      //             ),
                      child: Row(
                        children: [
                          SizedBox(width: 5,),
                          Container(
                            height: 75,
                            width: 80,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: FadeInImage(
                                fadeInDuration: Duration(milliseconds: 150),
                                image: CachedNetworkImageProvider(
                                  sellerLists[index].seller_profile!,
                                ),
                                fit: BoxFit.cover,
                                imageErrorBuilder:
                                    (context, error, stackTrace) =>
                                        erroWidget(50),
                                placeholder: placeHolder(50),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                ListTile(
                                  dense:true,
                                  title:
                                      Text("${sellerLists[index].store_name!}"),
                                  subtitle: Text(
                                    "${sellerLists[index].store_description!}",
                                    maxLines: 2,
                                  ),
                                  trailing: sellerLists[index].online == "1"
                                      ? Text("Open",
                                    style: TextStyle(
                                      color: Colors.green
                                    ),
                                  )
                                      : Text("Close",
                                    style: TextStyle(
                                        color: Colors.red
                                    ),
                                  ),
                                ),
                                Divider(height: 0,),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      FittedBox(
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.star_rounded,
                                              color: Colors.amber,
                                              size: 15,
                                            ),
                                            Text(
                                              "${sellerLists[index].seller_rating!}",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .caption!
                                                  .copyWith(
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .fontColor,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 14),
                                            ),
                                          ],
                                        ),
                                      ),
                                      sellerLists[index].estimated_time != ""
                                          ? FittedBox(
                                              child: Container(
                                                  child: Center(
                                                child: Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 5,
                                                      vertical: 2),
                                                  child: Text(
                                                    "${sellerLists[index].estimated_time}",
                                                    style:
                                                        TextStyle(fontSize: 14),
                                                  ),
                                                ),
                                              )),
                                            )
                                          : Container(),
                                      sellerLists[index].food_person != ""
                                          ? FittedBox(
                                              child: Container(
                                                  child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 5,
                                                        vertical: 1),
                                                child: Text(
                                                  "${sellerLists[index].food_person}",
                                                  style:
                                                      TextStyle(fontSize: 14),
                                                ),
                                              )),
                                            )
                                          : Container(),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void getSeller() {
    String pin = context.read<UserProvider>().curPincode;
    var loc = Provider.of<LocationProvider>(context, listen: false);
    Map parameter = {};
    if (widget.getByLocation) {
      parameter = {"lat": "${loc.lat}", "lang": "${loc.lng}"};
    } else {
      parameter = {
        "lat": "${loc.lat}",
        "lang": "${loc.lng}",
        "cat_id": "${widget.catId}"
      };
    }
    apiBaseHelper.postAPICall(getSellerApi, parameter).then((getdata) {
      print(parameter);
      bool error = getdata["error"];
      String? msg = getdata["message"];
      if (!error) {
        var data = getdata["data"];
        sellerLists =
            (data as List).map((data) => new Product.fromSeller(data)).toList();

        setState(() {});
      } else {
        setSnackbar(msg!);
      }

      context.read<HomeProvider>().setSellerLoading(false);
    }, onError: (error) {
      setSnackbar(error.toString());
      context.read<HomeProvider>().setSellerLoading(false);
    });
  }

  setSnackbar(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(new SnackBar(
      content: new Text(
        msg,
        textAlign: TextAlign.center,
        style: TextStyle(color: Theme.of(context).colorScheme.black),
      ),
      backgroundColor: Theme.of(context).colorScheme.white,
      elevation: 1.0,
    ));
  }

  Widget catItem(int index, BuildContext context) {
    return GestureDetector(
      child: Column(
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(25.0),
                  child: FadeInImage(
                    image: CachedNetworkImageProvider(
                        sellerLists[index].seller_profile!),
                    fadeInDuration: Duration(milliseconds: 150),
                    fit: BoxFit.fill,
                    imageErrorBuilder: (context, error, stackTrace) =>
                        erroWidget(50),
                    placeholder: placeHolder(50),
                  )),
            ),
          ),
          Text(
            sellerLists[index].seller_name! + "\n",
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context)
                .textTheme
                .caption!
                .copyWith(color: Theme.of(context).colorScheme.fontColor),
          )
        ],
      ),
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => SellerProfile(
                      sellerStoreName: sellerLists[index].store_name ?? "",
                      sellerRating: sellerLists[index].seller_rating ?? "",
                      sellerImage: sellerLists[index].seller_profile ?? "",
                      sellerName: sellerLists[index].seller_name ?? "",
                      sellerID: sellerLists[index].seller_id,
                      storeDesc: sellerLists[index].store_description,
                    )));
      },
    );
  }
}
