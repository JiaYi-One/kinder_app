import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;

Future<File> generateBillPdf(Map<String, dynamic> billData) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build:
            (pw.Context context) => pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text(
                  "Invoice",
                  style: pw.TextStyle(
                    fontSize: 24,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
                pw.SizedBox(height: 10),
                pw.Text("Bill Number: ${billData['billNumber']}"),
                pw.Text("Bill Date: ${billData['billDate']}"),
                pw.Text("Status: ${billData['status']}"),
                pw.SizedBox(height: 20),
                pw.Text(
                  "Items:",
                  style: pw.TextStyle(
                    fontSize: 18,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
                pw.SizedBox(height: 10),
                pw.Column(
                  children:
                      (billData['items'] as List<dynamic>).map((item) {
                        return pw.Text(
                          "${item['description']}: \$${item['amount']}",
                        );
                      }).toList(),
                ),
                pw.SizedBox(height: 20),
                pw.Text(
                  "Total Amount: \$${billData['totalAmount']}",
                  style: pw.TextStyle(
                    fontSize: 18,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
              ],
            ),
      ),
    );

    final output = await getApplicationDocumentsDirectory();
    final file = File("${output.path}/bill_${billData['billNumber']}.pdf");
    await file.writeAsBytes(await pdf.save());

    return file;
  }