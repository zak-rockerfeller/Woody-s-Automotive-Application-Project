import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/snackbar/snackbar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:web_frontend/models/models.dart';
import 'package:web_frontend/services/services.dart';
import 'package:web_frontend/screens/screens.dart';

import '../palette.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> with SingleTickerProviderStateMixin{

  bool _passwordVisible =false;
  final TextEditingController _userEmailController = TextEditingController();
  final TextEditingController _userPasswordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool loading = false;



  void _loginUser() async{
    ApiResponse response = await login(_userEmailController.text.toString(), _userPasswordController.text.toString());
    if(response.error == null){
      _saveThenRedirectToHome(response.data as User);
    }
    else{
      setState(() {
        loading = false;
      });
      Get.snackbar(
        'Sorry, try again',
        response.error!,
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 3),
      );
    }
  }

  void _saveThenRedirectToHome(User user) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString('token', user.token ?? '');
    await pref.setInt('userId', user.id ?? 0);
    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>
        NavScreen(selectedIndex: 0,)), (route) => false);
  }


  @override
  void initState() {
    super.initState();

    _passwordVisible = false;
  }


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: Scaffold(
          body: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              //Responsive Tablet
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 150, right: 25, bottom: 10, left: 25),
                    child: MediaQuery.of(context).size.width <= 700 ?
                    Form(
                      key: formKey,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      child: Column(
                        children: [
                          TextFormField(
                            textCapitalization: TextCapitalization.sentences,
                            style: const TextStyle(fontFamily: "SF-Pro-Text-Regular", fontSize: 15),
                            controller: _userEmailController,
                            decoration: InputDecoration(
                              label: const Text('Email', style: TextStyle(fontSize: 15, fontFamily: "SF-Pro-Text-Regular", color: Palette.nestBlue),),
                              prefixIcon: const Icon(FontAwesomeIcons.envelope, size: 20, color: Palette.nestBlue,),
                              hintText: "  Email",
                              hintStyle: const TextStyle(fontFamily: "SF-Pro-Text-Regular", fontSize: 15),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(35),
                                borderSide: const BorderSide(
                                  color: Palette.nestBlue,
                                  width: 1.5,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(38),
                                borderSide: const BorderSide(
                                  color: Palette.nestBlue,
                                  width: 2,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: MediaQuery.of(context).size.width/20,),
                          TextFormField(
                            textCapitalization: TextCapitalization.sentences,
                            style: const TextStyle(fontFamily: "SF-Pro-Text-Regular", fontSize: 15),
                            controller: _userPasswordController,
                            obscureText: !_passwordVisible,
                            decoration: InputDecoration(
                              label: const Text('Password', style: TextStyle(fontSize: 15, fontFamily: "SF-Pro-Text-Regular", color: Palette.nestBlue),),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _passwordVisible
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: Palette.nestBlue,
                                  size: 20,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _passwordVisible = !_passwordVisible;
                                  });
                                },
                              ),
                              prefixIcon: const Icon(FontAwesomeIcons.lock, size: 20, color: Palette.nestBlue,),
                              hintText: "  Password",
                              hintStyle: const TextStyle(fontFamily: "SF-Pro-Text-Regular", fontSize: 15),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(35),
                                borderSide:  const BorderSide(
                                  color: Palette.nestBlue,
                                  width: 1.5,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(38),
                                borderSide: const BorderSide(
                                  color: Palette.nestBlue,
                                  width: 2,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ) :
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.65,
                      child: Form(
                        key: formKey,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        child: Column(
                          children: [
                            TextFormField(
                              textCapitalization: TextCapitalization.sentences,
                              style: const TextStyle(color: Palette.nestBlue, fontFamily: "SF-Pro-Text-Regular", fontSize: 18),
                              controller: _userEmailController,
                              decoration: InputDecoration(
                                label: const Text('Email', style: TextStyle(fontSize: 18,fontFamily: "SF-Pro-Text-Regular", color: Palette.nestBlue),),
                                prefixIcon: const Icon(FontAwesomeIcons.envelope, size: 25, color: Palette.nestBlue,),
                                hintText: "  Email",
                                hintStyle: const TextStyle(fontSize: 18,fontFamily: "SF-Pro-Text-Regular", ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(35),
                                  borderSide: const BorderSide(
                                    color: Palette.nestBlue,
                                    width: 1.5,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(38),
                                  borderSide: const BorderSide(
                                    color: Palette.nestBlue,
                                    width: 2,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: MediaQuery.of(context).size.width/20,),
                            TextFormField(
                              textCapitalization: TextCapitalization.sentences,
                              style: const TextStyle(color: Palette.nestBlue, fontFamily: "SF-Pro-Text-Regular", fontSize: 18),
                              controller: _userPasswordController,
                              obscureText: !_passwordVisible,
                              decoration: InputDecoration(
                                label: const Text('Password', style: TextStyle(fontSize: 18, fontFamily: "SF-Pro-Text-Regular", color: Palette.nestBlue),),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _passwordVisible
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: Palette.nestBlue,
                                    size: 25,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _passwordVisible = !_passwordVisible;
                                    });
                                  },
                                ),
                                prefixIcon: const Icon(FontAwesomeIcons.lock, size: 25, color: Palette.nestBlue,),
                                hintText: "  Password",
                                hintStyle: const TextStyle(fontSize: 18, fontFamily: "SF-Pro-Text-Regular"),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(35),
                                  borderSide:  const BorderSide(
                                    color: Palette.nestBlue,
                                    width: 1.5,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(38),
                                  borderSide: const BorderSide(
                                    color: Palette.nestBlue,
                                    width: 2,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: MediaQuery.of(context).size.width/15,),
                  MediaQuery.of(context).size.width <= 700 ?
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: loading ? const Center(child: CircularProgressIndicator(color: Palette.nestBlue, strokeWidth: 1.6,),) :
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: Palette.nestBlue,
                                fixedSize: const Size(300, 50),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50))),
                            onPressed: () {
                              setState(() {
                                loading = true;
                                _loginUser();

                              });
                            },
                            child: const Text('Sign In',
                              style: TextStyle(color: Palette.scaffold),)),
                      ),
                      const SizedBox(height: 25),
                      const Text(
                        "---OR---",
                        style: TextStyle(fontSize: 15,
                          fontFamily: "SF-Pro-Text-Regular",),
                        textAlign: TextAlign.center,
                      ),

                      Padding(
                        padding:  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('Don\'t have an account? ', style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold,letterSpacing: 0.5,),),
                            GestureDetector(onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const RegisterScreen(),),),
                              child: const Text('Sign Up', style: TextStyle(color: Palette.nestBlue, fontSize: 16.0, fontWeight: FontWeight.w400,letterSpacing: 0.6,),),),
                          ],
                        ),
                      ),

                    ],
                  ) :
                  Column(
                    children: [
                      Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: loading ? const Center(
                            child: CircularProgressIndicator(color: Palette.nestBlue,),) :
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: Palette.nestBlue,
                                  fixedSize: const Size(350, 50),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50))),
                              onPressed: () {
                                setState(() {
                                  loading = true;
                                  _loginUser();

                                });
                              },
                              child: const Text('Sign Up', style: TextStyle(fontFamily: "SF-Pro-Text-Regular", fontSize: 20),))
                      ),
                      SizedBox(height: MediaQuery.of(context).size.width/20,),
                      const Text(
                        "---OR---",
                        style: TextStyle(fontSize: 15, fontFamily: "SF-Pro-Text-Regular"),
                        textAlign: TextAlign.center,
                      ),

                      Padding(
                        padding:  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('Don\'t have an account? ', style: TextStyle(fontSize: 20.0, fontFamily: "SF-Pro-Text-Bold",),),
                            GestureDetector(onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const RegisterScreen(),),),
                              child: const Text('Sign Up', style: TextStyle(color: Palette.nestBlue, fontSize: 20.0, fontFamily: "SF-Pro-Text-Bold",),),),
                          ],
                        ),
                      ),

                    ],
                  )

                ],
              )
          )
      ),
    );
  }


}