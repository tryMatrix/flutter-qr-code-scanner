import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

void main() {
  runApp(const QRLoginApp());
}

class QRLoginApp extends StatelessWidget {
  const QRLoginApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'QR Login App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const QRScannerPage(),
    );
  }
}

class QRScannerPage extends StatefulWidget {
  const QRScannerPage({super.key});

  @override
  State<QRScannerPage> createState() => _QRScannerPageState();
}

class _QRScannerPageState extends State<QRScannerPage> {
  bool _isScanned = false;

  void _onDetect(BarcodeCapture barcode) {
    if (_isScanned) return;

    final String? code = barcode.barcodes.first.rawValue;
    if (code != null) {
      setState(() {
        _isScanned = true;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Scanned: $code')),
      );

      // Simulate login success/failure
      Future.delayed(const Duration(seconds: 3), () {
        setState(() {
          _isScanned = false;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Scan QR Code')),
      body: MobileScanner(
        onDetect: _onDetect,
      ),
    );
  }
}
