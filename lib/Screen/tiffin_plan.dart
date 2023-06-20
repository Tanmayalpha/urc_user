import 'package:eshop_multivendor/Helper/Color.dart';
import 'package:eshop_multivendor/Helper/Session.dart';
import 'package:flutter/material.dart';

class TiffinPlansView extends StatefulWidget {
  const TiffinPlansView({Key? key}) : super(key: key);

  @override
  State<TiffinPlansView> createState() => _TiffinPlansViewState();
}

class _TiffinPlansViewState extends State<TiffinPlansView> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: getSimpleAppBar('Tiffin Plan', context),
       body: SingleChildScrollView(
         child: Column(
             mainAxisAlignment: MainAxisAlignment.center,
             crossAxisAlignment: CrossAxisAlignment.stretch,
             children: [
               planCard2(),
               planCard2(),planCard2()
             ]
         ),
       ),
    );
  }




  Widget planCard({String? duration,String?  price, String? mealsPerDay,String? deliveryDays,String? specialOffer}){


    return InkWell(
      onTap: (){
        showDialogBox();
      },
      child: Card(
        margin: EdgeInsets.all(16.0),
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                duration ?? '',
                style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16.0),
              Text('Price: $price'),
              Text('Number of meals per day: $mealsPerDay'),
              Text('Delivery Days: $deliveryDays'),
              Text('Special Offer: $specialOffer'),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  // Add your subscribe logic here
                },
                child: Text('Subscribe Now'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget planCard2(){
    return InkWell(
      onTap: (){

      },
      child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 0.0),
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10)
            ),
            // height: MediaQuery.of(context).size.height / 1.7,
            width: MediaQuery.of(context).size.width/1.0,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                color: colors.primary,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)
                ),
                elevation: 5,
                child: Container(

                  child:  Column(
                    children: [
                      SizedBox(height: 40,),
                      Text(
                        "title",
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25,color: colors.whiteTemp),
                      ),
                      SizedBox(height: 10,),
                      Text(
                        "description",
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18,color: colors.whiteTemp),
                      ),
                      const SizedBox(height: 15,),
                      Container(
                        height: 200,
                        width: 200,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: NetworkImage(
                                    'https://cdn.shopify.com/s/files/1/0618/8593/9769/products/RedBlueSimpleRetroSushiRestaurantQuoteInstagramPost_10.png?v=1677988553'
                                ),
                                fit: BoxFit.fill
                            )
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("₹ 100",style: const TextStyle(color: colors.whiteTemp,fontWeight: FontWeight.bold,fontSize: 32,
                          decorationThickness: 2, height: 2.5,),),
                      ),

                      Text( "5:30",style: const TextStyle(color: colors.whiteTemp, fontSize: 22),),

                      false ? Padding(
                        padding: const EdgeInsets.all(20),
                        child: Container(
                          height: 40,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              gradient:  LinearGradient(
                                begin: Alignment.topRight,
                                end: Alignment.bottomLeft,
                                stops: [0.1, 0.7,],
                                colors: [
                                  colors.primary,
                                  colors.primary

                                ],
                              ),
                              //color: colors.secondary,
                              borderRadius: BorderRadius.circular(30)
                          ),
                          child: const Center(child: Text("Already Subscribed",style: TextStyle(color: colors.whiteTemp,fontWeight: FontWeight.bold,fontSize: 18),)),
                        ),
                      ):
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: InkWell(
                          onTap: (){
                            setState(() {

                            });

                            // Navigator.push(context, MaterialPageRoute(builder: (context)=>
                            //     SubmitFromScreen(planId:getPlans!.data!.first.plans![index].id ,title: getPlans!.data!.first.plans![index].title,
                            //         amount: getPlans!.data!.first.plans![index].amount,days: getPlans!.data!.first.plans![index].timeText,Purchased: getPlans!.data!.first.plans![index].isPurchased )));
                          },
                          child: Container(
                            height: 40,
                            width: MediaQuery.of(context).size.width / 1.5,
                            decoration: BoxDecoration(
                                gradient:  LinearGradient(
                                  begin: Alignment.topRight,
                                  end: Alignment.bottomLeft,
                                  stops: [0.1, 0.7,],
                                  colors: [
                                    colors.whiteTemp,
                                    colors.primary

                                  ],
                                ),
                                //color: colors.secondary,
                                borderRadius: BorderRadius.circular(45)
                            ),
                            child: const Center(child: Text("Subscribe Now",style: TextStyle(color: colors.whiteTemp,fontWeight: FontWeight.bold,fontSize: 18),)),
                          ),
                        ),
                      )

                    ],
                  ),
                ),
              ),


            ),
          )
      ),
    );
  }

  showDialogBox({String? duration,String?  price, String? mealsPerDay,String? deliveryDays,String? specialOffer}) async  {
    await showDialog(context: context, builder:(context) {
      return AlertDialog(actions: [ Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              duration ?? '',
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16.0),
            Text('Price: 200'),
            Text('Number of meals per day: 5'),
            Text('Delivery Days: 7'),
            Text('Special Offer: 20%'),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                // Add your subscribe logic here
              },
              child: Text('Subscribe Now'),
            ),
          ],
        ),
      )],);
    }, );
  }

}


