import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:intl/intl.dart';

import '../models/customer_model.dart';
import '../values/colors.dart';
import '../values/fonts.dart';
import '../widgets/custom_elevated_button.dart';
import '../widgets/custom_text_field.dart';

class EditCustomerScreen extends StatefulWidget {
  final CustomerModel customer;
  final int customerId;
  final VoidCallback? onUpdate;

  const EditCustomerScreen({
    super.key,
    required this.customer,
    required this.customerId,
    this.onUpdate,
  });

  @override
  State<EditCustomerScreen> createState() => _EditCustomerScreenState();
}

class _EditCustomerScreenState extends State<EditCustomerScreen> {
  late final TextEditingController _customerNameController;
  late final TextEditingController _addressController;
  late final TextEditingController _mobileNumberController;
  late final TextEditingController _monthlyPaymentDateController;
  late final TextEditingController _agreementDeadlineController;

  String? _selectedProductType;
  String? _customerNameError;
  String? _mobileNumberError;
  String? _productTypeError;
  String? _addressTypeError;

  final List<String> _productTypes = [
    'Electronics',
    'Furniture',
    'Appliances',
    'Automotive',
    'Other'
  ];

  @override
  void initState() {
    super.initState();
    // Initialize controllers with existing customer data
    _customerNameController = TextEditingController(text: widget.customer.name);
    _addressController = TextEditingController(text: widget.customer.address);
    _mobileNumberController = TextEditingController(text: widget.customer.phoneNumber);

    final dateFormat = DateFormat('MM/dd/yyyy');
    _monthlyPaymentDateController = TextEditingController(
      text: dateFormat.format(widget.customer.paymentDate),
    );
    _agreementDeadlineController = TextEditingController(
      text: dateFormat.format(widget.customer.deadlineDate),
    );

    _selectedProductType = widget.customer.productType;
  }

