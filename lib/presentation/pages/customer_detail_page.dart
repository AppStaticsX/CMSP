import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:intl/intl.dart';

import '../models/customer_model.dart';
import '../screens/edit_customer_screen.dart';
import '../values/colors.dart';
import '../values/fonts.dart';

class CustomerDetailPage extends StatelessWidget {
  final CustomerModel customer;
  final int customerId;
  final VoidCallback? onDelete;
  final VoidCallback? onEdit;

  const CustomerDetailPage({
    super.key,
    required this.customer,
    required this.customerId,
    this.onDelete,
    this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('yyyy-MM-dd');

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Customer Details',
          style: TextStyle(
            color: Colors.white,
            fontFamily: AppFonts.semiBold,
            fontSize: 18,
          ),
        ),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header Section
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: AppColors.primaryColor.withValues(alpha: 0.1),
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      customer.name,
                      style: const TextStyle(
                        fontSize: 24,
                        fontFamily: AppFonts.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Customer ID: $customerId',
                      style: TextStyle(
                        fontSize: 14,
                        fontFamily: AppFonts.regular,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Details Card
            Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withValues(alpha: 0.1),
                    spreadRadius: 1,
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                children: [
                  _buildDetailItem(
                    icon: Iconsax.bag_tick_copy,
                    iconColor: Colors.blue,
                    iconBgColor: Colors.blue.withValues(alpha: 0.1),
                    label: 'Product Type',
                    value: customer.productType,
                  ),
                  const SizedBox(height: 20),
                  _buildDetailItem(
                    icon: Icons.phone_outlined,
                    iconColor: Colors.green,
                    iconBgColor: Colors.green.withValues(alpha: 0.1),
                    label: 'Mobile Number',
                    value: customer.phoneNumber,
                  ),
                  const SizedBox(height: 20),
                  _buildDetailItem(
                    icon: Iconsax.location_copy,
                    iconColor: Colors.purple,
                    iconBgColor: Colors.purple.withValues(alpha: 0.1),
                    label: 'Address',
                    value: customer.address,
                  ),
                  const SizedBox(height: 20),
                  _buildDetailItem(
                    icon: Iconsax.calendar_2_copy,
                    iconColor: Colors.orange,
                    iconBgColor: Colors.orange.withValues(alpha: 0.1),
                    label: 'Payment Date',
                    value: dateFormat.format(customer.paymentDate),
                  ),
                  const SizedBox(height: 20),
                  _buildDetailItem(
                    icon: Iconsax.calendar_copy,
                    iconColor: Colors.pink,
                    iconBgColor: Colors.pink.withValues(alpha: 0.1),
                    label: 'Agreement Deadline',
                    value: dateFormat.format(customer.deadlineDate),
                  ),
                ],
              ),
            ),

            // Action Buttons
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        _showEditDialog(context);
                      },
                      icon: const Icon(Iconsax.edit_copy),
                      label: const Text(
                        'Edit Customer',
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: AppFonts.semiBold,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryColor,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: OutlinedButton.icon(
                      onPressed: () {
                        _showDeleteDialog(context);
                      },
                      icon: const Icon(Iconsax.trash_copy),
                      label: const Text(
                        'Delete Customer',
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: AppFonts.semiBold,
                        ),
                      ),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.red,
                        side: const BorderSide(color: Colors.red, width: 1.5),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailItem({
    required IconData icon,
    required Color iconColor,
    required Color iconBgColor,
    required String label,
    required String value,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: iconBgColor,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            icon,
            color: iconColor,
            size: 24,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  fontFamily: AppFonts.regular,
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 16,
                  fontFamily: AppFonts.regular,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _showEditDialog(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditCustomerScreen(
          customer: customer,
          customerId: customerId,
          onUpdate: () {
            // Call the onEdit callback if provided
            if (onEdit != null) {
              onEdit!();
            }
          },
        ),
      ),
    );
  }

  void _showDeleteDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Customer'),
        content: const Text('Are you sure you want to delete this customer?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Close dialog
              Navigator.pop(context); // Close detail page
              if (onDelete != null) onDelete!(); // Call delete callback
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}

