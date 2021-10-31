// import 'dart:io';
// import 'dart:ui';
// import 'package:flutter/material.dart';

// void main(){
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget{
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: nota(),
//     );
//   }
// }

// class nota extends StatefulWidget {
//   nota({Key? key}) : super(key: key);

//   @override
//   _notaState createState() => _notaState();
// }

// class _notaState extends State<nota> {
//   final formKey = GlobalKey<FormState>(); //key for form
//   String? buyerChoose;
//   List listBuyer = [
//     "Regular","Premium","Vip"
//   ];
//   String _discounttextTEC = "";


//   TextEditingController _invoiceTEC = TextEditingController();
//   TextEditingController _nameTEC = TextEditingController();
//   TextEditingController _buyerTEC = TextEditingController();
//   TextEditingController _discountTEC = TextEditingController();
  
//   void onChanged(String buyerChoose){
//     setState(() {
//       num disc = 0;
//       num? finn;
      
//       if(buyerChoose == "Regular"){
//         disc = 0;
//         finn = disc;
//       } else if(buyerChoose == "Premium"){
//         disc = 0.02;
//         finn = disc;
//       } else if(buyerChoose == "Vip"){
//         disc = 0.04;
//         finn = disc;
//       }

//       _discountTEC.text = finn.toString();

//     });

//   }

//   @override
//   Widget build(BuildContext context) {
//     final double height= MediaQuery.of(context).size.height;
//     final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
//     return Scaffold(
//       key: _scaffoldKey,
//         appBar: AppBar(
//           backgroundColor: Colors.transparent,
//           elevation: 0,
//         ),
//          backgroundColor: Color(0xFFffffff),
//         body: SingleChildScrollView(
//           scrollDirection: Axis.vertical,
//           child: Container(
//             padding: const EdgeInsets.only(left: 40, right: 40),
//             child: Form(
//               key: formKey,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   SizedBox(height:height*0.01),
//                   Text("Welcome", style: TextStyle(fontSize: 30, color:Color(0xFF363f93)),),
//                   Text("Please Fill this form!", style: TextStyle(fontSize: 30, color:Color(0xFF363f93)),),
//                   SizedBox(height: height*0.05,),
//                   // Nota
//                   TextFormField(
//                     controller: _invoiceTEC,
//                     textCapitalization: TextCapitalization.characters,
//                     decoration: InputDecoration(
//                       labelText: "Invoice",
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(25.0)
//                       )
//                     ),
//                     validator: (value){
//                       // Check if value is empty or not
//                       // RegExp used to check if input from start to end only has letter
//                       if(value!.isEmpty || !RegExp(r'^[A-Za-z0-9_.]+$').hasMatch(value!)){
//                         return "Enter Correct Invoice input!";
//                       }else{
//                         return null;
//                       }
//                     },
//                   ),
//                   // Name
//                   SizedBox(height: height*0.03,),
//                   TextFormField(
//                     controller: _nameTEC,
//                     decoration: InputDecoration(
//                       labelText: "Name",
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(25.0)
//                       )
//                     ),
//                     validator: (value){
//                       // Check if value is empty or not
//                       // RegExp used to check if input from start to end only has letter
//                       if(value!.isEmpty || !RegExp(r'^[a-z A-Z]+$').hasMatch(value!)){
//                         return "Enter Correct Name input!";
//                       }else{
//                         return null;
//                       }
//                     },
//                   ),

//                   //Buyer's type 
//                   SizedBox(height: height*0.03,),
//                   Container(
//                     decoration: BoxDecoration(
//                       border: Border.all(width: 1),
//                       borderRadius: BorderRadius.circular(25.0),
//                     ),
//                     child: DropdownButton(
//                       isExpanded: true,
//                       underline: SizedBox(),
//                       hint: Text("Select Class: "),
//                       value: buyerChoose,
//                       onChanged: (newValue) {
//                         setState(() {
//                           buyerChoose = newValue as String?;
//                           if(buyerChoose == "Regular"){
//                             _discounttextTEC = "No Discount";
//                           } else if(buyerChoose == "Premium"){
//                             _discounttextTEC = "2%";
//                           }else if(buyerChoose == "Vip"){
//                             _discounttextTEC = "4%";
//                           }
//                         });
//                       },
//                       items: listBuyer.map((valueItem) {
//                         return DropdownMenuItem(
//                           value: valueItem,
//                           child: Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: Text(valueItem),
//                           ),
//                         );
//                       }).toList(),
//                       ),
//                   ),
                  
//                   // Discount
//                   SizedBox(height: height*0.03,),
//                   TextField(
//                     controller: _discountTEC,
//                     enabled: false,
//                     decoration: InputDecoration(
//                       labelText: _discounttextTEC,
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(25.0)
//                       )
//                     ),
//                   ),

//                   // Submit Button
//                   SizedBox(height: height*0.03,),
//                   Align(
//                     alignment: Alignment.bottomRight,
//                     child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.end,
//                         children: <Widget>[
//                     Ink(
//                       decoration: const ShapeDecoration(
//                         color: Colors.lightBlue,
//                         shape: CircleBorder(),
//                       ),
//                       child: IconButton(
//                         onPressed: () {
//                           //  You enter here what you want the button to do once the user interacts with it
//                           if(formKey.currentState!.validate()){
//                             var _invoice = _invoiceTEC.text;
//                             var _name = _nameTEC.text;

//                             print("Invoice: " + _invoice);
//                             print("Name: " + _name);
//                             print("Class: " + buyerChoose.toString());
//                             // final snackBar = SnackBar(content: Text('Form has been submitted'));
//                             // _scaffoldKey.currentState!.showSnackBar(snackBar);
//                           }
//                         },
//                         icon: Icon(
//                           Icons.arrow_right_alt_rounded,
//                           color: Colors.white,
//                         ),
//                         iconSize: 20.0,
//                       ),
//                     ),

//                 ],
//                     ),
//               ),
//               SizedBox(height: height*0.04,),
//               Container(
//                 constraints: BoxConstraints(minWidth: double.infinity, maxWidth: double.infinity),
//                 decoration: BoxDecoration(
//                   border: Border.all(),
//                   borderRadius: BorderRadius.circular(8.0),
//                 ),
//                 child:
//                 Expanded(
//                   child: Column(
//                     mainAxisAlignment:MainAxisAlignment.end,
//                     children: [
//                     SizedBox(height: height*0.03,),
//                     Text("RESULT: ", style: TextStyle(fontSize: 40, color:Color(0xFF363f93)),),
//                     SizedBox(height: height*0.03,),
                    
//                     Text("Invoice: "+ _invoiceTEC.text, style: TextStyle(fontSize: 15, color:Color(0xFF363f93),),),
//                     Text("Name: "+ _nameTEC.text, style: TextStyle(fontSize: 15, color:Color(0xFF363f93)),),
//                     Text("Class: "+ buyerChoose.toString(), style: TextStyle(fontSize: 15, color:Color(0xFF363f93)),),
//                     Text("Discount Get: "+ buyerChoose.toString(), style: TextStyle(fontSize: 15, color:Color(0xFF363f93)),),
//                     SizedBox(height: height*0.03,),

//                     ],
//                   ),
//                 ) ,
//               ),
//                 SizedBox(height: height*0.03,),
                  
//                 ],
//               ),
//           ),
//         ),
//     )
//     );
//   }
// }

import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: nota(),
    );
  }
}

