import 'package:flutter/material.dart';

void main() {
  runApp(TransactionApp());
}

class TransactionApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Toko Komputer',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TransactionScreen(),
    );
  }
}

class TransactionScreen extends StatefulWidget {
  @override
  _TransactionScreenState createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  final List<Map<String, dynamic>> items = [
    {'name': 'Laptop', 'price': 10000000, 'Qty': TextEditingController()},
    {'name': 'Mouse', 'price': 50000, 'Qty': TextEditingController()},
    {'name': 'Keyboard', 'price': 150000, 'Qty': TextEditingController()},
    {'name': 'Monitor', 'price': 2000000, 'Qty': TextEditingController()},
  ];

  double total = 0.0;
  List<String> strukItems = [];

  void reset() {
    setState(() {
      for (var item in items) {
        item['Qty'].clear();
      }
      total = 0.0;
      strukItems.clear();
    });
  }

  void cetakStruk() {
    setState(() {
      total = 0.0;
      strukItems.clear();

      for (var item in items) {
        int quantity = int.tryParse(item['Qty'].text) ?? 0;
        if (quantity > 0) {
          num subtotal = quantity * item['price'];
          strukItems.add('${item['name']} x $quantity = Rp $subtotal');
          total += subtotal;
        }
      }
    });
  }

  @override
  void dispose() {
    for (var item in items) {
      item['Qty'].dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Toko Komputer'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  final item = items[index];
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 4.0),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            flex: 2,
                            child: Text(
                              item['name'],
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Text(
                              'Rp ${item['price']}',
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: TextField(
                              controller: item['Qty'],
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                labelText: '',
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: reset,
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        Colors.amber.shade600, // Warna kuning untuk Reset
                  ),
                  child: Text('Reset', style: TextStyle(color: Colors.black)),
                ),
                ElevatedButton(
                  onPressed: cetakStruk,
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        Colors.blue.shade500, // Warna biru untuk Cetak Struk
                  ),
                  child: Text('Cetak Struk',
                      style: TextStyle(color: Colors.black)),
                ),
              ],
            ),
            SizedBox(height: 20),
            Text(
              'Struk Pembelian:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: strukItems.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Icon(Icons.shopping_cart),
                    title: Text(strukItems[index]),
                  );
                },
              ),
            ),
            Container(
              width: double.infinity,
              color: Colors.blue,
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Total Bayar: Rp $total',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
