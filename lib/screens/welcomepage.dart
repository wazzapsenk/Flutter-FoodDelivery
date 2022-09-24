import 'package:deliveryfood/constants/constants.dart';
import 'package:deliveryfood/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';




class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage>
    with TickerProviderStateMixin {
  late final AnimationController _controller =
      AnimationController(vsync: this, duration: Duration(seconds: 3))
        ..repeat(reverse: true);

  late final Animation<double> _animation =
      CurvedAnimation(parent: _controller, curve: Curves.elasticOut);

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  //Hide navigation bar
  @override
  void initState() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Positioned(
              right: 100,
              child: Container(
                child: Image.asset(
                  "assets/images/logo.png",
                  height: 80,
                ),
              ),
            ),
            SizedBox(
              height: kDefaultPadding,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomAppTitle(
                  title: "foo",
                  color: kTextColorWhite,
                ),
                RotationTransition(
                  turns: _animation,
                  child: CustomAppTitle(
                    title: "D",
                    color: kTextColorDark,
                  ),
                ),
                CustomAppTitle(
                  title: "elivery",
                  color: kTextColorWhite,
                ),
              ],
            ),

            SizedBox(
              height: 110,
            ),

            //Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginPage()));
            Row(mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>RegisterPage()));
                }, child: Text("Üye Ol",style: TextStyle(color: kTextColorWhite),)),
                TextButton(onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginPage()));
                }, child: Text("Giriş Yap",style: TextStyle(color: kTextColorWhite),)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class CustomAppTitle extends StatelessWidget {
  final String title;
  final Color color;

  const CustomAppTitle({Key? key, required this.title, required this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: Theme.of(context).textTheme.subtitle2!.copyWith(
        color: color,
        fontSize: 28,
        letterSpacing: 4,
        shadows: [
          const BoxShadow(color: kTextColorDark, blurRadius: 9),
        ],
      ),
    );
  }
}