class nota extends StatefulWidget {
  nota({Key? key}) : super(key: key);

  @override
  _notaState createState() => _notaState();
}


class _notaState extends State<nota> {
  final formKey = GlobalKey<FormState>(); //key for form
  String? buyerChoose;
  List listBuyer = [
    "Regular","Premium","Vip"
  ];
  String _discounttextTEC = "Please select class first";
  String _PPNTEC = "TAX";

  String weekend="";
  String relative="";


  bool _originalVal = false;
  bool _originalSecondVal = false;
  bool _copyVal = false;
  bool _copySecondVal = false;

  TextEditingController _invoiceTEC = TextEditingController();
  TextEditingController _mainPriceTEC = TextEditingController();
  TextEditingController _nameTEC = TextEditingController();
  TextEditingController _buyerTEC = TextEditingController();
  TextEditingController _discountTEC = TextEditingController();

    


  @override
  Widget build(BuildContext context) {
    final double height= MediaQuery.of(context).size.height;
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    return Scaffold(
      key: _scaffoldKey,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
         backgroundColor: Color(0xFFffffff),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            padding: const EdgeInsets.only(left: 40, right: 40),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height:height*0.01),
                  Text("Welcome", style: TextStyle(fontSize: 30, color:Color(0xFF363f93)),),
                  Text("Please Fill this form!", style: TextStyle(fontSize: 30, color:Color(0xFF363f93)),),
                  SizedBox(height: height*0.05,),
                  // Nota
                  TextFormField(
                    controller: _invoiceTEC,
                    textCapitalization: TextCapitalization.characters,
                    decoration: InputDecoration(
                      labelText: "Invoice",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0)
                      )
                    ),
                    validator: (value){
                      // Check if value is empty or not
                      // RegExp used to check if input from start to end only has letter
                      if(value!.isEmpty || !RegExp(r'^[A-Za-z0-9_.]+$').hasMatch(value!)){
                        return "Enter Correct Invoice input!";
                      }else{
                        return null;
                      }
                    },
                  ),
                  // Name
                  SizedBox(height: height*0.03,),
                  TextFormField(
                    controller: _nameTEC,
                    decoration: InputDecoration(
                      labelText: "Name",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0)
                      )
                    ),
                    validator: (value){
                      // Check if value is empty or not
                      // RegExp used to check if input from start to end only has letter
                      if(value!.isEmpty || !RegExp(r'^[a-z A-Z]+$').hasMatch(value!)){
                        return "Enter Correct Name input!";
                      }else{
                        return null;
                      }
                    },
                  ),

                  //Buyer's type 
                  SizedBox(height: height*0.03,),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(width: 1),
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    child: DropdownButton(
                      isExpanded: true,
                      underline: SizedBox(),
                      hint: Text("Select Class: "),
                      value: buyerChoose,
                      onChanged: (newValue) {
                        setState(() {
                          buyerChoose = newValue as String?;
                          if(buyerChoose == "Regular"){
                            _discounttextTEC = "No Discount";
                          } else if(buyerChoose == "Premium"){
                            _discounttextTEC = "2%";
                          }else if(buyerChoose == "Vip"){
                            _discounttextTEC = "4%";
                          }
                          else{
                            _discounttextTEC = "Please Select Class First!";
                          }
                        });
                      },
                      items: listBuyer.map((valueItem) {
                        return DropdownMenuItem(
                          value: valueItem,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(valueItem),
                          ),
                        );
                      }).toList(),
                      ),
                  ),
                  
                  // Discount
                  SizedBox(height: height*0.03,),
                  TextField(
                    enabled: false,
                    decoration: InputDecoration(
                      labelText: _discounttextTEC,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0)
                      )
                    ),
                  ),

                  // Main Price
                  SizedBox(height: height*0.03,),
                  TextFormField(
                    controller: _mainPriceTEC,
                    decoration: InputDecoration(
                      labelText: "Enter the main price: ",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0)
                      )
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
                    validator: (value){
                      // Check if value is empty or not
                      // RegExp used to check if input from start to end only has letter
                      if(value!.isEmpty || !RegExp(r'^[0-9]+$').hasMatch(value!)){
                        return "Enter Correct Price input!";
                      }else{
                        return null;
                      }
                    },
                    onFieldSubmitted:(newValue){
                      setState(() {
                      _mainPriceTEC.text = newValue as String;
                      if (_mainPriceTEC.text != "") {
                        _PPNTEC = '3%';                        
                      }
                      else{
                       return null;                        
                      }    
                      });
                    },
                  ),

                  // PPN
                  SizedBox(height: height*0.03,),
                  TextField(
                    enabled: false,
                    decoration: InputDecoration(
                      labelText: _PPNTEC,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0)
                      )
                    ),
                  ),

                  // Weekend
                  SizedBox(height: height*0.03,),
                  Text("Weekend", style: TextStyle(fontSize: 15, color:Color(0xFF363f93)),),
                  Row(
                    children: <Widget>[
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Row(
                          children: <Widget>[
                            Row(
                              children: [
                                Radio(
                                  value: 'yes', 
                                  groupValue: weekend, 
                                  onChanged: (val){
                                    weekend = val.toString();
                                    setState(() {     
                                    });
                                  },
                                  ),
                                  Text("Yes"),
                              ],
                            ),
                            Row(
                              children: [
                                Radio(
                                  value: 'no', 
                                  groupValue: weekend, 
                                  onChanged: (val){
                                    weekend = val.toString();
                                    setState(() {        
                                    });
                                  },
                                  ),
                                  Text("No"),
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  ),

                  // Relatives
                  SizedBox(height: height*0.03,),
                  Text("Relative", style: TextStyle(fontSize: 15, color:Color(0xFF363f93)),),
                  Row(
                    children: <Widget>[
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Row(
                          children: <Widget>[
                            Row(
                              children: [
                                Radio(
                                  value: 'yes', 
                                  groupValue: relative, 
                                  onChanged: (val){
                                    relative = val.toString();
                                    setState(() {     
                                    });
                                  },
                                  ),
                                  Text("Yes"),
                              ],
                            ),
                            Row(
                              children: [
                                Radio(
                                  value: 'no', 
                                  groupValue: relative, 
                                  onChanged: (val){
                                    relative = val.toString();
                                    setState(() {        
                                    });
                                  },
                                  ),
                                  Text("No"),
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  ),

                  // Item Type
                  SizedBox(height: height*0.03,),
                  Text("Item Type: ", style: TextStyle(fontSize: 25, color:Color(0xFF363f93)),),
                  Center(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Checkbox(
                                value: _originalVal, 
                                onChanged: (bool? value){
                                  setState(() {
                                    _originalVal = value!;
                                    print(_originalVal);
                                  });
                                }
                                )
                              ),
                              Expanded(child: Text("Original")),

                              Expanded(
                              child: Checkbox(
                                value: _originalSecondVal, 
                                onChanged: (bool? value){
                                  setState(() {
                                    _originalSecondVal = value!;
                                    print(_originalSecondVal);
                                  });
                                }
                                )
                              ),
                              Expanded(child: Text("Original Second")),
                          ],
                        ),

                        Row(
                          children: [
                            Expanded(
                              child: Checkbox(
                                value: _copyVal, 
                                onChanged: (bool? value){
                                  setState(() {
                                    _copyVal = value!;
                                    print(_copyVal);
                                  });
                                }
                                )
                              ),
                              Expanded(child: Text("Copy")),

                              Expanded(
                              child: Checkbox(
                                value: _copySecondVal, 
                                onChanged: (bool? value){
                                  setState(() {
                                    _copySecondVal = value!;
                                    print(_copySecondVal);
                                  });
                                }
                                )
                              ),
                              Expanded(child: Text("Copy Second")),
                          ],
                        ),
                      ],
                    ),
                  ),
                  
                   // Grand Total
                  SizedBox(height: height*0.03,),
                  TextField(
                    enabled: false,
                    decoration: InputDecoration(
                      labelText: null,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0)
                      )
                    ),
                  ),


                  // Submit Button
                  SizedBox(height: height*0.03,),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                    Ink(
                      decoration: const ShapeDecoration(
                        color: Colors.lightBlue,
                        shape: CircleBorder(),
                      ),
                      child: IconButton(
                        onPressed: () {
                          //  You enter here what you want the button to do once the user interacts with it
                          if(formKey.currentState!.validate()){
                            var _invoice = _invoiceTEC.text;
                            var _name = _nameTEC.text;
                            var _classB = buyerChoose.toString();

                            print("Invoice: " + _invoice);
                            print("Name: " + _name);
                            print("Class: " + _classB);
                            final snackBar = SnackBar(content: Text('Check the Result box!'));
                            _scaffoldKey.currentState!.showSnackBar(snackBar);
                          }
                        },
                        icon: Icon(
                          Icons.arrow_right_alt_rounded,
                          color: Colors.white,
                        ),
                        iconSize: 20.0,
                      ),
                    ),

                ],
                    ),
              ),
              SizedBox(height: height*0.04,),
              Container(
                constraints: BoxConstraints(minWidth: double.infinity, maxWidth: double.infinity),
                decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child:
                Expanded(
                  child: Column(
                    mainAxisAlignment:MainAxisAlignment.end,
                    children: [
                    SizedBox(height: height*0.03,),
                    Text("RESULT: ", style: TextStyle(fontSize: 40, color:Color(0xFF363f93)),),
                    SizedBox(height: height*0.03,),
                    
                    Text("Invoice: "+ _invoiceTEC.text, style: TextStyle(fontSize: 15, color:Color(0xFF363f93),),),
                    Text("Name: "+ _nameTEC.text, style: TextStyle(fontSize: 15, color:Color(0xFF363f93)),),
                    Text("Class: "+ buyerChoose.toString(), style: TextStyle(fontSize: 15, color:Color(0xFF363f93)),),
                    Text("Discount Get: "+ buyerChoose.toString(), style: TextStyle(fontSize: 15, color:Color(0xFF363f93)),),
                    SizedBox(height: height*0.03,),

                    ],
                  ),
                ) ,
              ),
                SizedBox(height: height*0.03,),
                  
                ],
              ),
          ),
        ),
    )
    );
  }
}