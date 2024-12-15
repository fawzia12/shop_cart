import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

class CraeteProductListScreen extends StatefulWidget {
  const CraeteProductListScreen({super.key});
  static const String home = '/ create_product ';
  @override
  State<CraeteProductListScreen> createState() =>
      _CraeteProductListScreenState();
}

class _CraeteProductListScreenState extends State<CraeteProductListScreen> {
  final TextEditingController_namecontrol = TextEditingController();
  final TextEditingController_qtycontroler = TextEditingController();
  final TextEditingController_Totalpriecontrol = TextEditingController();
  final TextEditingController_imagecontrol = TextEditingController();
  final TextEditingController_codecontrol = TextEditingController();
  final TextEditingController_unitprice = TextEditingController();
  final GlobalKey<FormState> _fromkey = GlobalKey<FormState>();
  //! circularptogress
  bool _createinpro = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create new product"),
      ),
      body: SafeArea(child: My_Product()),
    );
  }

  Widget My_Product() {
    return Form(
      key: _fromkey,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                controller: TextEditingController_namecontrol,
                decoration: const InputDecoration(label: Text('Product Name')),
                validator: (String? value) {
                  if (value?.trim().isEmpty ?? true) {
                    return 'write here';
                  }
                  return null;
                }),
            TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                keyboardType: TextInputType.number,
                controller: TextEditingController_codecontrol,
                decoration: const InputDecoration(label: Text('Product Code')),
                validator: (String? valu) {
                  if (valu?.trim().isEmpty ?? true) {
                    return 'write here';
                  }
                  return null;
                }),
            TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              keyboardType: TextInputType.number,
              controller: TextEditingController_imagecontrol,
              decoration: const InputDecoration(
                label: Text('Image'),
              ),
              validator: (String? value) {
                if (value?.trim().isEmpty ?? true) {
                  return 'write here';
                }
                return null;
              },
            ),
            TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              keyboardType: TextInputType.number,
              controller: TextEditingController_unitprice,
              decoration: const InputDecoration(
                label: Text('Unit Price'),
              ),
              validator: (String? value) {
                if (value?.trim().isEmpty ?? true) {
                  return 'write here';
                }
                return null;
              },
            ),
              TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              keyboardType: TextInputType.number,
              controller: TextEditingController_Totalpriecontrol,
              decoration: const InputDecoration(
                label: Text('Total Price'),
              ),
              validator: (String? value) {
                if (value?.trim().isEmpty ?? true) {
                  return 'write here';
                }
                return null;
              },
            ),

            TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              keyboardType: TextInputType.number,
              controller: TextEditingController_qtycontroler,
              decoration: const InputDecoration(
                label: Text('Qty'),
              ),
              validator: (String? value) {
                if (value?.trim().isEmpty ?? true) {
                  return 'write here';
                }
                return null;
              },
            ),
           

            Visibility(
              visible: _createinpro==false,
                            child: ElevatedButton(
                  onPressed: () {
                    if (_fromkey.currentState!.validate()) {
                      _createproduct();
                    }
                  },
                  child: const Text('Save'),
                  ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _createproduct() async {
    _createinpro==true;
    
    Uri uri = Uri.parse("https://crud.teamrabbil.com/api/v1/CreateProduct");
    
//! use for in and .text
    Map<String, dynamic> requestBody = {
      "Img": TextEditingController_imagecontrol.text.trim(),
      "ProductCode": TextEditingController_codecontrol.text.trim(),
    "ProductName": TextEditingController_namecontrol.text.trim(),
      "Qty": TextEditingController_qtycontroler.text.trim(),
      "TotalPrice": TextEditingController_Totalpriecontrol.text.trim(),
      "UnitPrice": TextEditingController_unitprice.text.trim(),
    };
    Response response= await post(uri,
    
    headers:{'Content-type': 'application/json' },
      body: jsonEncode(requestBody),
    );
    _createinpro=false;
    if (response.statusCode==200) {
      _clears();
     _custommessage();
      
    }else{
      const Center(child: Text('404 page not found'),);
    }
    //!  _createinpro=false;
    // setState(() {
      
    // });
  }

  void _clears() {
    TextEditingController_namecontrol.clear();
    TextEditingController_qtycontroler.clear();
    TextEditingController_Totalpriecontrol.clear();
    TextEditingController_unitprice.clear();
    TextEditingController_imagecontrol.clear();
    TextEditingController_codecontrol.clear();
  }
  void _disposes() {
    TextEditingController_namecontrol.dispose();
    TextEditingController_qtycontroler.dispose();
    TextEditingController_Totalpriecontrol.dispose();
    TextEditingController_unitprice.dispose();
    TextEditingController_imagecontrol.dispose();
    TextEditingController_codecontrol.dispose();
    super.dispose();
  }
  void _custommessage(){
     ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Container(
          padding: const EdgeInsets.all(5),
          height: 70,
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(4),
            
            
          ),
       
          child: const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("success"),
                Row(
                  
                  children: [
                    Icon(Icons.check,
                    color: Colors.white,
                    
                    ),
                    SizedBox(width: 10,),
                    Text("Thanks for creating project your api\n working well now"),
                  ],
                ),
              ],
            ),
          )
          
        ),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.blue[100]
        ),
        
      );
  }
}
