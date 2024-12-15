import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shoplist/model/product.dart';
import 'package:shoplist/screen/create_product.dart';
import 'package:shoplist/widget/product_item.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  @override
  List<Products> productlist = [];
bool _getinpro=false;
  @override
  void initState() {
    _getproductlist();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Item list"),
        actions: [
         IconButton(onPressed: (){
          _getproductlist();
         }, icon: const Icon(Icons.refresh)),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async{
          _getproductlist();
        },
        child: Visibility(
          visible: _getinpro==false,
          replacement: const Center(
            child: CircularProgressIndicator(),
          ),
          child: ListView.separated(
            padding: const EdgeInsets.all(10),
            scrollDirection:Axis.vertical ,
             itemCount: productlist.length,
             separatorBuilder: (BuildContext context, int index) => const Divider(),
              itemBuilder: (context, index) {
                return  ProductItem(product:productlist[index] );
              }),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, CraeteProductListScreen.home);
        },
        focusColor: Colors.blue,
        backgroundColor: const Color.fromARGB(255, 126, 163, 192),
        child: const Text("Create"),
      ),
    );
  }

  void _getproductlist() async {
    
    _getinpro=true;
    productlist.clear();
    setState(() {
      
    });
    Uri uri = Uri.parse('https://crud.teamrabbil.com/api/v1/ReadProduct');
    Response response = await get(uri);
    if (response.statusCode == 200) {
      final decodedata = jsonDecode(response.body);
      for (Map<String, dynamic> a in decodedata["data"]) {
        Products product = Products(
          id: a["_id"],
          productname: a["ProductName"],
          productcode: a["ProductCode"],
          unitprice: a["UnitPrice"],
          image: a["Img"],
          qty: a["Qty"],
          totalPrice: a["TotalPrice"],
          createdDate: a["CreatedDate"],
        );
        productlist.add(product);
       
        setState(() {});
      }
     
    }
    _getinpro=false;
    setState(() {
      
    });
  }
}
