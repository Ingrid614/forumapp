import 'package:flutter/material.dart';
import 'package:forumapp/controllers/authentication.dart';
import 'package:forumapp/views/register_page.dart';
import 'package:forumapp/views/widgets/input_widget.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatefulWidget{
  const LoginPage({super.key});

  @override
  State<StatefulWidget> createState() => LoginPageState();

}

class LoginPageState extends State<LoginPage>{

   final TextEditingController _usernameController = TextEditingController();
   final TextEditingController _passwordController = TextEditingController();
   final AuthenticationController _authenticationController = Get.put(AuthenticationController());


  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('login page',style: GoogleFonts.poppins(fontSize: 30,)),
          const SizedBox(height: 30,),
         InputWidget(
           obscureText: false,
           controller: _usernameController,
           hintText: 'user name',
         ),
          const SizedBox(height: 30,),
         InputWidget(
             hintText: 'password',
             controller: _passwordController,
             obscureText: true),
          const SizedBox(height: 30,),
          ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 50,
                      vertical: 10
                    )
                  ),
                  onPressed: ()async{
                    await _authenticationController.login(
                        username: _usernameController.text.trim(),
                        password: _passwordController.text.trim()
                    );
                  },
                  child: Obx(() {
                    return
                      _authenticationController.isLoading.value? const CircularProgressIndicator()
                          : Text('Login', style: GoogleFonts.poppins(),);
            }
            )
          ),
          TextButton(
              onPressed: (){
                Navigator.push(context,
                MaterialPageRoute(builder: (context) => const RegisterPage()));
              },
              child: Text('register' , style: GoogleFonts.poppins(color: Colors.black),))

        ],
      ),
      )
    );
  }

}