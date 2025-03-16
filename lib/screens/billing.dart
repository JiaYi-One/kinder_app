import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:kinder_app/firestore_service/bill_data.dart';
import 'package:kinder_app/funct/pdf_generate.dart';
import 'package:kinder_app/funct/pdf_open.dart';

class BillingScreen extends StatefulWidget {
  const BillingScreen({super.key});

  @override
  State<BillingScreen> createState() => _BillingScreenState();
}

class _BillingScreenState extends State<BillingScreen> {
  final FirebaseService _firebaseService = FirebaseService();
  String? parentId;
  List<Map<String, dynamic>> bills = [];

  @override
  void initState() {
    super.initState();
    fetchParentIdAndBills();
  }

  Future<void> fetchParentIdAndBills() async {
    parentId = await _firebaseService.getParentId();
    if (parentId != null) {
      List<Map<String, dynamic>> fetchedBills = await _firebaseService
          .getParentBills(parentId!);
      setState(() {
        bills = fetchedBills;
      });
    } else {
      log("No parent ID found.");
      setState(() {
        bills = [];
      });
    }
  }

  void handlePayment(String billId) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Proceeding with payment for Bill: $billId')),
    );
  }

  void downloadBill(Map<String, dynamic> bill) async {
    File pdfFile = await generateBillPdf(bill);

    if (mounted) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Bill saved at: ${pdfFile.path}")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Billing'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Billing Summary',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Expanded(
              child:
                  bills.isEmpty
                      ? const Center(child: Text('No bills found'))
                      : ListView.builder(
                        itemCount: bills.length,
                        itemBuilder: (context, index) {
                          var bill = bills[index];
                          return _buildInvoiceItem(
                            bill['billNumber'],
                            bill['billDate'],
                            '\$${bill['totalAmount']}',
                            bill['status'],
                            bill['status'] == 'paid'
                                ? Colors.green
                                : Colors.orange,
                            bill['status'] != 'paid'
                                ? () => handlePayment(bill['billNumber'])
                                : null,
                            bill,
                          );
                        },
                      ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInvoiceItem(
    String invoiceId,
    String period,
    String amount,
    String status,
    Color statusColor,
    VoidCallback? onPayNow,
    Map<String, dynamic> billData, // Add bill data parameter
  ) {
    return InkWell(
      onTap: () => openBillPdf(billData), // Handle tap to open PDF
      borderRadius: BorderRadius.circular(12),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.blue.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.receipt, size: 24, color: Colors.blue),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    invoiceId,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Billing period: $period',
                    style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  amount,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 4),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: statusColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text(
                    status,
                    style: TextStyle(
                      color: statusColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
                if (onPayNow != null) ...[
                  const SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: onPayNow,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text('Pay Now'),
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }
}
