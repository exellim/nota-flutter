import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:intl/intl.dart';
import 'package:cupertino_date_textbox/cupertino_date_textbox.dart';
import 'package:image_picker/image_picker.dart';


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

  File? _image;

  String typeitemOri = "";
  String typeitemOri2 = "";
  String typeitemCopy = "";
  String typeitemCopy2 = "";

  DateTime _selectedDateTime = DateTime.now();



  bool _originalVal = false;
  bool _originalSecondVal = false;
  bool _copyVal = false;
  bool _copySecondVal = false;

  TextEditingController _invoiceTEC = TextEditingController();
  TextEditingController _mainPriceTEC = TextEditingController();
  TextEditingController _nameTEC = TextEditingController();
  TextEditingController _discountTEC = TextEditingController();
  TextEditingController _grandtotalTEC = TextEditingController();
  TextEditingController _paymentTEC = TextEditingController();
  TextEditingController _changeTEC = TextEditingController();
  TextEditingController _dcGetTEC = TextEditingController();
  TextEditingController _itemTypeTEC = TextEditingController();

  void grandtot(){
    setState(() {
      num total1 = int.parse(_mainPriceTEC.text);
      num dc = int.parse(_dcGetTEC.text, onError: (source) => -1);
      num total11 = total1;
      num buypay = 0;
      num ppn = 0.03;

      num grandtotal = 0;
      num grandtotal1 = 0;
      num grandtotal2 = 0;
      num grandtotal3 = 0;
      num kembalian = 0;

      num reg = 0;       //_discountTEC
      num prem = 0.02;   //_discountTEC
      num vii = 0.04;    //_discountTEC
      num discount = 0;  //Diskon akhir total

      num sibling = 5000;  //relatif
      num nonsib = 3000;   //relatif
      num relatif = 0;     //relatif total
      num liburan = 0;   //weekend total

      num ori = 200;     //tipe +200
      num ori2 = 100;    //tipe +100
      num copy = 100;    //tipe -100
      num copy2 = 500;   //tipe -500
      num tipebar = 0;   //Tipe total

      if(_mainPriceTEC.text != null || _mainPriceTEC.text != ""){
        //Type Discount
        if (buyerChoose == "Regular"){
            discount = reg;
        }
        else if (buyerChoose == "Premium"){
            discount = prem;
            discount.toDouble();
        }
        else if (buyerChoose == "Vip"){
            discount = vii;
            discount.toDouble();
        }
        //Type Relative
        if (relative == "yes"){
            relatif = -5000;
        }
        else if (relative == "no"){
            relatif = 3000;
        }
        //Tipe liburan
        if (weekend == "yes"){
            liburan = -2500;
        }
        else if (weekend == "yes"){
            liburan = 0;
        }
        // Type Logic
        if (typeitemOri == "Original"){
            tipebar += ori;
        }
        if (typeitemOri2 == "Original Second"){
            tipebar += ori2;
        }
        if (typeitemCopy == "Original Second"){
            tipebar += copy;
        }
        if (typeitemCopy2 == "Original Second"){
            tipebar += copy2;
        }


        grandtotal1 = total11 - (total11*discount);
        grandtotal2 = grandtotal1 + relatif + tipebar;
        grandtotal3 = (grandtotal2*ppn)+grandtotal2;
        dc = total11*discount;



        grandtotal = grandtotal3.toInt();
        _grandtotalTEC.text = grandtotal.toString();
        _dcGetTEC.text = dc.toString();
        _itemTypeTEC.text = relatif.toString();

      }


    });

  }
    
  void kembali(){
    setState(() {
     num pay = int.parse(_paymentTEC.text);
     num gt = int.parse(_grandtotalTEC.text);
     num chngs = 0;

     chngs = pay-gt;

     _changeTEC.text = chngs.toString();

    });
  }

    _imgFromCamera() async {
  File image = await ImagePicker.pickImage(
    source: ImageSource.camera, imageQuality: 80
  );

  setState(() {
    _image = image;
  });
}

