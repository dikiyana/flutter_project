import 'package:flutter_project/blocs/auth/auth_bloc.dart';
import 'package:flutter_project/blocs/auth/auth_event.dart';
import 'package:flutter_project/blocs/auth/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();

  final namaController = TextEditingController();
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    namaController.dispose();
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Sign Up")),
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          } else if (state is AuthAuthenticated) {
            Navigator.pushReplacementNamed(context, '/home');
          }
        },
        builder: (context, state) {
          final isLoading = state is AuthLoading;

          return Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // Nama Lengkap
                    TextFormField(
                      controller: namaController,
                      decoration: const InputDecoration(labelText: 'Nama Lengkap'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Nama tidak boleh kosong';
                        }
                        if (value.length < 3) {
                          return 'Nama minimal 3 karakter';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 12),

                    // Username
                    TextFormField(
                      controller: usernameController,
                      decoration: const InputDecoration(labelText: 'Username'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Username tidak boleh kosong';
                        }
                        if (value.length < 5) {
                          return 'Username minimal 5 karakter';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 12),

                    // Email
                    TextFormField(
                      controller: emailController,
                      decoration: const InputDecoration(labelText: 'Email'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Email tidak boleh kosong';
                        }
                        if (!RegExp(r'^[^@]+@[^@]+\.com$').hasMatch(value)) {
                          return 'Email harus valid dan diakhiri .com';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 12),

                    // Password
                    TextFormField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: const InputDecoration(labelText: 'Password'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Password tidak boleh kosong';
                        }
                        if (value.length < 6) {
                          return 'Password minimal 6 karakter';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 12),

                    // Konfirmasi Password
                    TextFormField(
                      controller: confirmPasswordController,
                      obscureText: true,
                      decoration: const InputDecoration(labelText: 'Konfirmasi Password'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Konfirmasi password tidak boleh kosong';
                        }
                        if (value != passwordController.text) {
                          return 'Password tidak sama';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),

                    // Tombol Daftar
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: isLoading
                            ? null
                            : () {
                                if (_formKey.currentState!.validate()) {
                                  context.read<AuthBloc>().add(AuthSignUp(
                                        nama_lengkap: namaController.text.trim(),
                                        username: usernameController.text.trim(),
                                        email: emailController.text.trim(),
                                        password: passwordController.text.trim(),
                                        confirm_password:
                                            confirmPasswordController.text.trim(),
                                      ));
                                }
                              },
                        child: isLoading
                            ? const CircularProgressIndicator(color: Colors.white)
                            : const Text("Daftar"),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
