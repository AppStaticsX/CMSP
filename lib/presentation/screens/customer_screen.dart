import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:intl/intl.dart';

import '../models/customer_model.dart';
import '../pages/customer_detail_page.dart';
import '../values/colors.dart';
import '../values/fonts.dart';

class CustomerScreen extends StatefulWidget {
  const CustomerScreen({super.key});

  @override
  State<CustomerScreen> createState() => _CustomerScreenState();
}

class _CustomerScreenState extends State<CustomerScreen> {
  List<CustomerModel> _customers = [];
  bool _isLoading = true;
  String? _errorMessage;

  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _loadCustomers();
  }

  Future<void> _loadCustomers() async {
    try {
      setState(() {
        _isLoading = true;
        _errorMessage = null;
      });

      // TODO: Replace this with your actual database call
      // Example: final customers = await DatabaseService().getCustomers();
      final customers = await _fetchCustomersFromDatabase();

      setState(() {
        _customers = customers;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'Failed to load customers: ${e.toString()}';
        _isLoading = false;
      });
    }
  }

  // TODO: Replace this mock method with your actual database service
  Future<List<CustomerModel>> _fetchCustomersFromDatabase() async {
    // Simulate network/database delay
    await Future.delayed(const Duration(seconds: 1));

    // Mock data - replace with actual database call
    // Example implementations:
    // - Firebase: FirebaseFirestore.instance.collection('customers').get()
    // - SQLite: database.query('customers')
    // - REST API: http.get('your-api/customers')

    return [
      CustomerModel(
        name: 'John Smith',
        productType: 'Electronics',
        phoneNumber: '+1 555-0123',
        address: '742 Maple Grove Avenue, Springfield, IL 62704, USA',
        paymentDate: DateTime(2024, 1, 15),
        deadlineDate: DateTime(2025, 1, 15),
      ),
      CustomerModel(
        name: 'Sarah Johnson',
        productType: 'Furniture',
        phoneNumber: '+1 555-0456',
        address: '158 Oakwood Terrace, Manchester, M14 5JQ, United Kingdom',
        paymentDate: DateTime(2024, 2, 10),
        deadlineDate: DateTime(2025, 2, 10),
      ),
      CustomerModel(
        name: 'Michael Brown',
        productType: 'Appliances',
        phoneNumber: '+1 555-0789',
        address: '23 Riverside Drive, Apartment 6B, Melbourne, VIC 3000, Australia',
        paymentDate: DateTime(2024, 3, 5),
        deadlineDate: DateTime(2024, 12, 30),
      ),
      CustomerModel(
        name: 'Emma Davis',
        productType: 'Automotive',
        phoneNumber: '+1 555-0321',
        address: '891 Pine Street, Unit 12, Vancouver, BC V6B 2K9, Canada',
        paymentDate: DateTime(2024, 1, 20),
        deadlineDate: DateTime(2025, 1, 20),
      ),
    ];
  }

  void _showCustomerDetails(CustomerModel customer, int index) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CustomerDetailPage(
          customer: customer,
          customerId: index + 1,
          onDelete: () {
            // TODO: Implement actual delete logic
            _loadCustomers();
          },
          onEdit: () {
            // TODO: Implement actual edit logic
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          _buildBody(),
        ],
      ),
    );
  }

  Widget _buildBody() {
    if (_isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (_errorMessage != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Iconsax.danger_copy,
              size: 64,
              color: Colors.red[300],
            ),
            const SizedBox(height: 16),
            Text(
              _errorMessage!,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[700],
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: _loadCustomers,
              icon: const Icon(Iconsax.refresh_copy),
              label: const Text('Retry'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryColor,
                foregroundColor: Colors.white,
              ),
            ),
          ],
        ),
      );
    }

    if (_customers.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Iconsax.profile_2user_copy,
              size: 64,
              color: Colors.grey[400],
            ),
            const SizedBox(height: 16),
            Text(
              'No customers found',
              style: TextStyle(
                fontSize: 18,
                fontFamily: AppFonts.regular,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: _loadCustomers,
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _customers.length,
        itemBuilder: (context, index) {
          return CustomerCard(
            customer: _customers[index],
            onTap: () => _showCustomerDetails(_customers[index], index),
          );
        },
      ),
    );
  }
}

class CustomerCard extends StatelessWidget {
  final CustomerModel customer;
  final VoidCallback onTap;

  const CustomerCard({
    super.key,
    required this.customer,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('dd-MM-yyyy');

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Name
            Text(
              customer.name,
              style: const TextStyle(
                fontSize: 18,
                fontFamily: AppFonts.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 12),

            // Product Type
            _buildInfoRow(
              icon: Iconsax.bag_tick_copy,
              text: customer.productType,
            ),
            const SizedBox(height: 8),

            // Phone Number
            _buildInfoRow(
              icon: Icons.phone_outlined,
              text: customer.phoneNumber,
            ),
            const SizedBox(height: 8),

            // Payment Date
            _buildInfoRow(
              icon: Iconsax.calendar_2_copy,
              text: 'Payment: ${dateFormat.format(customer.paymentDate)}',
            ),
            const SizedBox(height: 8),

            // Deadline Date
            _buildInfoRow(
              icon: Iconsax.calendar_copy,
              text: 'Deadline: ${dateFormat.format(customer.deadlineDate)}',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow({required IconData icon, required String text}) {
    return Row(
      children: [
        Icon(
          icon,
          size: 20,
          color: Colors.grey[600],
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 14,
              fontFamily: AppFonts.regular,
              color: Colors.grey[700],
            ),
          ),
        ),
      ],
    );
  }
}