_imgFromGallery() async {
  File image = await  ImagePicker.pickImage(
      source: ImageSource.gallery, imageQuality: 80
  );

  setState(() {
    _image = image;
  });
}

  @override
  Widget build(BuildContext context) {
    final String formattedDate = DateFormat.yMd().format(_selectedDateTime);
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

                  // Image
                  Center(
                    child: GestureDetector(
                      onTap: () {
                        _showPicker(context);
                      },
                      child: CircleAvatar(
                        radius: 55,
                        backgroundColor: Color(0xFF6DACFF),
                        child: _image != null
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(50),
                                child: Image.file(
                                  _image!,
                                  width: 100,
                                  height: 100,
                                  fit: BoxFit.fitHeight,
                                ),
                              )
                            : Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(50)),
                                width: 100,
                                height: 100,
                                child: Icon(
                                  Icons.camera_alt,
                                  color: Colors.black,
                                ),
                              ),
                      ),
                    ),
                  ),
                  SizedBox(height: height*0.01,),

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


                   // Birthdate picker
                  SizedBox(height: height*0.03,),
                  Text("Set Buy date:"),
                  SizedBox(height: height*0.01,),
                  CupertinoDateTextBox(
                    enabled: false,
                    initialValue: _selectedDateTime,
                    onDateChange: onBirthdayChange,
                    hintText: DateFormat.yMd().format(_selectedDateTime)
                    ),

                  //Buyer's type 
                  SizedBox(height: height*0.03,),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(width: 1),
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    child: 
                    DropdownButton<String>(
                      isExpanded: true,
                      underline: SizedBox(),
                      hint: Text("Select Class: "),
                      value: buyerChoose,
                      icon: const Icon(Icons.arrow_drop_down_circle_rounded),
                      iconEnabledColor: Colors.blue,
                      iconSize: 24,
                      elevation: 16,
                      style: const TextStyle(
                        color: Colors.blue
                      ),
                      onChanged: (String? newValue) {
                        setState(() {
                          buyerChoose = newValue!;
                          if(newValue == "Regular"){
                            _discounttextTEC = "No Discount";
                          } else if(newValue == "Premium"){
                            _discounttextTEC = "2%";
                          }else if(newValue == "Vip"){
                            _discounttextTEC = "4%";
                          }
                          else{
                            _discounttextTEC = "Please Select Class First!";
                          }
                        });
                      },
                      items: <String>['Regular', 'Premium', 'Vip']
                        .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        })
                        .toList(),
                    )
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
                                    typeitemOri = "Original";
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
                                    typeitemOri2 = "Original Second";
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
                                    typeitemCopy = "Copy";
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
                                    typeitemCopy2 = "Copy Second";
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
                  
                  // Count Button
                  SizedBox(height: height*0.03,),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                    Container(
                      child: ElevatedButton.icon(
                        onPressed: (){
                          grandtot();
                        }, 
                        label: Text("Count The Grand Total"),
                        icon: Icon(
                            Icons.arrow_right_alt_rounded,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                    ),

                ],
                    ),
              ),

                   // Grand Total
                  SizedBox(height: height*0.03,),
                  TextField(
                    enabled: false,
                    decoration: InputDecoration(
                      labelText: _grandtotalTEC.text,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0)
                      )
                    ),
                  ),
                  
                  // Payment
                  SizedBox(height: height*0.03,),
                  TextFormField(
                    controller: _paymentTEC,
                    decoration: InputDecoration(
                      labelText: "Payment",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0)
                      )
                    ),
                  ),

                  // Changes Button
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                    Container(
                      child: ElevatedButton.icon(
                        onPressed: (){
                          kembali();
                        }, 
                        label: Text("Count The Changes Total"),
                        icon: Icon(
                            Icons.arrow_right_alt_rounded,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                     ),
                ],
                    ),
              ),


                  // Change
                  SizedBox(height: height*0.03,),
                  TextField(
                    enabled: false,
                    decoration: InputDecoration(
                      labelText: _changeTEC.text,
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
                            var _dcGet = _dcGetTEC.text;

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
                    Text("$_selectedDateTime", style: TextStyle(fontSize: 15, color:Color(0xFF363f93)),),
                    Text("RESULT: ", style: TextStyle(fontSize: 40, color:Color(0xFF363f93)),),
                    SizedBox(height: height*0.03,),
                    
                    Text("Invoice: "+ _invoiceTEC.text.toUpperCase(), style: TextStyle(fontSize: 15, color:Color(0xFF363f93),),),
                    Text("Name: "+ _nameTEC.text, style: TextStyle(fontSize: 15, color:Color(0xFF363f93)),),
                    Text("Class: "+ buyerChoose.toString(), style: TextStyle(fontSize: 15, color:Color(0xFF363f93)),),
                    Text("Discount Get: "+ buyerChoose.toString(), style: TextStyle(fontSize: 15, color:Color(0xFF363f93)),),
                    Text("Discount Get: Rp."+ _dcGetTEC.text, style: TextStyle(fontSize: 15, color:Color(0xFF363f93)),),
                    Text("Family: "+ relative, style: TextStyle(fontSize: 15, color:Color(0xFF363f93)),),
                    Text("Additional Item Type: "+ _itemTypeTEC.text, style: TextStyle(fontSize: 15, color:Color(0xFF363f93)),),
                    Text("Weekend: "+ weekend, style: TextStyle(fontSize: 15, color:Color(0xFF363f93)),),
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
  void onBirthdayChange(DateTime birthday) {
    setState(() {
      _selectedDateTime = birthday;
    });
  }
  void _showPicker(context) {
  showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return SafeArea(
          child: Container(
            child: new Wrap(
              children: <Widget>[
                new ListTile(
                    leading: new Icon(Icons.photo_library),
                    title: new Text('Photo Library'),
                    onTap: () {
                      _imgFromGallery();
                      Navigator.of(context).pop();
                    }),
                new ListTile(
                  leading: new Icon(Icons.photo_camera),
                  title: new Text('Camera'),
                  onTap: () {
                    _imgFromCamera();
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
        );
      }
    );
}
}