import 'package:brew_crew/services/auth.dart';
import 'package:brew_crew/shared/loading.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  final void Function() toggleView;
  const SignIn({super.key, required this.toggleView});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  String email = '';
  String password = '';
  String error= '';
  final _formKey = GlobalKey<FormState>();
  bool loading = false;


  @override
  Widget build(BuildContext context) {
    return loading ? const Loading() : Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        title: const Text("Sign In to Brew Crew"),
        backgroundColor: Colors.brown[400],
        actions: [
          TextButton.icon(onPressed: (){
            widget.toggleView();
          }, label:const Text("Registration", style:  TextStyle(
            color: Colors.black,
          ),), icon: const Icon(Icons.app_registration, color: Colors.black,),)
        ],
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                validator: (val) => val == null || val.isEmpty ? "Enter an email" : null,
                decoration: const InputDecoration(
                  labelText: 'Email',
                ),
                onChanged: (val) {
                  setState(() {
                    email = val;
                  });
                },
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                validator: (val) => val == null || val.length < 6 ? "Enter a password 6+ chars long" : null,

                decoration: const InputDecoration(
                  labelText: 'Password',
                ),
                obscureText: true,
                onChanged: (val) {
                  setState(() {
                    password = val;
                  });
                },
              ),
              const SizedBox(height: 20,),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.brown[400],
                  iconColor: Colors.white,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10)
                ),
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    setState(() {
                      loading = true;
                    });
                    dynamic result = await _auth.singInUser(email, password);
                    if(result == null) {
                      setState(() {
                        error = "Enter valid credentials";
                        loading = false;
                      });
                    }
                  }
                },
                label: const Text("Sign In"),
                icon: const Icon(Icons.person),
              ),
              const SizedBox(height: 20,),
              Text(
                error,
                style: const TextStyle(
                  fontSize: 15,
                  color: Colors.red,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
