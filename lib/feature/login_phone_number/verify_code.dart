import 'package:book_a_ride/constants/constants.dart';
import 'package:book_a_ride/feature/home_screen/home_screen.dart';
import 'package:book_a_ride/utils/utils.dart';
import 'package:book_a_ride/widgets/rounded_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class VerifyCodeScreen extends StatefulWidget {
  final String verificationID;
  const VerifyCodeScreen({Key? key , required this.verificationID}): super(key: key);

  @override
  State<VerifyCodeScreen> createState() => _VerifyCodeScreenState();
}

class _VerifyCodeScreenState extends State<VerifyCodeScreen> {
  bool loading = false;
  final verificationNumberController = TextEditingController();
  final auth = FirebaseAuth.instance;
  @override

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Verify"),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 180,
          ),
          TextFormField(
            keyboardType: TextInputType.number,
            obscureText: true,
            textAlign: TextAlign.center,
            controller: verificationNumberController,
            onChanged: (value) {
              //Do something with the user input.
            },
            decoration: kTextFieldDecoration.copyWith(
                hintText: 'Enter 6 Digit-Code.',
                prefixIcon: const Padding(
                  padding: EdgeInsets.only(left: 30),
                  child: Icon(Icons.phone_iphone_rounded),
                )),
            validator: (val) {
              if (val!.isEmpty) {
                return 'Please Enter 6 Digit-Code';
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
            onPressed: () async{
              setState(() {
                loading = true;
              });
              final credential = PhoneAuthProvider.credential(
                  verificationId: widget.verificationID,
                  smsCode: verificationNumberController.text.toString());
              try{
                  await auth.signInWithCredential(credential);
                  Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
              }catch(e){
                setState(() {
                  loading = false;
                });
                Utils().toastmessage(e.toString());
              }
            },
          ),
        ],
      ),
    );
  }
}
