import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import '../values/colors.dart';
import '../values/fonts.dart';

class DashboardScreen extends StatelessWidget {
  final VoidCallback? onNavigateToCustomers;
  final VoidCallback? onNavigateToAddCustomer;

  const DashboardScreen({
    super.key,
    this.onNavigateToCustomers,
    this.onNavigateToAddCustomer,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top Row: Total Customers and Add New Customer
              Row(
                children: [
                  Expanded(
                    child: _buildTotalCustomersCard(),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Bottom Row: Bonus Pending and Partnership Ending Soon
              Row(
                children: [
                  Expanded(
                    child: _buildBonusPendingCard(),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildPartnershipEndingCard(),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Quick Actions Section
              _buildQuickActionsSection(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTotalCustomersCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFE0E7FF),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(13),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color(0xFF6366F1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(
              Iconsax.people,
              color: Colors.white,
              size: 24,
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Total Customers',
            style: TextStyle(
              fontFamily: AppFonts.semiBold,
              fontSize: 14,
              color: Color(0xFF6366F1),
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            '5',
            style: TextStyle(
              fontFamily: AppFonts.bold,
              fontSize: 32,
              color: Color(0xFF6366F1),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBonusPendingCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFFEF3C7),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(13),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color(0xFFF59E0B),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(
              Iconsax.gift,
              color: Colors.white,
              size: 24,
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Bonus Pending',
            style: TextStyle(
              fontFamily: AppFonts.semiBold,
              fontSize: 14,
              color: Color(0xFFF59E0B),
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            '1',
            style: TextStyle(
              fontFamily: AppFonts.bold,
              fontSize: 32,
              color: Color(0xFFF59E0B),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPartnershipEndingCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFFCE7F3),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(13),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color(0xFFEC4899),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(
              Iconsax.calendar_1,
              color: Colors.white,
              size: 24,
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Partnership Ending Soon',
            style: TextStyle(
              fontFamily: AppFonts.semiBold,
              fontSize: 14,
              color: Color(0xFFEC4899),
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            '1',
            style: TextStyle(
              fontFamily: AppFonts.bold,
              fontSize: 32,
              color: Color(0xFFEC4899),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActionsSection(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(13),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Quick Actions',
            style: TextStyle(
              fontFamily: AppFonts.bold,
              fontSize: 16,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 16),
          _buildQuickActionButton(
            label: 'View All Customers',
            backgroundColor: const Color(0xFFF3F4F6),
            textColor: Colors.black87,
            onTap: () {
              onNavigateToCustomers?.call();
            },
          ),
          const SizedBox(height: 12),
          _buildQuickActionButton(
            label: 'Add New Customer',
            backgroundColor: const Color(0xFFD1FAE5),
            textColor: AppColors.primaryColor,
            onTap: () {
              onNavigateToAddCustomer?.call();
            },
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActionButton({
    required String label,
    required Color backgroundColor,
    required Color textColor,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontFamily: AppFonts.semiBold,
            fontSize: 14,
            color: textColor,
          ),
        ),
      ),
    );
  }
}