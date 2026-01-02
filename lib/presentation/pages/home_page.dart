import 'package:customer_management/presentation/screens/add_customer_screen.dart';
import 'package:customer_management/presentation/screens/customer_screen.dart';
import 'package:customer_management/presentation/screens/dashboard_screen.dart';
import 'package:customer_management/presentation/screens/profile_screen.dart';
import 'package:customer_management/presentation/values/colors.dart';
import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import '../values/fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  final titleList = ['Dashboard', 'All Customers', 'Add Customers', 'Profile'];
  final subTitleList = ['Customer Management System', 'Customers ', 'Add New Customers to System', 'Staff Account'];

  int customerCount = 5; // get from database

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  titleList[_selectedIndex],
                  style: TextStyle(
                      fontFamily: AppFonts.bold,
                      fontSize: 25,
                      color: Colors.white
                  ),
                ),
                Text(
                  _selectedIndex == 1
                      ? '${subTitleList[_selectedIndex]} ($customerCount)'
                      : subTitleList[_selectedIndex],
                  style: TextStyle(
                    fontFamily: AppFonts.regular,
                    fontSize: 12,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 16)
              ],
            ),
            if (_selectedIndex == 0)
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: CircleAvatar(
                  backgroundColor: Colors.white.withValues(alpha: 0.3),
                  foregroundColor: Colors.white,
                  radius: 24,
                  child: Icon(Iconsax.user_copy),
                ),
              )
          ],
        ),
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          DashboardScreen(
            onNavigateToCustomers: () {
              setState(() {
                _selectedIndex = 1;
              });
            },
            onNavigateToAddCustomer: () {
              setState(() {
                _selectedIndex = 2;
              });
            },
          ),
          CustomerScreen(),
          AddCustomerScreen(),
          ProfileScreen(),
        ],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: Offset(0, -2),
            ),
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildNavItem(0, Iconsax.home_1_copy, Iconsax.home, 'Dashboard'),
                _buildNavItem(1, Iconsax.profile_2user_copy, Iconsax.profile_2user, 'Customers'),
                _buildNavItem(2, Iconsax.add_copy, Iconsax.add, 'Add'),
                _buildNavItem(3, Iconsax.user_copy, Iconsax.user, 'Profile'),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(int index, IconData icon, IconData activeIcon, String label) {
    final isSelected = _selectedIndex == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedIndex = index;
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primaryColor.withValues(alpha: 0.1) : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isSelected ? activeIcon : icon,
              color: isSelected ? AppColors.primaryColor : Colors.grey,
              size: 24,
            ),
            SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontFamily: isSelected ? AppFonts.bold : AppFonts.regular,
                color: isSelected ? AppColors.primaryColor : Colors.grey,
                fontSize: 12,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}