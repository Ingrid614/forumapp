import 'package:flutter/material.dart';
import 'package:forumapp/views/login_page.dart';
import 'package:forumapp/views/widgets/input_widget.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/authentication.dart';

class RegisterPage extends StatefulWidget{
  const RegisterPage({super.key});

  @override
  State<StatefulWidget> createState() => RegisterPageState();

}
class RegisterPageState extends State<RegisterPage>{
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final AuthenticationController _authenticationController = Get.put(AuthenticationController());


  @override
  Widget build(BuildContext context) {
    // var size = MediaQuery.of(context).size.width;
    return Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('register page', style: GoogleFonts.poppins(fontSize: 30),),
              const SizedBox(height: 30,),
              InputWidget(
                obscureText: false,
                controller: _nameController,
                hintText: 'name',
              ),
              const SizedBox(height: 30,),
              InputWidget(
                obscureText: false,
                controller: _usernameController,
                hintText: 'user name',
              ),
              const SizedBox(height: 30,),
              InputWidget(
                obscureText: false,
                controller: _emailController,
                hintText: 'email',
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
                      onPressed:()async{
                        await _authenticationController.register(
                            name: _nameController.text.trim(),
                            username: _usernameController.text.trim(),
                            email: _emailController.text.trim(),
                            password: _passwordController.text.trim()
                        );
                      },
                      child:  Obx( () {
                        return
                          _authenticationController.isLoading.value
                              ? const Center(
                              child: CircularProgressIndicator(
                                color: Colors.white,
                              ))
                              :Text(
                              'Register',
                              style: GoogleFonts.poppins(),);

                }
              ),
             ),
              TextButton(
                  onPressed: (){
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => const LoginPage()));
                  },
                  child:Text('Login', style: GoogleFonts.poppins(color: Colors.black),))

            ],
          ),
        )
    );
  }

}