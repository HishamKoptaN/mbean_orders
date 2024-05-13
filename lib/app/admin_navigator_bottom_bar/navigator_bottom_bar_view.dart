import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import '../../generated/l10n.dart';
import '../drawer/my_drawer.dart';
import '../home/home_controller.dart';
import 'navigator_bottom_bar_cnr.dart';

class NavigateBarScreen extends StatelessWidget {
  const NavigateBarScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Consumer<NavigatorBottomBarCnr>(
            builder: (context, cnr, child) {
              return Text(
                cnr.title,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              );
            },
          ),
        ),
        drawer: const MyDrawer(),
        body: Center(
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.76,
            width: MediaQuery.of(context).size.width * 0.95,
            child: Consumer<NavigatorBottomBarCnr>(
              builder: (context, cnr, child) {
                return cnr.pages[cnr.currentIndex];
              },
            ),
          ),
        ),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: const BorderRadius.all(
              Radius.circular(15),
            ),
          ),
          child: Consumer<NavigatorBottomBarCnr>(
            builder: (context, cnr, child) {
              return SalomonBottomBar(
                curve: Curves.slowMiddle,
                currentIndex: cnr.currentIndex,
                backgroundColor: Colors.white60,
                onTap: (int index) async {
                  cnr.setCurrentIndex(index, context);
                },
                items: [
                  SalomonBottomBarItem(
                    selectedColor: Colors.green,
                    unselectedColor: Colors.grey,
                    icon: ShaderMask(
                      shaderCallback: (Rect bounds) {
                        return const LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.black,
                            Colors.black,
                          ],
                        ).createShader(bounds);
                      },
                      child: Icon(
                        Icons.home,
                        size: MediaQuery.of(context).size.width * 0.13,
                        color: Colors.white,
                      ),
                    ),
                    title: Text(
                      S.of(context).home_title,
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width * 0.04,
                      ),
                    ),
                  ),
                  SalomonBottomBarItem(
                    selectedColor: Colors.green,
                    unselectedColor: Colors.grey,
                    icon: ShaderMask(
                      shaderCallback: (Rect bounds) {
                        return const LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Colors.black, Colors.black],
                        ).createShader(bounds);
                      },
                      child: Icon(
                        Icons.add_circle,
                        size: MediaQuery.of(context).size.width * 0.13,
                        color: Colors.white,
                      ),
                    ),
                    title: Text(
                      S.of(context).add_order,
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width * 0.04,
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
