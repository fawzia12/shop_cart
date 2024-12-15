import 'package:flutter/material.dart';
import 'package:shoplist/model/product.dart';
import 'package:shoplist/screen/create_product.dart';
import 'package:shoplist/screen/product_list_screen.dart';
import 'package:shoplist/screen/update_product_screen.dart';

class Shop extends StatelessWidget {
  const Shop({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      onGenerateRoute: ( RouteSettings settings) {
       late Widget widget;
        if (settings.name=='/') {
         widget=const ProductListScreen();
        }else if(settings.name== CraeteProductListScreen.home){
          widget=const CraeteProductListScreen();
        }else if(settings.name==UpdateProductScreen.home){
          final Products product=settings.arguments as Products;
          widget=UpdateProductScreen(product: product);
        }
        return MaterialPageRoute(builder: (context){
       return widget;
        });
      },
     
    );
  }
}