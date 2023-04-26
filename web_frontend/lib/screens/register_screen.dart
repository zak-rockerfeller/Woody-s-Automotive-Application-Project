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



class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> with SingleTickerProviderStateMixin {
  final bool value = false;
  bool _passwordVisible =false;
  final bool _validateEmail = false;
  bool _confirmPasswordVisible =false;
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  RegExp numReg = RegExp(r".*[0-9].*");
  RegExp letterReg = RegExp(r".*[A-Za-z].*");
  String? validateEmail(String jew) {
    String pattern =
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?)*$";
    RegExp regex = RegExp(pattern);
    if (jew.isEmpty || !regex.hasMatch(jew)) {
      return 'Enter a valid email address';
    } else {
      return null;
    }
  }
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool loading = false;



  void _registerUser() async{
    ApiResponse response = await register(nameController.text.toString(), emailController.text, passwordController.text);
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
      onTap:  () => FocusScope.of(context).requestFocus(FocusNode()),
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_rounded),
            //iconSize: 30.0,
            color: Palette.nestBlue,
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const SignInScreen(),),),

          ),
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          elevation: 3,


        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: ListView(
            children: [
              Form(
                key: formKey,
                child: Column(
                  children: [
                    Padding(
                        padding: const EdgeInsets.only(top: 15, right: 25, bottom: 10, left: 25),
                        child: MediaQuery.of(context).size.width <= 700 ?
                        TextFormField(
                          textCapitalization: TextCapitalization.sentences,
                          style: const TextStyle(fontFamily: "SF-Pro-Text-Regular", fontSize: 15),
                          controller: nameController ,
                          decoration: InputDecoration(
                            label: const Text('Full name', style: TextStyle(fontSize: 15, fontFamily: "SF-Pro-Text-Regular", color: Palette.nestBlue),),
                            prefixIcon: const Icon(FontAwesomeIcons.user, size: 20, color: Palette.nestBlue,),
                            hintText: "  Full name",
                            hintStyle: const TextStyle(fontFamily: "SF-Pro-Text-Regular", fontSize: 15),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                color: Palette.nestBlue,
                                width: 1.5,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: const BorderSide(
                                color: Palette.nestBlue,
                                width: 2,
                              ),
                            ),
                          ),
                        ) :
                        SizedBox(width: MediaQuery.of(context).size.width * 0.65,
                          child: TextFormField(
                            textCapitalization: TextCapitalization.sentences,
                            style: const TextStyle(fontFamily: "SF-Pro-Text-Regular", fontSize: 18),
                            controller: nameController ,
                            decoration: InputDecoration(
                              label: const Text('Full name', style: TextStyle(fontSize: 18, color: Palette.nestBlue, fontFamily: "SF-Pro-Text-Regular",),),
                              prefixIcon: const Icon(FontAwesomeIcons.user, size: 25, color: Palette.nestBlue,),
                              hintText: "  Full name",
                              hintStyle: const TextStyle(fontFamily: "SF-Pro-Text-Regular", fontSize: 18),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                  color: Palette.nestBlue,
                                  width: 1.5,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: const BorderSide(
                                  color: Palette.nestBlue,
                                  width: 2,
                                ),
                              ),
                            ),
                          ),)
                    ),
                    SizedBox(height: MediaQuery.of(context).size.width/200,),
                    Padding(
                        padding: const EdgeInsets.only(top: 15, right: 25, bottom: 10, left: 25),
                        child: MediaQuery.of(context).size.width <= 700 ?
                        Form(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          child: TextFormField(
                            textCapitalization: TextCapitalization.sentences,
                            style: const TextStyle(fontFamily: "SF-Pro-Text-Regular", fontSize: 15),
                            controller: emailController,
                            decoration: InputDecoration(
                              label: const Text('Email', style: TextStyle(fontSize: 15, fontFamily: "SF-Pro-Text-Regular", color: Palette.nestBlue),),
                              errorText: _validateEmail ? 'Enter a valid email address.' : null,
                              prefixIcon: const Icon(FontAwesomeIcons.envelope, size: 20, color: Palette.nestBlue,),
                              hintText: "  Email",
                              hintStyle: const TextStyle(fontFamily: "SF-Pro-Text-Regular", fontSize: 15),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                  color: Palette.nestBlue,
                                  width: 1.5,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: const BorderSide(
                                  color: Palette.nestBlue,
                                  width: 2,
                                ),
                              ),
                            ),
                          ),
                        ) : SizedBox(width: MediaQuery.of(context).size.width * 0.65,
                          child: Form(
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            child: TextFormField(
                              textCapitalization: TextCapitalization.sentences,
                              style: const TextStyle(fontSize: 18, fontFamily: "SF-Pro-Text-Regular"),
                              controller: emailController,
                              decoration: InputDecoration(
                                label: const Text('Email', style: TextStyle(fontSize: 18, fontFamily: "SF-Pro-Text-Regular", color: Palette.nestBlue),),
                                errorText: _validateEmail ? 'Enter a valid email address.' : null,
                                prefixIcon: const Icon(FontAwesomeIcons.envelope, size: 25, color: Palette.nestBlue,),
                                hintText: "  Email",
                                hintStyle: const TextStyle(color: Palette.nestBlue),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                    color: Palette.nestBlue,
                                    width: 1.5,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: const BorderSide(
                                    color: Palette.nestBlue,
                                    width: 2,
                                  ),
                                ),
                              ),
                            ),
                          ),)
                    ),
                    SizedBox(height: MediaQuery.of(context).size.width/200,),
                    Padding(
                        padding: const EdgeInsets.only(top: 15, right: 25, bottom: 5, left: 25),
                        child: MediaQuery.of(context).size.width <= 700 ?
                        TextFormField(
                          textCapitalization: TextCapitalization.sentences,
                          style: const TextStyle(fontSize: 15, fontFamily: "SF-Pro-Text-Regular"),
                          controller: passwordController,
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
                            hintStyle: const TextStyle(fontSize: 15, fontFamily: "SF-Pro-Text-Regular"),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide:  const BorderSide(
                                color: Palette.nestBlue,
                                width: 1.5,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: const BorderSide(
                                color: Palette.nestBlue,
                                width: 2,
                              ),
                            ),
                          ),
                        ) : SizedBox(width: MediaQuery.of(context).size.width * 0.65,
                          child: TextFormField(
                            textCapitalization: TextCapitalization.sentences,
                            style: const TextStyle(fontSize: 18, fontFamily: "SF-Pro-Text-Regular",),
                            controller: passwordController,
                            obscureText: !_passwordVisible,
                            decoration: InputDecoration(
                              label: const Text('Password', style: TextStyle(fontSize: 18, fontFamily: "SF-Pro-Text-Regular", color: Palette.nestBlue),),
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
                              prefixIcon: const Icon(FontAwesomeIcons.lock, size: 25, color: Palette.nestBlue,),
                              hintText: "  Password",
                              hintStyle: const TextStyle(fontSize: 18, fontFamily: "SF-Pro-Text-Regular",),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:  const BorderSide(
                                  color: Palette.nestBlue,
                                  width: 1.5,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: const BorderSide(
                                  color: Palette.nestBlue,
                                  width: 2,
                                ),
                              ),
                            ),
                          ),)
                    ),
                    SizedBox(height: MediaQuery.of(context).size.width/200,),
                    Padding(
                        padding: const EdgeInsets.only(top: 15, right: 25, bottom: 5, left: 25),
                        child: MediaQuery.of(context).size.width <= 700 ?
                        TextFormField(
                          textCapitalization: TextCapitalization.sentences,
                          style: const TextStyle(fontSize: 15, fontFamily: "SF-Pro-Text-Regular",),
                          controller: confirmPasswordController,
                          obscureText: _confirmPasswordVisible,
                          validator: (val) => val != passwordController.text ? 'Password does not match' : null,
                          decoration: InputDecoration(
                            label: const Text('Confirm password', style: TextStyle(fontSize: 15, fontFamily: "SF-Pro-Text-Regular", color: Palette.nestBlue),),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _confirmPasswordVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: Palette.nestBlue,
                                size: 20,
                              ),
                              onPressed: () {
                                setState(() {
                                  _confirmPasswordVisible = !_confirmPasswordVisible;
                                });
                              },
                            ),
                            prefixIcon: const Icon(FontAwesomeIcons.lock, size: 20, color: Palette.nestBlue,),
                            hintText: "  Confirm password",
                            hintStyle: const TextStyle(fontSize: 15, fontFamily: "SF-Pro-Text-Regular",),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide:  const BorderSide(
                                color: Palette.nestBlue,
                                width: 1.5,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: const BorderSide(
                                color: Palette.nestBlue,
                                width: 2,
                              ),
                            ),
                          ),
                        ) : SizedBox(width: MediaQuery.of(context).size.width * 0.65,
                          child: TextFormField(
                            textCapitalization: TextCapitalization.sentences,
                            style: const TextStyle(fontSize: 18, fontFamily: "SF-Pro-Text-Regular",),
                            controller: confirmPasswordController,
                            obscureText: _confirmPasswordVisible,
                            validator: (val) => val != passwordController.text ? 'Password does not match' : null,
                            decoration: InputDecoration(
                              label: const Text('Confirm password', style: TextStyle(fontSize: 18, fontFamily: "SF-Pro-Text-Regular", color: Palette.nestBlue),),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _confirmPasswordVisible
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: Palette.nestBlue,
                                  size: 20,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _confirmPasswordVisible = !_confirmPasswordVisible;
                                  });
                                },
                              ),
                              prefixIcon: const Icon(FontAwesomeIcons.lock, size: 25, color: Palette.nestBlue,),
                              hintText: "  Confirm password",
                              hintStyle: const TextStyle(fontSize: 18, fontFamily: "SF-Pro-Text-Regular",),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:  const BorderSide(
                                  color: Palette.nestBlue,
                                  width: 1.5,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: const BorderSide(
                                  color: Palette.nestBlue,
                                  width: 2,
                                ),
                              ),
                            ),
                          ),)
                    ),
                  ],
                ),

              ),
              MediaQuery.of(context).size.width <= 700 ?
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 15),
                  child: loading ? const Center(child: CircularProgressIndicator(
                    color: Palette.nestBlue,
                  ),)  :
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: Palette.nestBlue,
                          fixedSize: const Size(200, 50),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50))),
                      onPressed:() {
                        setState(() {
                          loading = true;
                          _registerUser();

                        });
                      },
                      child: const Text('Sign Up', style: TextStyle(fontFamily: "SF-Pro-Text-Regular", fontSize: 16),))

              ) :
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 180.0, vertical: 40),
                  child: loading ? const Center(child: CircularProgressIndicator(color: Palette.nestBlue, strokeWidth: 1.6,),)  :
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: Palette.nestBlue,
                          fixedSize: const Size(500, 50),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50))),
                      onPressed:() {
                        setState(() {
                          loading = true;
                          _registerUser();
                        });
                      },
                      child: const Text('Sign Up', style: TextStyle(fontFamily: "SF-Pro-Text-Regular", fontSize: 20),))

              ),

              //SizedBox(height: MediaQuery.of(context).size.height * 0.02,),
              MediaQuery.of(context).size.width <= 700 ?
              const Text(
                "---OR---",
                style: TextStyle(fontFamily: "SF-Pro-Text-Regular",),
                textAlign: TextAlign.center,

              ) :
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 20.0),
                child: Text(
                  "---OR---",
                  style: TextStyle(fontFamily: "SF-Pro-Text-Regular", fontSize: 18),
                  textAlign: TextAlign.center,

                ),
              ),
              const SizedBox(height: 15),
              Padding(
                  padding:  const EdgeInsets.only(bottom: 20),
                  child: MediaQuery.of(context).size.width <= 700 ?
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Already have an account? ', style: TextStyle(fontSize: 15.0, fontFamily: "SF-Pro-Text-Bold",),),
                      GestureDetector(onTap: () =>
                          Navigator.push(context, MaterialPageRoute(builder: (_) => const SignInScreen()),),
                        child: const Text('Sign In', style: TextStyle(color: Palette.nestBlue, fontSize: 16.0, fontFamily: "SF-Pro-Text-Bold",),),),
                    ],
                  ) :
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Already have an account? ', style: TextStyle(fontSize: 18.0, fontFamily: "SF-Pro-Text-Bold",),),
                      GestureDetector(onTap: () =>
                          Navigator.push(context, MaterialPageRoute(builder: (_) => const SignInScreen()),),
                        child: const Text('Sign In', style: TextStyle(color: Palette.nestBlue, fontSize: 20.0, fontFamily: "SF-Pro-Text-Bold",),),),
                    ],
                  )
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}