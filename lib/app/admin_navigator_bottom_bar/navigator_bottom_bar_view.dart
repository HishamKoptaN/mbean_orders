import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import '../../generated/l10n.dart';
import '../drawer/my_drawer.dart';
import '../global_methods/global_methods.dart';
import '../home/home_controller.dart';
import 'navigator_bottom_bar_cnr.dart';

class NavigateBarScreen extends StatelessWidget {
  const NavigateBarScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final homeController = Provider.of<HomeProvider>(context, listen: false);
    homeController.getCurrentUser();
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
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
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
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
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
                  backgroundColor: const Color.fromARGB(0, 255, 255, 255),
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
                        child: const Icon(
                          Icons.home,
                          size: 40,
                          color: Colors.white,
                        ),
                      ),
                      title: Text(
                        S.of(context).home_title,
                        style: TextStyle(
                          fontSize: setFont(context, 12),
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
                        child: const Icon(
                          Icons.add_circle,
                          size: 40,
                          color: Colors.white,
                        ),
                      ),
                      title: Text(
                        S.of(context).add_order,
                        style: TextStyle(
                          fontSize: setFont(context, 12),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
