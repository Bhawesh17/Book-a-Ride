import 'package:book_a_ride/constants/constants.dart';
import 'package:book_a_ride/feature/login&singup_screen/login_screen.dart';
import 'package:book_a_ride/utils/utils.dart';
import 'package:book_a_ride/widgets/rounded_button.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SingUp extends StatefulWidget {
  const SingUp({Key? key}) : super(key: key);

  @override
  _SingUpState createState() => _SingUpState();
}

class _SingUpState extends State<SingUp> {
  bool isLoading = false;

  final _formKey = GlobalKey<FormState>();
  TextEditingController userNameTextEditingController =
      new TextEditingController();
  TextEditingController emailTextEditingController =
      new TextEditingController();
  TextEditingController phoneTextEditingController =
      new TextEditingController();
  TextEditingController passwordNameTextEditingController =
      new TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
              appBar: AppBar(
                automaticallyImplyLeading: false,
                title: const Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: Center(
                      child: Text(
                    'SING-UP',
                    style: TextStyle(
                        fontFamily: "Shizuru",
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  )),
                ),
                backgroundColor: Colors.transparent,
              ),
              backgroundColor: const Color(0xFFff4600).withOpacity(0.5),
              body: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: SingleChildScrollView(
                  child: Container(
                    margin: const EdgeInsets.only(top: 130),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 5,
                              ),
                              child: AnimatedTextKit(
                                animatedTexts: [
                                  TypewriterAnimatedText(
                                    'Book A Ride',
                                    textStyle: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 30.0,
                                      fontWeight: FontWeight.w900,
                                    ),
                                    speed: const Duration(milliseconds: 100),
                                  ),
                                ],
                                totalRepeatCount: 1,
                                pause: const Duration(milliseconds: 1000),
                                displayFullTextOnTap: true,
                                stopPauseOnTap: true,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 30.0,
                        ),
                        Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              // TextFormField(
                              //   validator: (val) {
                              //     return val!.isEmpty || val.length < 2
                              //         ? "Please Provide UserName"
                              //         : null;
                              //   },
                              //   controller: userNameTextEditingController,
                              //   textAlign: TextAlign.center,
                              //   onChanged: (value) {
                              //     //Do something with the user input.
                              //   },
                              //   decoration: kTextFieldDecoration.copyWith(
                              //     hintText: 'Enter your Name',
                              //   ),
                              // ),
                              // const SizedBox(
                              //   height: 8.0,
                              // ),
                              TextFormField(
                                validator: (val) {
                                  return RegExp(
                                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                          .hasMatch(val!)
                                      ? null
                                      : "Please Enter Correct Email";
                                },
                                controller: emailTextEditingController,
                                keyboardType: TextInputType.emailAddress,
                                textAlign: TextAlign.center,
                                onChanged: (value) {
                                  //Do something with the user input.
                                },
                                decoration: kTextFieldDecoration.copyWith(
                                  hintText: 'Enter your email',
                                    prefixIcon:const Padding(
                                      padding:  EdgeInsets.only(left: 30),
                                      child: Icon(Icons.alternate_email_outlined),
                                    )
                                ),
                              ),
                              const SizedBox(
                                height: 8.0,
                              ),
                              // TextFormField(
                              //   validator: (val) {
                              //     return val!.length < 11
                              //         ? null
                              //         : "Enter Password 6+ characters";
                              //   },
                              //   controller: phoneTextEditingController,
                              //   keyboardType: TextInputType.number,
                              //   textAlign: TextAlign.center,
                              //   onChanged: (value) {
                              //     //Do something with the user input.
                              //   },
                              //   decoration: kTextFieldDecoration.copyWith(
                              //     hintText: 'Enter your Phone Number',
                              //   ),
                              // ),
                              // const SizedBox(
                              //   height: 8.0,
                              // ),
                              TextFormField(
                                  validator: (val) {
                                    return val!.length > 6
                                        ? null
                                        : "Enter Password 6+ characters";
                                  },
                                  controller: passwordNameTextEditingController,
                                  obscureText: true,
                                  textAlign: TextAlign.center,
                                  onChanged: (value) {
                                    //Do something with the user input.
                                  },
                                  decoration: kTextFieldDecoration.copyWith(
                                    hintText: 'Enter your password.',
                                      prefixIcon:const Padding(
                                        padding: EdgeInsets.only(left: 30),
                                        child: Icon(Icons.lock_outlined),
                                      )
                                  )),
                              const SizedBox(
                                height: 8.0,
                              ),
                            ],
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            child: const Text(
                              'Forgot Password?',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            // Expanded(
                            //
                            //   child: RoundedButton(
                            //     onPressed: (){
                            //
                            //     },
                            //     backgroundcolor: Colors.white,
                            //     color : Colors.black,
                            //     title: 'Sign with P.Number',
                            //   ),
                            // ),
                            Expanded(
                              child: RoundedButton(
                                isloading: isLoading,
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    setState(() {
                                      isLoading = true;
                                    });
                                    auth.createUserWithEmailAndPassword(
                                      email: emailTextEditingController.text.toString(),
                                      password: passwordNameTextEditingController.text.toString()
                                    ).then((value) {
                                      setState(() {
                                        isLoading = false;
                                      });
                                    }).onError((error, stackTrace) {
                                        Utils().toastmessage(error.toString());
                                        setState(() {
                                          isLoading = false;
                                        });
                                    });
                                  }
                                },

                                backgroundcolor: Colors.lightBlueAccent,
                                color: Colors.white,
                                title: 'Sign Up',
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 5.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Already have account? ",
                              style: TextStyle(color: Colors.white),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => LoginScreen()));
                              },
                              child: const Text(
                                'Sign in now',
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 17,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
    );
  }
}
