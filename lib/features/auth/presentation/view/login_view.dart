import 'package:fitness_tracker/features/auth/presentation/view/register_view.dart';
import 'package:fitness_tracker/features/auth/presentation/view_model/login/login_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginView extends StatefulWidget {
  LoginView({super.key});

  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  final _gap = const SizedBox(height: 8);

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _logoAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );

    _logoAnimation = Tween<Offset>(
      begin: const Offset(0, -0.2), // Slightly above the original position
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.elasticOut, // Bouncing effect for the logo
    ));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Animated Gradient Background
          AnimatedContainer(
            duration: const Duration(seconds: 2),
            curve: Curves.easeInOut,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromARGB(255, 10, 10, 10),
                  Color.fromARGB(255, 17, 17, 17),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          Positioned(
            top: 120,
            left: 140,
            child: SlideTransition(
              position: _logoAnimation,
              child: Image.asset('assets/logo/gym_logo.png', height: 100),
            ),
          ),
          Center(
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: SingleChildScrollView(
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 8,
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Form(
                      key: widget._formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Animated Title
                          ScaleTransition(
                            scale: _fadeAnimation,
                            child: const Text(
                              'Welcome Back',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 255, 55, 0),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          // Username Input
                          SlideTransition(
                            position: Tween<Offset>(
                              begin: const Offset(-1, 0),
                              end: Offset.zero,
                            ).animate(_fadeAnimation),
                            child: TextFormField(
                              key: const ValueKey("username"),
                              controller: widget._usernameController,
                              decoration: const InputDecoration(
                                labelText: 'Username',
                                prefixIcon: Icon(
                                  Icons.email,
                                  color: Color.fromARGB(255, 255, 55, 0),
                                ),
                                border: OutlineInputBorder(),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your username';
                                }
                                return null;
                              },
                            ),
                          ),
                          widget._gap,
                          // Password Input
                          SlideTransition(
                            position: Tween<Offset>(
                              begin: const Offset(1, 0),
                              end: Offset.zero,
                            ).animate(_fadeAnimation),
                            child: TextFormField(
                              key: const ValueKey('password'),
                              controller: widget._passwordController,
                              obscureText: true,
                              decoration: const InputDecoration(
                                labelText: 'Password',
                                prefixIcon: Icon(
                                  Icons.lock,
                                  color: Color.fromARGB(255, 255, 55, 0),
                                ),
                                border: OutlineInputBorder(),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your password';
                                }
                                return null;
                              },
                            ),
                          ),
                          widget._gap,
                          // Login Button
                          ScaleTransition(
                            scale: _fadeAnimation,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 40,
                                  vertical: 12,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                backgroundColor:
                                    const Color.fromARGB(255, 255, 55, 0),
                                foregroundColor: Colors.white,
                              ),
                              onPressed: () {
                                if (widget._formKey.currentState!.validate()) {
                                  context.read<LoginBloc>().add(
                                        LoginUserEvent(
                                          context: context,
                                          userName:
                                              widget._usernameController.text,
                                          password:
                                              widget._passwordController.text,
                                        ),
                                      );
                                }
                              },
                              child: const Text(
                                'Login',
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          // Signup Link
                          FadeTransition(
                            opacity: _fadeAnimation,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text("Don't have an account?"),
                                TextButton(
                                  onPressed: () {
                                    context.read<LoginBloc>().add(
                                          NavigateRegisterScreenEvent(
                                            destination: const RegisterView(),
                                            context: context,
                                          ),
                                        );
                                  },
                                  child: const Text(
                                    'Sign Up',
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 255, 55, 0),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
