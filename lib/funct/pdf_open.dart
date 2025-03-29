import 'dart:io';
import 'package:kinder_app/funct/pdf_generate.dart';
import 'package:open_file/open_file.dart';

void openBillPdf(Map<String, dynamic> billData) async {
  File pdfFile = await generateBillPdf(billData);

  // Open the generated PDF file
  OpenFile.open(pdfFile.path);
}
