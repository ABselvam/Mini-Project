import 'package:flutter/material.dart';
import 'login.dart';
import 'signup.dart';
class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255,62, 62, 62),
      //appBar: AppBar(),
      body: SafeArea(child: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
        image : DecorationImage(
          image: AssetImage('assets/images/homescreen.png'),
          fit: BoxFit.cover)),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
            const Text('RAPP',
                    textAlign: TextAlign.center,
                    style: TextStyle(
            color: Color.fromARGB(255,226, 183, 19),
            fontSize: 75,
            fontWeight: FontWeight.bold
                    ),),
            const SizedBox(
              height: 5,
            ),
            const Text('THE RENT ANYTHING APP',
                    textAlign: TextAlign.center,
                    style: TextStyle(
            color: Color.fromARGB(255,226, 183, 19),
            fontSize: 15,
                    ),),
          const SizedBox(
            height: 150,

          ),
          // TextField(
          //   decoration: InputDecoration(
          //     border: OutlineInputBorder(),
          //     hintText: 'username',
          //   ),
          // ),
          ElevatedButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>const LoginPage()));
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromARGB(255,226, 183, 19),
            foregroundColor: const Color.fromARGB(255,32, 34, 37),
             textStyle: const TextStyle(fontSize: 20),
            minimumSize: const Size(170, 40)), 
          child: const Text('LOGIN'),),
          const SizedBox(height: 60),
          ElevatedButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>SignUpPage()));
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromARGB(255,226, 183, 19),
            foregroundColor: const Color.fromARGB(255,32, 34, 37),
             textStyle: const TextStyle(fontSize: 20),
            minimumSize: const Size(170, 40)), 
          child: const Text('SIGNUP'),),
          ],),
        ),
      )),
    );
  }
}