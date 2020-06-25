import 'package:bakas/helper/custom_route.dart';
import 'package:bakas/model/cart_provider.dart';
import 'package:bakas/model/orders.dart';
import 'package:bakas/model/products.dart';
import 'package:bakas/provider/auth_provider.dart';
import 'package:bakas/screen/auth_screen.dart';
import 'package:bakas/screen/cart_screen.dart';
import 'package:bakas/screen/edit_product_screen.dart';
import 'package:bakas/screen/order_screen.dart';
import 'package:bakas/screen/product_detail.dart';
import 'package:bakas/screen/product_overview_screen.dart';
import 'package:bakas/screen/user_product_screen.dart';
import 'package:flare_splash_screen/flare_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(SplashClass());

class SplashClass extends StatelessWidget {
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => Auth()),
          ChangeNotifierProxyProvider<Auth, Products>(
            update:
                (BuildContext context, Auth auth, Products previousProducts) {
              return Products(auth.token, auth.userId,
                  previousProducts == null ? [] : previousProducts.items);
            },
          ),
          ChangeNotifierProvider(create: (_) => Cart()),
          ChangeNotifierProxyProvider<Auth, Orders>(
            update: (BuildContext context, Auth auth, Orders previousOrders) {
              return Orders(auth.token, auth.userId,
                  previousOrders == null ? [] : previousOrders.orders);
            },
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Shop Venue',
          theme: ThemeData(
              primaryColor: Colors.blueGrey,
              accentColor: Colors.red,
              fontFamily: "Lato",
              pageTransitionsTheme: PageTransitionsTheme(builders: {
                TargetPlatform.android: CustomPageTranisitionBuilder(),
                TargetPlatform.iOS: CustomPageTranisitionBuilder(),
              })),
          home: SplashBetween(),
          routes: {
            ProductDetail.routeName: (ctx) => ProductDetail(),
            CartScreen.routeName: (ctx) => CartScreen(),
            OrderScreen.routeName: (ctx) => OrderScreen(),
            UserProductScreen.routeName: (ctx) => UserProductScreen(),
            EditProductScreen.routeName: (ctx) => EditProductScreen(),
            AuthScreen.routeName: (ctx) => AuthScreen(),
            ProductOverviewScreen.routeName: (ctx) => ProductOverviewScreen(),
          },
        ));
  }
}

class SplashBetween extends StatefulWidget {
  @override
  _SplashBetweenState createState() => _SplashBetweenState();
}

class _SplashBetweenState extends State<SplashBetween> {
  bool isInit = true;
  bool isLogin = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (isInit) {
      checkLogin();
    }
    isInit = false;
  }

  void checkLogin() async {
    isLogin = await Provider.of<Auth>(context).tryAutoLogin();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SplashScreen.navigate(
      name: "assets/images/splash.flr",
      fit: BoxFit.cover,
      backgroundColor: Colors.blueGrey,
      transitionsBuilder: (ctx, animation, second, child) {
        var begin = Offset(1.0, 0.0);
        var end = Offset.zero;
        var tween = Tween(begin: begin, end: end)
            .chain(CurveTween(curve: Curves.easeIn));
        var offsetAnimation = animation.drive(tween);

        return SlideTransition(
          position: offsetAnimation,
          child: child,
        );
      },
      startAnimation: "Untitled",
      loopAnimation: "Untitled",
      until: () => Future.delayed(Duration(seconds: 3)),
      alignment: Alignment.center,
      next: (_) => isLogin ? ProductOverviewScreen() : AuthScreen(),
    ));
  }
}
