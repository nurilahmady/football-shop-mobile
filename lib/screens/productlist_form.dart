import 'package:flutter/material.dart';
import 'package:football_shop/widgets/left_drawer.dart';
import 'dart:convert';
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:football_shop/screens/menu.dart';

class ProductFormPage extends StatefulWidget {
  const ProductFormPage({super.key});

  @override
  State<ProductFormPage> createState() => _ProductFormPageState();
}

class _ProductFormPageState extends State<ProductFormPage> {
  final _formKey = GlobalKey<FormState>();
  String _name = "";
  int _price = 0;
  String _description = "";
  String _thumbnail = "";
  String _category = "jersey";
  bool _isFeatured = false;
  int _stock = 0;
  String _brand = "";

  final List<String> _categories = [
    'jersey',
    'boots',
    'ball',
    'accessories',
    'merch',
  ];

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Add Product Form')),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      drawer: const LeftDrawer(),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF0B0B0F), Color(0xFF06060A)],
          ),
        ),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(12.0),
            child: Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: const Color(0xFF12121A),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.pinkAccent.withOpacity(0.3)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Add Product',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6.0),
                    child: TextFormField(
                      decoration: const InputDecoration(
                        hintText: "Ketik nama produkmu disini...",
                        labelText: "Nama Produk",
                      ),
                      onChanged: (String? value) {
                        setState(() {
                          _name = value!;
                        });
                      },
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return "Nama produk tidak boleh kosong!";
                        }
                        if (value.length < 3) {
                          return "Nama produk minimal 3 karakter!";
                        }
                        if (value.length > 50) {
                          return "Nama produk maksimal 50 karakter!";
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6.0),
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        hintText: "Ketik harga produkmu disini...",
                        labelText: "Harga Produk",
                      ),
                      onChanged: (String? value) {
                        setState(() {
                          _price = int.tryParse(value!) ?? 0;
                        });
                      },
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return "Harga tidak boleh kosong!";
                        }
                        final price = int.tryParse(value);
                        if (price == null) {
                          return "Masukkan angka yang valid!";
                        }
                        if (price <= 0) {
                          return "Harga harus lebih dari 0!";
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6.0),
                    child: TextFormField(
                      decoration: const InputDecoration(
                        hintText: "Ketik thumbnail produkmu disini...",
                        labelText: "URL Thumbnail (Optional)",
                      ),
                      onChanged: (String? value) {
                        setState(() {
                          _thumbnail = value!;
                        });
                      },
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return "Thumbnail URL tidak boleh kosong!";
                        }
                        if (value.isNotEmpty && !Uri.parse(value).isAbsolute) {
                          return "Masukkan URL yang valid!";
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6.0),
                    child: DropdownButtonFormField<String>(
                      decoration: const InputDecoration(
                        labelText: "Kategori",
                      ),
                      dropdownColor: const Color(0xFF1A1A22),
                      value: _category,
                      items: _categories
                          .map(
                            (cat) => DropdownMenuItem(
                              value: cat,
                              child: Text(cat[0].toUpperCase() + cat.substring(1)),
                            ),
                          )
                          .toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          _category = newValue!;
                        });
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6.0),
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        hintText: "Ketik jumlah stok produkmu...",
                        labelText: "Stok Produk",
                      ),
                      onChanged: (String? value) {
                        setState(() {
                          _stock = int.tryParse(value!) ?? 0;
                        });
                      },
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return "Stok tidak boleh kosong!";
                        }
                        final stock = int.tryParse(value);
                        if (stock == null) {
                          return "Masukkan angka yang valid!";
                        }
                        if (stock < 0) {
                          return "Stok tidak boleh negatif!";
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6.0),
                    child: TextFormField(
                      decoration: const InputDecoration(
                        hintText: "Ketik brand produkmu disini...",
                        labelText: "Merek Produk",
                      ),
                      onChanged: (String? value) {
                        setState(() {
                          _brand = value!;
                        });
                      },
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return "Merek tidak boleh kosong!";
                        }
                        if (value.length > 30) {
                          return "Merek maksimal berisi 30 karakter!";
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6.0),
                    child: TextFormField(
                      maxLines: 5,
                      decoration: const InputDecoration(
                        hintText: "Deskripsi Produk",
                        labelText: "Deskripsi Produk",
                      ),
                      onChanged: (String? value) {
                        setState(() {
                          _description = value!;
                        });
                      },
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return "Deskripsi tidak boleh kosong!";
                        }
                        if (value.length < 10) {
                          return "Deskripsi minimal berisi 10 karakter!";
                        }
                        if (value.length > 500) {
                          return "Deskripsi maksimal berisi 500 karakter!";
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6.0),
                    child: SwitchListTile(
                      title: const Text("Tandai sebagai Produk Unggulan"),
                      activeColor: Colors.pinkAccent,
                      value: _isFeatured,
                      onChanged: (bool value) {
                        setState(() {
                          _isFeatured = value;
                        });
                      },
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              final response = await request.postJson(
                                "http://localhost:8000/create-product-flutter/",
                                jsonEncode({
                                  "name": _name,
                                  "price": _price,
                                  "description": _description,
                                  "thumbnail": _thumbnail,
                                  "category": _category,
                                  "is_featured": _isFeatured,
                                  "stock": _stock,
                                  "brand": _brand,
                                }),
                              );
                              if (context.mounted) {
                                if (response['status'] == 'success') {
                                  await showDialog(
                                    context: context,
                                    builder: (ctx) => AlertDialog(
                                      backgroundColor: const Color(0xFF12121A),
                                      title: const Text(
                                        'Berhasil',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      content: Text(
                                        'Produk $_name berhasil disimpan!',
                                        style: const TextStyle(color: Colors.white70),
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () => Navigator.of(ctx).pop(),
                                          child: const Text('OK', style: TextStyle(color: Colors.pinkAccent)),
                                        ),
                                      ],
                                    ),
                                  );
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => MyHomePage(
                                              username: request.jsonData['username'] as String?,
                                            )),
                                  );
                                } else {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(const SnackBar(
                                    content: Text("Something went wrong, please try again."),
                                  ));
                                }
                              }
                            }
                          },
                          child: const Text(
                            "Save",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
