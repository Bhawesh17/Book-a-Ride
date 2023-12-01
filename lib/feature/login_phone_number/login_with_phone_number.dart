import 'package:book_a_ride/constants/constants.dart';
import 'package:book_a_ride/feature/login_phone_number/verify_code.dart';
import 'package:book_a_ride/utils/utils.dart';
import 'package:book_a_ride/widgets/rounded_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginWithPhoneNumber extends StatefulWidget {
  const LoginWithPhoneNumber({super.key});

  @override
  State<LoginWithPhoneNumber> createState() => _LoginWithPhoneNumberState();
}

class _LoginWithPhoneNumberState extends State<LoginWithPhoneNumber> {

  bool loading = false;
  final phoneNumberController = TextEditingController();
  final auth = FirebaseAuth.instance;
  @override

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Login"),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 180,
          ),
          TextFormField(
            keyboardType: TextInputType.number,
         //   obscureText: true,
            textAlign: TextAlign.center,
            controller: phoneNumberController,
            onChanged: (value) {
              //Do something with the user input.
            },
            decoration: kTextFieldDecoration.copyWith(
                hintText: 'Enter your Mobile Number.',
                prefixIcon: const Padding(
                  padding: EdgeInsets.only(left: 30),
                  child: Icon(Icons.phone_iphone_rounded),
                )),
            validator: (val) {
              if (val!.isEmpty) {
                return 'Please Enter 10 Digits';
              } else {
                return null;
              }
            },
          ),
          SizedBox(
            height: 10,
          ),
          RoundedButton(
            isloading: loading,
            backgroundcolor: Colors.lightBlueAccent,
            color: Colors.white,
            title: 'Sign In',
            onPressed: () {
              setState(() {
                loading = true;
              });
              auth.verifyPhoneNumber(
                phoneNumber: phoneNumberController.text,
                  verificationCompleted: (_){
                    setState(() {
                      loading = false;
                    });
                  },
                  verificationFailed: (e){
                    setState(() {
                      loading = false;
                    });
                  Utils().toastmessage(e.toString());
                  },
                  codeSent: (String verificationId, int? token){
                    setState(() {
                      loading = false;
                    });
                    Navigator.push(context, MaterialPageRoute(builder: (context) => VerifyCodeScreen(verificationID: verificationId,)));
                  },
                  codeAutoRetrievalTimeout: (e){
                    setState(() {
                      loading = false;
                    });
                    Utils().toastmessage(e.toString());
                  },
              );
            },
          ),
        ],
      ),
    );
  }
}
