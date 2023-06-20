// import 'dart:convert';
//
// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:get/get.dart';
// import 'package:kolazz_book/Models/get_subscription_plans_model.dart';
// import 'package:kolazz_book/Utils/strings.dart';
// import 'package:kolazz_book/Views/dashboard/Dashboard.dart';
// import 'package:razorpay_flutter/razorpay_flutter.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:http/http.dart' as http;
// import '../../Controller/Subscription_Controller.dart';
// import '../../Utils/colors.dart';
//
// class SubscriptionScreen extends StatefulWidget {
//   const SubscriptionScreen({Key? key}) : super(key: key);
//
//   @override
//   State<SubscriptionScreen> createState() => _SubscriptionScreenState();
// }
//
// class _SubscriptionScreenState extends State<SubscriptionScreen> {
//   Razorpay? _razorpay;
//   int? pricerazorpayy;
//   @override
//   void initState() {
//     // TODO: implement initState
//     getSubscriptionPlans();
//     _razorpay = Razorpay();
//     _razorpay?.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
//     _razorpay?.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
//     _razorpay?.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
//   }
//   // List<DataListPlan>  getPlan = [];
//   List<Plans>? getPlans = [];
//
//   getSubscriptionPlans() async {
//     SharedPreferences preferences = await SharedPreferences.getInstance();
//     String? userId = preferences.getString('userId');
//     var headers = {
//       'Cookie': 'ci_session=fd488e599591e4d13d6ae441c1876300c07b77d5'
//     };
//     var request = http.MultipartRequest('POST', Uri.parse(getSubscriptionPlansApi.toString()));
//     // request.fields.addAll({
//     //   'model_id': widget.modelId.toString(),
//     //   'user_id': userId.toString()
//     // });
//     print('_____Surendra_____${request.fields}_________');
//     request.headers.addAll(headers);
//     request.fields.addAll({
//       "user_id": userId.toString()
//     });
//     http.StreamedResponse response = await request.send();
//     if (response.statusCode == 200) {
//       var result = await response.stream.bytesToString();
//       print('_____result_____${result}_________');
//       var finalResult = GetSubscriptionPlansModel.fromJson(json.decode(result));
//       setState(() {
//         getPlans = finalResult.data;
//       });
//       // for(var i=0;i<getPlans!.data!.length;i++){
//       //
//       // }
//     }
//     else {
//       print(response.reasonPhrase);
//     }
//
//   }
//
//   purchasePlan(String transactionId) async {
//     SharedPreferences preferences = await SharedPreferences.getInstance();
//     String? userId = preferences.getString('userId');
//     var headers = {
//       'Cookie': 'ci_session=ea151b5bcdbac5bedcb5f7c9ab074e9316352d04'
//     };
//     var request = http.MultipartRequest('POST', Uri.parse(planPurchaseApi.toString()));
//     request.fields.addAll({
//       'plan_id': planId.toString(),
//       'user_id': '$userId',
//       'transaction_id': transactionId,
//     });
//     print('_____fields_____${request.fields}_________');
//     request.headers.addAll(headers);
//     http.StreamedResponse response = await request.send();
//     if (response.statusCode == 200) {
//       var result =   await response.stream.bytesToString();
//       final finalResult = json.decode(result);
//       Fluttertoast.showToast(msg: finalResult['message']);
//
//       print('____Sdfdfdfdff______${finalResult}_________');
//       setState(() {
//
//       });
//       Navigator.push(context, MaterialPageRoute(builder: (context)=> DashBoard()));
//     }
//     else {
//       print(response.reasonPhrase);
//     }
//   }
//   String planId = '';
//   void openCheckout(amount) async {
//     double res = double.parse(amount.toString());
//     pricerazorpayy= int.parse(res.toStringAsFixed(0)) * 100;
//     print("checking razorpay price ${pricerazorpayy.toString()}");
//
//     print("checking razorpay price ${pricerazorpayy.toString()}");
//     // Navigator.of(context).pop();
//     var options = {
//       'key': 'rzp_test_1DP5mmOlF5G5ag',
//       'amount': "${pricerazorpayy}",
//       'name': 'Dr.Apps',
//       'image':'assets/splash/splashimages.png',
//       'description': 'Dr.Apps',
//     };
//     try {
//       _razorpay?.open(options);
//     } catch (e) {
//       debugPrint('Error: e');
//     }
//   }
//
//   Future<void> _handlePaymentSuccess(PaymentSuccessResponse response) async {
//     Fluttertoast.showToast(msg: "Subscription added successfully");
//     purchasePlan(
//       response.paymentId.toString(),
//     );
//     // getplanPurchaseSuccessApi();
//     // Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
//   }
//   void _handlePaymentError(PaymentFailureResponse response) {
//     Fluttertoast.showToast(msg: "Payment cancelled by user");
//     // setSnackbar("ERROR", context);
//     // setSnackbar("Payment cancelled by user", context);
//   }
//   void _handleExternalWallet(ExternalWalletResponse response) {
//   }
// // bool isPurchased
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.primary,
//       appBar: AppBar(
//         leading:   GestureDetector(
//             onTap: () {
//               Navigator.pop(context);
//             },
//             child: const Icon(Icons.arrow_back_ios,size: 30, color: Color(0xff1E90FF ),)),
//         automaticallyImplyLeading: false,
//         backgroundColor: const Color(0xff303030),
//         actions: const [
//           Padding(
//             padding:  EdgeInsets.all(15),
//             child: Center(child: Text("Subscriptions",
//                 style: TextStyle(fontSize: 16, color:Color(0xff1E90FF), fontWeight: FontWeight.bold)
//             )),
//           ),
//         ],
//       ),
//       body: Column(
//
//         children: [
//           SizedBox(height: 50,),
//           getPlans == null  || getPlans == "" ?
//           Center(child: CircularProgressIndicator()):
//           getPlans!.length == 0 ?
//           Center(child: Text("No Data Found!!")):
//           getPlans!.length == 0 ?
//           Center(
//               child:   Text("No Data Found!!")
//           ) :
//           Container(
//             height: MediaQuery.of(context).size.height/1.5,
//             width: double.infinity,
//             child: CarouselSlider.builder(
//                 options: CarouselOptions(
//                   height: 600
//                 ),
//                 // shrinkWrap: true,
//                 // scrollDirection: Axis.horizontal,
//                 itemCount: getPlans!.length,
//                itemBuilder: ( context, int index, int pageViewIndex){
//
//                   return
//                     InkWell(
//                       onTap: (){
//
//                       },
//                       child: Padding(
//                           padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 0.0),
//                           child: Container(
//                             decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(10)
//                             ),
//                             // height: MediaQuery.of(context).size.height / 1.7,
//                             width: MediaQuery.of(context).size.width/1.0,
//                             child: Padding(
//                               padding: const EdgeInsets.all(8.0),
//                               child: Card(
//                                 color: AppColors.cardclr,
//                                 shape: RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.circular(20)
//                                 ),
//                                 elevation: 5,
//                                 child: Container(
//                                   height: MediaQuery.of(context).size.width/2.0,
//
//                                   child:  Column(
//                                     children: [
//                                       SizedBox(height: 40,),
//                                       Text(
//                                         "${getPlans![index].title}",
//                                         style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25,color: AppColors.whit),
//                                       ),
//                                        SizedBox(height: 10,),
//                                       Text(
//                                         "${getPlans![index].description}",
//                                         style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18,color: AppColors.whit),
//                                       ),
//                                       const SizedBox(height: 15,),
//                                       Container(
//                                         height: 200,
//                                         width: 200,
//                                         decoration: BoxDecoration(
//                                           image: DecorationImage(
//                                             image: NetworkImage(
//                                               getPlans![index].image.toString()
//                                             ),
//                                             fit: BoxFit.fill
//                                           )
//                                         ),
//                                       ),
//
//                                       Padding(
//                                         padding: const EdgeInsets.all(8.0),
//                                         child: Text("₹ ${getPlans![index].price}",style: const TextStyle(color: AppColors.whit,fontWeight: FontWeight.bold,fontSize: 32,
//                                           decorationThickness: 2, height: 2.5,),),
//                                       ),
//
//                                       Text( "${getPlans![index].timeText}",style: const TextStyle(color: AppColors.whit, fontSize: 22),),
//
//                                       getPlans![index].isPurchased == true ? Padding(
//                                         padding: const EdgeInsets.all(20),
//                                         child: Container(
//                                           height: 40,
//                                           width: double.infinity,
//                                           decoration: BoxDecoration(
//                                               gradient: const LinearGradient(
//                                                 begin: Alignment.topRight,
//                                                 end: Alignment.bottomLeft,
//                                                 stops: [0.1, 0.7,],
//                                                 colors: [
//                                                   AppColors.AppbtnColor,
//                                                   AppColors.AppbtnColor
//
//                                                 ],
//                                               ),
//                                               //color: colors.secondary,
//                                               borderRadius: BorderRadius.circular(30)
//                                           ),
//                                           child: const Center(child: Text("Already Subscribed",style: TextStyle(color: AppColors.whit,fontWeight: FontWeight.bold,fontSize: 18),)),
//                                         ),
//                                       ):
//                                       Padding(
//                                         padding: const EdgeInsets.all(20),
//                                         child: InkWell(
//                                           onTap: (){
//                                             setState(() {
//                                               planId = getPlans![index].id.toString();
//                                             });
//                                             openCheckout(getPlans![index].price.toString());
//                                             // Navigator.push(context, MaterialPageRoute(builder: (context)=>
//                                             //     SubmitFromScreen(planId:getPlans!.data!.first.plans![index].id ,title: getPlans!.data!.first.plans![index].title,
//                                             //         amount: getPlans!.data!.first.plans![index].amount,days: getPlans!.data!.first.plans![index].timeText,Purchased: getPlans!.data!.first.plans![index].isPurchased )));
//                                           },
//                                           child: Container(
//                                             height: 40,
//                                             width: MediaQuery.of(context).size.width / 1.5,
//                                             decoration: BoxDecoration(
//                                                 gradient: const LinearGradient(
//                                                   begin: Alignment.topRight,
//                                                   end: Alignment.bottomLeft,
//                                                   stops: [0.1, 0.7,],
//                                                   colors: [
//                                                     AppColors.AppbtnColor,
//                                                     AppColors.AppbtnColor
//                                                   ],
//                                                 ),
//                                                 //color: colors.secondary,
//                                                 borderRadius: BorderRadius.circular(45)
//                                             ),
//                                             child: const Center(child: Text("Subscribe Now",style: TextStyle(color: AppColors.whit,fontWeight: FontWeight.bold,fontSize: 18),)),
//                                           ),
//                                         ),
//                                       )
//
//                                     ],
//                                   ),
//                                 ),
//                               ),
//
//
//                             ),
//                           )
//                       ),
//                     );
//                 }),
//           ),
//         ],
//       ),
//     );
//   }
// }
