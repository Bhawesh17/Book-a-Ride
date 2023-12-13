
import 'package:book_a_ride/feature/home_screen/home_screen.dart';
import 'package:book_a_ride/feature/login&singup_screen/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SplashServices {



   checkIfUserIsLoggedIn() {
    final _auth = FirebaseAuth.instance;
    final user = _auth.currentUser;

    if(user != null){
      return true;
    }else{
      return false;
    }
  }

}