import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shoplist/model/product.dart';

class UpdateProductScreen extends StatefulWidget {
  const UpdateProductScreen({super.key, required this.product});
  static const String home = '/updateproduct ';
  //!final use here
  final Products product;
  @override
  State<UpdateProductScreen> createState() => _UpdateProductScreenState();
}

class _UpdateProductScreenState extends State<UpdateProductScreen> {
  final TextEditingController_namecontrol = TextEditingController();
  final TextEditingController_qtycontroler = TextEditingController();
  final TextEditingController_Totalpriecontrol = TextEditingController();
  final TextEditingController_imagecontrol = TextEditingController();
  final TextEditingController_codecontrol = TextEditingController();
  final TextEditingController_unitprice = TextEditingController();
  final GlobalKey<FormState> _fromkey = GlobalKey<FormState>();
  bool _updatepro = false;

  @override
  void initState() {
    super.initState();
    TextEditingController_namecontrol.text = widget.product.productname ?? '';
    TextEditingController_qtycontroler.text = widget.product.qty ?? '';
    TextEditingController_Totalpriecontrol.text =
        widget.product.totalPrice ?? '';
    TextEditingController_imagecontrol.text = widget.product.image ?? '';
    TextEditingController_codecontrol.text = widget.product.productcode ?? '';
    TextEditingController_unitprice.text = widget.product.unitprice ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Update product"),
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
                controller: TextEditingController_namecontrol,
                decoration: const InputDecoration(label: Text('Product Name')),
                validator: (String? value) {
                  if (value?.trim().isEmpty ?? true) {
                    return 'write here';
                  }
                  return null;
                }),
            TextFormField(
                controller: TextEditingController_codecontrol,
                decoration: const InputDecoration(label: Text('Product Code')),
                validator: (String? valu) {
                  if (valu?.trim().isEmpty ?? true) {
                    return 'write here';
                  }
                  return null;
                }),
            TextFormField(
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
              visible: _updatepro == false,
              replacement: const Center(
                child: CircularProgressIndicator(),
              ),
              child: ElevatedButton(
                  onPressed: () {
                    if (_fromkey.currentState!.validate()) {
                      _updateproduct();
                    }
                    
                  },
                  child: const Text('Save')),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _updateproduct() async {
    _updatepro = true;
    setState(() {});
    Uri uri = Uri.parse(
        "https://crud.teamrabbil.com/api/v1/UpdateProduct/${widget.product.id}");
    Map<String, dynamic> requestbody = {
      "Img": TextEditingController_imagecontrol.text.trim(),
      "ProductCode": TextEditingController_codecontrol.text.trim(),
      "ProductName": TextEditingController_namecontrol.text.trim(),
      "Qty": TextEditingController_qtycontroler.text.trim(),
      "TotalPrice": TextEditingController_Totalpriecontrol.text.trim(),
      "UnitPrice": TextEditingController_unitprice.text.trim(),
    };

    Response response = await post(uri ,
    headers:{'Content-type': 'application/json' },
    body: jsonEncode(requestbody),
     );
     _updatepro = false;
    setState(() {});
    if (response.statusCode == 200) {
      print("okay");
      _custommessage2();
     
    }
    void clears() {
    TextEditingController_namecontrol.clear();
    TextEditingController_qtycontroler.clear();
    TextEditingController_Totalpriecontrol.clear();
    TextEditingController_unitprice.clear();
    TextEditingController_imagecontrol.clear();
    TextEditingController_codecontrol.clear();
  }
  void disposes() {
    TextEditingController_namecontrol.dispose();
    TextEditingController_qtycontroler.dispose();
    TextEditingController_Totalpriecontrol.dispose();
    TextEditingController_unitprice.dispose();
    TextEditingController_imagecontrol.dispose();
    TextEditingController_codecontrol.dispose();
    super.dispose();
  }
  }

  void _custommessage2() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          content: Container(
              padding: const EdgeInsets.all(5),
              height: 70,
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(4),
              ),
              child: const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("success"),
                    Row(
                      children: [
                        Icon(
                          Icons.check,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text("your product update now\n"),
                      ],
                    ),
                  ],
                ),
              )),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.blue[100]),
    );
  }
}
