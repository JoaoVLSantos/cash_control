import 'package:cash_control/ui/view_model/login_view_model.dart';
import 'package:cash_control/ui/widgets/user_registration.screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Consumer<LoginViewModel>(
            builder: (context, viewModel, child) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/logo_cash_control.jpg',
                    width: 150,
                    height: 150,
                  ),

                  const SizedBox(height: 24),
                  const SizedBox(height: 8),
                  TextField(
                    controller: viewModel.emailController,
                    decoration: const InputDecoration(
                      labelText: 'E-mail',
                      labelStyle: TextStyle(color: Colors.white),
                      hintText: 'Digite seu e-mail',
                      hintStyle: TextStyle(color: Colors.grey),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.purple),
                      ),
                    ),
                    style: const TextStyle(color: Colors.white),
                  ),

                  const SizedBox(height: 16),
                  TextField(
                    controller: viewModel.passwordController,
                    decoration: const InputDecoration(
                      labelText: 'Senha',
                      labelStyle: TextStyle(color: Colors.white),
                      hintText: 'Digite sua senha',
                      hintStyle: TextStyle(color: Colors.grey),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.purple),
                      ),
                    ),
                    style: const TextStyle(color: Colors.white),
                    obscureText: true,
                  ),

                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () async {
                      await viewModel.login();
                      if (viewModel.error != null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              viewModel.error!,
                              style: const TextStyle(color: Colors.white),
                            ),
                            backgroundColor: Colors.red,
                          ),
                        );
                      } else {
                        // Navegar para a próxima tela após o login bem-sucedido
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.purple,
                      backgroundColor: Colors.white,
                    ),
                    child: const Text('Entrar'),
                  ),

                  const SizedBox(height: 8),
                  TextButton(
                    onPressed: () {
                      // Navegar para a tela de recuperação de senha
                    },
                    child: const Text(
                      'Esqueceu sua senha?',
                      style: TextStyle(color: Colors.purple),
                    ),
                  ),

                  const SizedBox(height: 8),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const UserRegistrationScreen(),
                        ),
                      );
                    },
                    child: const Text(
                      'Não possui uma conta? Cadastre-se',
                      style: TextStyle(color: Colors.purple),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
