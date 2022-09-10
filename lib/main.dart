import 'package:flutter/material.dart';
import 'package:playground/models/Bottle.dart';
import 'package:playground/widgets/bottle.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(milliseconds: 1200),
    vsync: this,
  );

  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.fastOutSlowIn,
  );

  PageController pageController = PageController();

  List<Bottle> bottles = [
    const Bottle(
      caption: 'Wine Relax: white semi-sweet',
      color: Color(0xffFBF5E9),
      price: '135',
      imageUrl: 'assets/images/bottle1.png',
    ),
    const Bottle(
      caption: 'Wine Relax: pink semi-sweet',
      color: Color(0xffFFCCBD),
      price: '135',
      imageUrl: 'assets/images/bottle2.png',
    ),
    const Bottle(
      caption: 'Wine Relax: red semi-sweet',
      color: Color(0xffB02322),
      price: '135',
      imageUrl: 'assets/images/bottle3.png',
    )
  ];

  int currentIndex = 0;
  late Bottle nextBottle;
  late Bottle currentBottle;

  @override
  void initState() {
    setState(() {
      currentBottle = bottles[currentIndex];
      nextBottle = bottles[currentIndex];
    });

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void onNext() {
    pageController.nextPage(
        duration: const Duration(milliseconds: 1200),
        curve: Curves.fastOutSlowIn);

    setState(() {
      nextBottle = bottles[(currentIndex + 1) % bottles.length];
    });
    _controller.forward().then((_) {
      setState(() {
        currentIndex = (currentIndex + 1) % bottles.length;
        currentBottle = bottles[currentIndex];
      });
      _controller.reset();
    });
  }

  @override
  Widget build(BuildContext context) {
    Color nextButtonColor =
        nextBottle.color.computeLuminance() > 0.5 ? Colors.black : Colors.white;

    return Scaffold(
      backgroundColor: currentBottle.color,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: 60,
                    width: 60,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        ScaleTransition(
                          scale: _animation,
                          child: Transform.scale(
                            scale: 30,
                            child: Container(
                              alignment: Alignment.topLeft,
                              decoration: BoxDecoration(
                                color: nextBottle.color,
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: onNext,
                          child: Container(
                            height: 60,
                            width: 60,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: Icon(
                                Icons.arrow_back,
                                color: nextButtonColor,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: null,
                    icon: Icon(
                      Icons.shopping_bag_outlined,
                      color: nextButtonColor,
                    ),
                  ),
                ],
              ),
              Expanded(
                child: PageView.builder(
                    controller: pageController,
                    itemBuilder: (context, index) {
                      return BottleWidget(
                        bottle: bottles[index % bottles.length],
                      );
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
