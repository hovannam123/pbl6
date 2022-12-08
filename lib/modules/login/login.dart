
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pbl6/api/api_request.dart';
import 'package:pbl6/config/app_text_style.dart';
import 'package:pbl6/model/login.dart';
import 'package:pbl6/modules/login/stacklogin.dart';
import 'package:pbl6/modules/register/register.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../config/app_color.dart';
import '../home/home.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {


  bool passwordVisible = false;
  bool checkBox = false;
  bool checkLogin = false;
  bool isApiCall = false;
  late LoginRequestModel requestModel;
  final GlobalKey<FormState> _loginKey = GlobalKey<FormState>();
  TextEditingController controlEmail = TextEditingController();
  TextEditingController controlPassword = TextEditingController();

  bool isEmail(String string) {
    // Null or empty string is invalid
    if (string == null || string.isEmpty) {
      return false;
    }

    const pattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
    final regExp = RegExp(pattern);

    if (!regExp.hasMatch(string)) {
      return false;
    }
    return true;
  }

  @override
  void initState() {
    passwordVisible = true;
    requestModel = LoginRequestModel();
  }

  // @override
  // Widget build(BuildContext context){
  //   return StackLogin(child: login(context), isAsyncCall: isApiCall);
  // }
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 25),
          child: Form(
            key: _loginKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 40, top: 20),
                  width: 150,
                  height: 150,
                  padding: EdgeInsets.only(top: 20),
                  decoration: BoxDecoration(
                    image: const DecorationImage(
                      image: AssetImage('assets/images/logo.png'),
                    ), //Border.all
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ), //BorderRadius.all
                  ), //BoxDecoration
                ),
                const Text('Sign in', style: AppTextStyle.heading1Medium,),
                const SizedBox(height: 10,),
                const Text("If you don't have an account.", style: AppTextStyle.heading3BlackBold),
                Row(
                  children: [
                    const Text('You can', style: AppTextStyle.heading3BlackBold),
                    TextButton(
                        onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => Register()));
                        },
                        child: const Text('Register here !', style: AppTextStyle.heading3LightBlue,)),
                  ],
                ),
                const SizedBox(height: 30,),
                SizedBox(
                  height: size.height/13,
                  child: Container(
                    decoration: BoxDecoration(
                      color: DarkTheme.grey,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(left: 24, right: 24),
                          child: Icon(Icons.email_outlined,color: Colors.white,),
                        ),
                        Expanded(
                          child: TextFormField(
                            style: AppTextStyle.heading3Black,
                            decoration: const InputDecoration(
                                hintText: 'Enter your email address',
                                hintStyle: AppTextStyle.heading3Black,
                                border: InputBorder.none,
                                errorStyle: AppTextStyle.heading4Red
                            ),
                            onSaved: (input) => requestModel.username = input,
                                validator: (value){
                                if(value == null || value.isEmpty){
                                return 'Vui lòng nhập email';
                                }
                                else if(!isEmail(value)){
                                return 'Vui lòng nhập đúng định dạng email';
                              }
                              return null;
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20,),
                SizedBox(
                  height: size.height/13,
                  child: Container(
                    decoration: BoxDecoration(
                      color: DarkTheme.grey,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children:  [
                        const Padding(
                          padding: EdgeInsets.only(left: 24, right: 24),
                          child: Icon(Icons.lock_outline_rounded,color: Colors.white,),
                        ),
                        Expanded(
                          child: TextFormField(
                            style: AppTextStyle.heading3Black,
                            obscureText: passwordVisible,
                            decoration: InputDecoration(
                                hintText: 'Enter your password',
                                hintStyle: AppTextStyle.heading3Black,
                                border: InputBorder.none,
                                errorStyle: AppTextStyle.heading4Red,
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    passwordVisible
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: Colors.black,
                                  ),
                                  onPressed: () {
                                    setState((){
                                      passwordVisible
                                          ? passwordVisible = false
                                          : passwordVisible = true;
                                    });
                                  },
                                ),
                            ),
                            onSaved: (input) => requestModel.password = input,
                            validator: (value){
                              return (value == null || value.isEmpty) ? 'Vui lòng nhập password' : null;
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Checkbox(
                          value: checkBox,
                          checkColor: Colors.black,
                          side: const BorderSide(color: Colors.black),
                          onChanged: (bool? newValue){
                            setState((){
                              checkBox = newValue!;
                            });
                          },
                        ),
                        const Text('Remember me', style: AppTextStyle.heading4Black,)
                      ],
                    ),
                    TextButton(onPressed: (){},
                        child: const Text('Forget password?', style: AppTextStyle.heading4Black,))
                  ],
                ),
                SizedBox(height: 30,),
                Container(
                  height: 60,
                  width: size.width,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.lightBlue,
                        minimumSize: const Size(88, 36),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(25))
                        )
                      ),
                      onPressed: (){
                        if(_loginKey.currentState!.validate()){
                          _loginKey.currentState!.save();
                          NetworkRequest.login(requestModel).then((value) => {
                            print(value.token),
                            NetworkRequest.setToken(value.token.toString()),
                            Navigator.push(context, MaterialPageRoute(builder: (context) =>  const Home()))
                          });
                          print(requestModel.toJson());
                        }
                      },
                      child: const Center(
                          child: Text('Login', style: AppTextStyle.heading2,)
                      )),
                ),
                const SizedBox(height: 20,),
                const Align(
                  alignment: Alignment.center,
                  child: Text('or continue with',style: AppTextStyle.heading4Black, ),
                ),
                const SizedBox(height: 20,),
                Center(
                  child: SizedBox(
                    height: 50,
                    width: size.width/2,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        FloatingActionButton(heroTag: null, onPressed: (){}, child: Image.asset('assets/images/logo_fb.png',),backgroundColor: Colors.white, ),
                        FloatingActionButton(heroTag: null, onPressed: (){}, child: Image.asset('assets/images/logo_apple.png',),backgroundColor: Colors.black,),
                        FloatingActionButton(heroTag: null, onPressed: (){}, child: Image.asset('assets/images/logo_google.png'),backgroundColor: Colors.white,)
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
