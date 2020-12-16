
//  https://api.github.com/users/JakeWharton/repos?page=1&per_page=30
  import 'dart:ui';

import 'package:flutter/material.dart';

var base_url="https://api.github.com/users/JakeWharton/repos";
var titlestyle=TextStyle(
    color: Colors.black
    ,fontSize: 17 ,fontFamily: "Castoro"  );
var childtyle=TextStyle(
    color: Colors.black45
    ,fontSize: 16 ,fontFamily: "Castoro" ,decoration: TextDecoration.underline,  );
var othertyle=TextStyle(
    color: Colors.black45
    ,fontSize: 16 ,fontFamily: "Castoro"   );

final prsnlAcsTken = "cb0e6540a8b1c8d58e1b28cbf663212da55675bf";