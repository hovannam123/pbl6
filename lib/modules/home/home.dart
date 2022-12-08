import 'package:badges/badges.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pbl6/config/app_text_style.dart';
import 'package:pbl6/modules/home/components/category_bar.dart';
import 'package:pbl6/modules/home/components/search_bar.dart';
import 'package:pbl6/modules/profile/profile.dart';
import '../cart/cart_shopping.dart';
import 'components/item_pages.dart';

class Home extends StatefulWidget {
  const Home({
    Key? key,
  }) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;

  final tabs = [
    Column(
      children: [
        SizedBox(
          height: 10,
        ),
        Container(
          child: Column(
            children: const [
              SizedBox(
                height: 10,
              ),
              CategoryBar(),
              SearchBar(),
            ],
          ),
        ),
        Expanded(child: ItemPages())
      ],
    ),
    Container(
      child: Center(
        child: Text('cua hang'),
      ),
    ),
    Container(
      child: Center(
        child: Text('ho tro'),
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'COMPUTER STORE',
            style: AppTextStyle.heading4Light,
          ),
          titleSpacing: 6,
          leading: IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {},
          ),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Profile()));
                },
                icon: Icon(Icons.person_outline)),
            IconButton(onPressed: () {}, icon: Icon(Icons.notifications)),
            Badge(
              badgeColor: Colors.white,
              badgeContent: Text('3'),
              position: BadgePosition.topEnd(),
              child: IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const CartShopping()));
                },
                icon: const Icon(Icons.shopping_cart),
              ),
            ),
            SizedBox(
              width: 10,
            )
          ],
          backgroundColor: Colors.lightBlue,
          elevation: 20,
        ),
        body: Container(
          child: tabs[_selectedIndex],
        ),
        bottomNavigationBar: BottomNavigationBar(
          iconSize: 25,
          backgroundColor: Colors.lightBlue,
          selectedLabelStyle: AppTextStyle.heading3Light,
          unselectedLabelStyle:
              const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          unselectedItemColor: Colors.white,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.production_quantity_limits),
              label: 'Sản phẩm',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shop),
              label: 'Cửa hàng',
            ),
            BottomNavigationBarItem(icon: Icon(Icons.support), label: 'Hỗ trợ'),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.black,
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
        ),
      ),
    );
  }
}