  @override
  void dispose() {
    _customerNameController.dispose();
    _addressController.dispose();
    _mobileNumberController.dispose();
    _monthlyPaymentDateController.dispose();
    _agreementDeadlineController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(
      BuildContext context, TextEditingController controller) async {
    // Parse existing date if available
    DateTime initialDate = DateTime.now();
    if (controller.text.isNotEmpty) {
      try {
        final parts = controller.text.split('/');
        if (parts.length == 3) {
          initialDate = DateTime(
            int.parse(parts[2]),
            int.parse(parts[0]),
            int.parse(parts[1]),
          );
        }
      } catch (e) {
        initialDate = DateTime.now();
      }
    }

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: AppColors.primaryColor,
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() {
        controller.text =
            "${picked.month.toString().padLeft(2, '0')}/${picked.day.toString().padLeft(2, '0')}/${picked.year}";
      });
    }
  }

  bool _validateForm() {
    bool isValid = true;

    setState(() {
      // Validate customer name
      if (_customerNameController.text.isEmpty) {
        _customerNameError = 'Please enter customer name';
        isValid = false;
      } else if (_customerNameController.text.length < 3) {
        _customerNameError = 'Name must be at least 3 characters';
        isValid = false;
      } else {
        _customerNameError = null;
      }

      // Validate product type
      if (_selectedProductType == null || _selectedProductType!.isEmpty) {
        _productTypeError = 'Please select a product type';
        isValid = false;
      } else {
        _productTypeError = null;
      }

      if (_addressController.text.isEmpty) {
        _addressTypeError = 'Please enter customer address';
        isValid = false;
      } else {
        _addressTypeError = null;
      }

      // Validate mobile number
      if (_mobileNumberController.text.isEmpty) {
        _mobileNumberError = 'Please enter mobile number';
        isValid = false;
      } else if (!RegExp(r'^\+?[0-9]{10,15}$')
          .hasMatch(_mobileNumberController.text)) {
        _mobileNumberError = 'Please enter a valid mobile number';
        isValid = false;
      } else {
        _mobileNumberError = null;
      }
    });

    return isValid;
  }

  void _submitForm() {
    if (_validateForm()) {
      // TODO: Process the form data and update customer in database
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Customer updated successfully!'),
          backgroundColor: AppColors.primaryColor,
          behavior: SnackBarBehavior.floating,
        ),
      );

      // Call the update callback
      if (widget.onUpdate != null) {
        widget.onUpdate!();
      }

      // Go back to the previous screen
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
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
          'Edit Customer',
          style: TextStyle(
            color: Colors.white,
            fontFamily: AppFonts.semiBold,
            fontSize: 18,
          ),
        ),
        centerTitle: false,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Customer ID Display
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.primaryColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Icon(
                      Iconsax.user_copy,
                      color: AppColors.primaryColor,
                    ),
                    const SizedBox(width: 12),
                    Text(
                      'Customer ID: ${widget.customerId}',
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: AppFonts.semiBold,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ),
        
              const SizedBox(height: 24),
        
              // Customer Name
              _textFieldTitle('Customer Name'),
              const SizedBox(height: 8),
              CustomTextField(
                controller: _customerNameController,
                labelText: 'Customer Name *',
                hintText: 'Enter customer name',
                errorText: _customerNameError,
              ),
        
              const SizedBox(height: 20),
        
              // Product Type Dropdown
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _textFieldTitle('Product Type'),
                  const SizedBox(height: 8),
                  DropdownButtonFormField<String>(
                    initialValue: _selectedProductType,
                    hint: Text(
                      'Select product type',
                      style: TextStyle(
                        color: Colors.grey[400],
                        fontFamily: AppFonts.regular,
                      ),
                    ),
                    decoration: InputDecoration(
                      errorText: _productTypeError,
                      errorStyle: const TextStyle(
                        fontSize: 12,
                        fontFamily: AppFonts.regular,
                        height: 0.8,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: Colors.grey.shade300),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: AppColors.primaryColor),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(color: Colors.red, width: 1.5),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(color: Colors.red, width: 2),
                      ),
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                    ),
                    items: _productTypes.map((String type) {
                      return DropdownMenuItem<String>(
                        value: type,
                        child: Text(
                          type,
                          style: const TextStyle(
                            fontFamily: AppFonts.regular,
                          ),
                        ),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedProductType = newValue;
                        _productTypeError = null;
                      });
                    },
                  ),
                ],
              ),
        
              const SizedBox(height: 20),
        
              // Address
              _textFieldTitle('Customer Address'),
              const SizedBox(height: 8),
              CustomTextField(
                controller: _addressController,
                labelText: 'Address',
                hintText: 'Enter customer address',
                maxLines: 3,
                errorText: _addressTypeError,
              ),
        
              const SizedBox(height: 20),
        
              // Mobile Number
              _textFieldTitle('Mobile Number'),
              const SizedBox(height: 8),
              CustomTextField(
                controller: _mobileNumberController,
                labelText: 'Mobile Number *',
                hintText: 'Enter mobile number',
                keyboardType: TextInputType.phone,
                errorText: _mobileNumberError,
              ),
        
              const SizedBox(height: 20),
        
              // Monthly Payment Date
              _textFieldTitle('Monthly Payment Date'),
              const SizedBox(height: 8),
              GestureDetector(
                onTap: () => _selectDate(context, _monthlyPaymentDateController),
                child: AbsorbPointer(
                  child: CustomTextField(
                    controller: _monthlyPaymentDateController,
                    labelText: 'Monthly Payment Date',
                    hintText: 'mm/dd/yyyy',
                    prefixIcon: Icon(Iconsax.calendar_1, color: Colors.grey[600]),
                  ),
                ),
              ),
        
              const SizedBox(height: 20),
        
              // Agreement Deadline
              _textFieldTitle('Agreement Deadline'),
              const SizedBox(height: 8),
              GestureDetector(
                onTap: () => _selectDate(context, _agreementDeadlineController),
                child: AbsorbPointer(
                  child: CustomTextField(
                    controller: _agreementDeadlineController,
                    labelText: 'Agreement Deadline',
                    hintText: 'mm/dd/yyyy',
                    prefixIcon: Icon(Iconsax.calendar_1, color: Colors.grey[600]),
                  ),
                ),
              ),
        
              const SizedBox(height: 32),
        
              CustomElevatedButton(
                text: 'Update Customer',
                width: MediaQuery.of(context).size.width,
                backgroundColor: AppColors.primaryColor,
                icon: Icons.save,
                fontFamily: AppFonts.bold,
                fontSize: 16,
                iconSize: 24,
                iconPadding: EdgeInsets.symmetric(vertical: 3),
                onPressed: _submitForm,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _textFieldTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 14,
        fontFamily: AppFonts.bold,
        color: Colors.black87,
      ),
    );
  }
}

