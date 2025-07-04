import 'package:cash_control/data/floor/app_database.dart';
import 'package:cash_control/data/repositories/category_repository_impl.dart';
import 'package:cash_control/data/services/category_service.dart';
import 'package:cash_control/ui/view_model/category_registration_view_model.dart';
import 'package:cash_control/ui/widgets/shared/app_bar.dart';
import 'package:cash_control/ui/widgets/shared/bottom_navigation_bar.dart';
import 'package:cash_control/ui/widgets/shared/end_drawer.dart';
import 'package:cash_control/ui/widgets/shared/custom_text_field.dart';
import 'package:cash_control/ui/widgets/shared/custom_form.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoryRegistrationScreen extends StatelessWidget {
  final AppDatabase database;

  const CategoryRegistrationScreen({super.key, required this.database});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

    return ChangeNotifierProvider<CategoryRegistrationViewModel>(
      create: (_) => CategoryRegistrationViewModel(
        CategoryService(CategoryRepositoryImpl(database.categoryDao)),
      ),
      child: Consumer<CategoryRegistrationViewModel>(
        builder: (context, viewModel, child) {
          return Scaffold(
            backgroundColor: Colors.black,
            appBar: buildAppBar(context, 'Cadastrar Categoria', '/category'),
            body: Container(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: CustomForm(
                  isLoading: viewModel.isLoading,
                  buttonText: 'Cadastrar',
                  onSubmit: () async {
                    await viewModel.registerCategory();
                    if (viewModel.errorMessage.isEmpty) {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            backgroundColor: Colors.grey[900],
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            title: const Text(
                              'Sucesso',
                              style: TextStyle(color: Colors.white),
                            ),
                            content: const Text(
                              'Categoria cadastrada com sucesso!',
                              style: TextStyle(color: Colors.white70),
                            ),
                            actions: [
                              TextButton(
                                child: const Text(
                                  'OK',
                                  style: TextStyle(color: Color(0xFFA100FF)),
                                ),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                  Navigator.pushReplacementNamed(context, '/category');
                                },
                              ),
                            ],
                          );
                        },
                      );
                    }
                  },
                  formFields: [
                    CustomTextField(
                      label: 'Nome',
                      onChanged: viewModel.setName,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, insira um nome';
                        }
                        return null;
                      },
                    ),
                    if (viewModel.errorMessage.isNotEmpty)
                      Text(
                        viewModel.errorMessage,
                        style: const TextStyle(color: Colors.red),
                      ),
                  ],
                ),
              ),
            ),
            endDrawer: buildEndDrawer(context, database),
            bottomNavigationBar: buildBottomNavigationBar(viewModel, context, scaffoldKey),
          );
        },
      ),
    );
  }
}
