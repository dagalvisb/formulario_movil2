import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Formulario',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: const FormPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class FormPage extends StatefulWidget {
  const FormPage({super.key});

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _apellidosController = TextEditingController();
  final TextEditingController _correoController = TextEditingController();
  final TextEditingController _ciudadController = TextEditingController();

  void _ingresarDatos() {
    if (_formKey.currentState!.validate()) {
      String nombre = _nombreController.text;
      String apellidos = _apellidosController.text;
      String correo = _correoController.text;
      String ciudad = _ciudadController.text;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.grey,
          content: Text(
            '✅ Datos ingresados:\nNombre: $nombre\nApellidos: $apellidos\nCiudad: $ciudad\nCorreo: $correo',
            style: const TextStyle(color: Colors.white),
          ),
        ),
      );
      setState(() {
        _nombreController.clear();
        _apellidosController.clear();
        _correoController.clear();
        _ciudadController.clear();});
    }
  }

  InputDecoration _inputDecoration(String label, IconData icon) {
    return InputDecoration(
      labelText: label,
      prefixIcon: Icon(icon, color: Colors.blueGrey),
      filled: true,
      fillColor: Colors.blueGrey.shade50,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: BorderSide.none,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade100,
      appBar: AppBar(
        title: const Text("Formulario de Registro", style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: Colors.black
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Card(
            elevation: 8,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            margin: const EdgeInsets.all(20),
            child: Padding(
              padding: const EdgeInsets.all(25.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Ingresa tus datos",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueGrey.shade700,
                      ),
                    ),
                    const SizedBox(height: 15),
                    TextFormField(
                      controller: _nombreController,
                      decoration: _inputDecoration("Nombre", Icons.person),
                      validator: (value) =>
                          value == null || value.isEmpty ? 'Ingrese un nombre' : null,
                    ),
                    const SizedBox(height: 15),
                    TextFormField(
                      controller: _apellidosController,
                      decoration: _inputDecoration("Apellidos", Icons.people),
                      validator: (value) =>
                          value == null || value.isEmpty ? 'Ingrese los apellidos' : null,
                    ),
                    const SizedBox(height: 15),
                    TextFormField(
                      controller: _ciudadController,
                      decoration: _inputDecoration("Ciudad", Icons.location_city),
                      validator: (value) =>
                          value == null || value.isEmpty ? 'Ingrese la ciudad' : null,
                    ),
                    const SizedBox(height: 15),
                    TextFormField(
                      controller: _correoController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: _inputDecoration("Correo", Icons.email),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Ingrese un correo';
                        } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                          return 'Ingrese un correo válido';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 25),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blueGrey,
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        onPressed: _ingresarDatos,
                        icon: const Icon(Icons.save, color: Colors.white),
                        label: const Text(
                          "Ingresar",
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
