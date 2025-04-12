import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'big_app_text.dart';

class PopularMountains extends StatefulWidget {
  const PopularMountains({Key? key}) : super(key: key);

  @override
  State<PopularMountains> createState() => _PopularMountainsState();
}

class _PopularMountainsState extends State<PopularMountains>
    with TickerProviderStateMixin {
  List images = [
    "mountain4.jpeg",
    "mountain8.jpeg",
    "mountain9.jpeg",
  ];
  @override
  Widget build(BuildContext context) {
    TabController tabController = TabController(length: 3, vsync: this);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.only(
                left: 20,
                top: 70,
              ),
              child: Row(
                children: [
                  const Icon(Icons.menu, size: 30, color: Colors.black54),
                  Expanded(child: Container()),
                  Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.grey[500],
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Container(
                padding: const EdgeInsets.only(left: 20),
                child: const BigAppText(text: "Discover", size: 30)),
            const SizedBox(
              height: 30,
            ),
            Container(
                child: Align(
              alignment: Alignment.centerLeft,
              child: TabBar(
                  controller: tabController,
                  labelColor: Colors.black,
                  unselectedLabelColor: Colors.grey,
                  labelPadding: const EdgeInsets.only(left: 20, right: 20),
                  indicator:
                      CircleTabIndicator(color: Colors.black26, radius: 4),
                  isScrollable: true,
                  tabs: const [
                    Text("Places"),
                    Text("ispiration"),
                    Text("emotions"),
                  ]),
            )),
            Container(
              margin: const EdgeInsets.only(left: 20),
              width: double.maxFinite,
              height: 300,
              child: TabBarView(controller: tabController, children: [
                ListView.builder(
                    itemCount: 3,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (_, index) {
                      return Container(
                        height: 300,
                        width: 200,
                        margin: const EdgeInsets.only(right: 10, top: 10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            image: DecorationImage(
                              image: AssetImage("img/" + images[index]),
                              fit: BoxFit.cover,
                            )),
                      );
                    }),
                ListView.builder(
                    itemCount: 3,
                    itemBuilder: (_, index) {
                      return Container(
                        height: 300,
                        width: 200,
                        margin: const EdgeInsets.only(right: 10, top: 10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            image: DecorationImage(
                              image: AssetImage("img/" + images[index]),
                              fit: BoxFit.cover,
                            )),
                      );
                    }),
                ListView.builder(
                    itemCount: 3,
                    itemBuilder: (_, index) {
                      return Container(
                        height: 300,
                        width: 200,
                        margin: const EdgeInsets.only(right: 10, top: 10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            image: DecorationImage(
                              image: AssetImage("img/" + images[index]),
                              fit: BoxFit.cover,
                            )),
                      );
                    })
              ]),
            ),
            const SizedBox(
              height: 30,
            ),
            Container(
                padding: const EdgeInsets.only(left: 20),
                child: const BigAppText(text: "Explore more", size: 20)),
          ],
        ),
      ),
    );
  }
}

class CircleTabIndicator extends Decoration {
  final Color color;
  final double radius;

  const CircleTabIndicator({required this.color, required this.radius});

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return _CirclePainter(color: color, radius: radius);
  }
}

class _CirclePainter extends BoxPainter {
  final double radius;
  late Color color;
  _CirclePainter({required this.color, required this.radius});

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration cfg) {
    late Paint paint;
    paint = Paint()..color = color;
    paint = paint..isAntiAlias = true;
    final Offset circleOffset =
        offset + Offset(cfg.size!.width / 2, cfg.size!.height - radius);
    canvas.drawCircle(circleOffset, radius, paint);
  }
}
