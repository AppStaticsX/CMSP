import 'package:customer_management/presentation/values/colors.dart';
import 'package:customer_management/presentation/widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';


import '../values/fonts.dart';
import '../widgets/custom_text_field.dart';

class AddCustomerScreen extends StatefulWidget {
  const AddCustomerScreen({super.key});

  @override
  State<AddCustomerScreen> createState() => _AddCustomerScreenState();
}

class _AddCustomerScreenState extends State<AddCustomerScreen> {
  final _formKey = GlobalKey<FormState>();
  final _customerNameController = TextEditingController();
  final _addressController = TextEditingController();
  final _mobileNumberController = TextEditingController();
  final _monthlyPaymentDateController = TextEditingController();
  final _agreementDeadlineController = TextEditingController();

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
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: Color(0xFF00BFA5),
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

      if(_addressController.text.isEmpty) {
        _addressTypeError = 'Please enter customer address';
        isValid = false;
      } else {
        _addressTypeError = null;
      }

      // Validate mobile number
      if (_mobileNumberController.text.isEmpty) {
        _mobileNumberError = 'Please enter mobile number';
        isValid = false;
      } else if (!RegExp(r'^\+?[0-9]{10,15}$').hasMatch(_mobileNumberController.text)) {
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
      // Process the form data
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Customer added successfully!'),
          backgroundColor: AppColors.primaryColor,
          behavior: SnackBarBehavior.floating,
        ),
      );
      // Clear form
      _customerNameController.clear();
      _addressController.clear();
      _mobileNumberController.clear();
      _monthlyPaymentDateController.clear();
      _agreementDeadlineController.clear();
      setState(() {
        _selectedProductType = null;
        _customerNameError = null;
        _mobileNumberError = null;
        _productTypeError = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Customer Name
            _textFieldTitle('Customer Name'),
            SizedBox(height: 8),
            CustomTextField(
              controller: _customerNameController,
              labelText: 'Customer Name *',
              hintText: 'Enter customer name',
              errorText: _customerNameError,
            ),

            SizedBox(height: 20),

            // Product Type Dropdown
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _textFieldTitle('Product Type'),
                SizedBox(height: 8),
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
                      borderSide: BorderSide(color: Theme.of(context).primaryColor),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: Colors.red, width: 1.5),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: Colors.red, width: 2),
                    ),
                    contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  ),
                  items: _productTypes.map((String type) {
                    return DropdownMenuItem<String>(
                      value: type,
                      child: Text(
                        type,
                        style: TextStyle(
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

            SizedBox(height: 20),

            // Address
            _textFieldTitle('Customer Address'),
            SizedBox(height: 8),
            CustomTextField(
              controller: _addressController,
              labelText: 'Address',
              hintText: 'Enter customer address',
              maxLines: 3,
              errorText: _addressTypeError,
            ),

            SizedBox(height: 20),

            // Mobile Number
            _textFieldTitle('Mobile Number'),
            SizedBox(height: 8),
            CustomTextField(
              controller: _mobileNumberController,
              labelText: 'Mobile Number *',
              hintText: 'Enter mobile number',
              keyboardType: TextInputType.phone,
              errorText: _mobileNumberError,
            ),

            SizedBox(height: 20),

            // Monthly Payment Date
            _textFieldTitle('Monthly Payment Date'),
            SizedBox(height: 8),
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

            SizedBox(height: 20),

            // Agreement Deadline
            _textFieldTitle('Agreement Deadline'),
            SizedBox(height: 8),
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

            SizedBox(height: 32),

            CustomElevatedButton(
                text: 'Add Customer',
                width: MediaQuery.of(context).size.width,
                backgroundColor: AppColors.primaryColor,
                icon: Iconsax.add_copy,
                fontFamily: AppFonts.bold,
                fontSize: 16,
                iconSize: 32,
                onPressed: () {
                  // logic here
                  _validateForm();
                },
            )
          ],
        ),
      ),
    );
  }
  
  Widget _textFieldTitle (String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 14,
        fontFamily: AppFonts.bold,
        color: Colors.black87,
      ),
    );
  }
}