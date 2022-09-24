import 'package:deliveryfood/constants/constants.dart';
import 'package:deliveryfood/screens/homepage.dart';
import 'package:deliveryfood/services/services.dart';
import 'package:deliveryfood/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(body:
        _buildBody());
  }

  Widget _buildBody() {
    return Center(
      child: Padding(padding: const EdgeInsets.symmetric(horizontal: 10.0), child: _buildBodyContainer()),
    );
  }

  Widget _buildBodyContainer() {
    var size = MediaQuery.of(context).size;
    return Container(
      height: size.height * .5,
      width: size.width * .85,
      decoration: BoxDecoration(
          color: kPrimaryColor,
          borderRadius: BorderRadius.all(Radius.circular(20)),
          boxShadow: [BoxShadow(color: kPrimaryColor, blurRadius: 10, spreadRadius: 2)]),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Center(
          child: Column(

            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              _buildTextFieldColumns(size),
              SizedBox(
                height: size.height * 0.08,
              ),
              _buildButtonsColumn(size),
              _buildRegisterTextBody()
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextFieldColumns(dynamic size) {
    return Column(
      children: [
        _buildEmailTextField(),
        _buildSpace(size),
        _buildPasswordTextField(),
      ],
    );
  }

  Widget _buildEmailTextField() {
    return TextField(
        controller: _emailController,
        style: TextStyle(
          color: Colors.white,
        ),
        cursorColor: Colors.white,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.mail,
            color: Colors.white,
          ),
          hintText: 'E-Mail',
          prefixText: ' ',
          hintStyle: TextStyle(color: Colors.white),
          focusColor: Colors.white,
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: Colors.white,
              )),
          enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: Colors.white,
              )),
        ));
  }

  Widget _buildPasswordTextField() {
    return TextField(
        style: TextStyle(
          color: Colors.white,
        ),
        cursorColor: Colors.white,
        controller: _passwordController,
        obscureText: true,
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.vpn_key,
            color: Colors.white,
          ),
          hintText: 'Parola',
          prefixText: ' ',
          hintStyle: TextStyle(
            color: Colors.white,
          ),
          focusColor: Colors.white,
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: Colors.white,
              )),
          enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: Colors.white,
              )),
        ));
  }

  Widget _buildButtonsColumn(dynamic size) {
    return Column(
      children: [
        _buildLoginButton(),
        _buildSpace(size),
        _buildLoginWithOtherButton(
            'Google ile giriş', FontAwesomeIcons.google, Colors.red, _loginWithGoogleButtonFunction),
        _buildSpace(size),

      ],
    );
  }

  Widget _buildLoginButton() {
    return InkWell(onTap: () => _loginFunction(), child: _buildLoginButtonContainer());
  }

  Widget _buildLoginButtonContainer() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.white, width: 2), borderRadius: BorderRadius.all(Radius.circular(30))),
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Center(child: _buildLoginButtonText()),
      ),
    );
  }

  Widget _buildLoginButtonText() {
    return Text(
      "Giriş yap",
      style: TextStyle(
        color: Colors.white,
        fontSize: 20,
      ),
    );
  }

  void _loginFunction() {
    _authService.signIn(_emailController.text, _passwordController.text).then((value) {
      return Navigator.push(context, MaterialPageRoute(builder: (context) => FoodsPage()));
    }).catchError((dynamic error) {
      if (error.code.contains('invalid-email')) {
        _buildErrorMessage("Mail adresi geçersizdir");
      }
      if (error.code.contains('user-not-found')) {
        _buildErrorMessage("Kullanıcı bulunamadı");
      }
      if (error.code.contains('wrong-password')) {
        _buildErrorMessage("Parola yanlıştır");
      }

      //  _buildErrorMessage(error.message);

      print(error.message);
    });
  }

  void _buildErrorMessage(String text) {
    Fluttertoast.showToast(
        msg: text,
        timeInSecForIosWeb: 2,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.grey[600],
        textColor: Colors.white,
        fontSize: 14);
  }

  Widget _buildLoginWithOtherButton(String text, dynamic icon, dynamic color, Function function) {
    return InkWell(
      onTap: () => function(),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 5),
        decoration: BoxDecoration(
            border: Border.all(color: color, width: 2),
            color: color,
            borderRadius: BorderRadius.all(Radius.circular(30))),
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Center(child: _buildLoginWithGoogleButtonRow(text, icon)),
        ),
      ),
    );
  }

  void _loginWithGoogleButtonFunction() async {
    return _authService.signInWithGoogle().then((value) {
      return Navigator.push(context, MaterialPageRoute(builder: (context) => FoodsPage()));
    });
  }


  Widget _buildLoginWithGoogleButtonRow(String text, dynamic icon) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildFaIcon(icon),
        SizedBox(
          width: 10,
        ),
        _buildButtonText(text)
      ],
    );
  }

  Widget _buildFaIcon(IconData icon) {
    return FaIcon(
      icon,
      color: Colors.white,
    );
  }

  Widget _buildButtonText(String text) {
    return Text(
      text,
      style: TextStyle(color: Colors.white),
    );
  }

  Widget _buildRegisterTextBody() {
    return InkWell(
      onTap: () => _registerFunction(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [_buildDivider(), _buildRegisterText(), _buildDivider()],
      ),
    );
  }

  void _registerFunction() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterPage()));
  }

  Widget _buildDivider() {
    return Container(
      height: 1,
      width: 75,
      color: Colors.white,
    );
  }

  Widget _buildRegisterText() {
    return Text(
      "Kayıt ol",
      style: TextStyle(color: Colors.white),
    );
  }

  Widget _buildSpace(dynamic size) {
    return SizedBox(
      height: size.height * 0.02,
    );
  }


}