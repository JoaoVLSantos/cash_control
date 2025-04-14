// lib/navigation/dashboard_navigation.dart

import 'package:cash_control/data/repositories/category_repository_impl.dart';
import 'package:cash_control/data/repositories/financial_entry_repository_impl.dart';
import 'package:cash_control/data/services/category_service.dart';
import 'package:cash_control/data/services/financial_entry_service.dart';
import 'package:cash_control/ui/view_model/category_view_model.dart';
import 'package:cash_control/ui/view_model/financial_entry_registration_view_model.dart';
import 'package:cash_control/ui/widgets/dashboard.screen.dart';
import 'package:cash_control/ui/widgets/financial_entry_registration.screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../ui/widgets/category.screen.dart';

void handleDashboardNavigation(int index, BuildContext context) {
  switch (index) {
    case 0:
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const DashboardScreen(),
        ),
      );
      break;
    case 1:
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => ChangeNotifierProvider(
              create: (_) => CategoryViewModel(
                  CategoryService(CategoryRepositoryImpl())
              ),
              child: const CategoryScreen(),
            )
        )
      );
      break;
    case 2:
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => ChangeNotifierProvider(
              create: (_) => FinancialEntryRegistrationViewModel(
                  FinancialEntryService(FinancialEntryRepositoryImpl())
              ),
              child: const FinancialEntryRegistrationScreen(),
            )
        )
      );
      break;
  }
}
