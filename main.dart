import 'package:flutter/cupertino.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static const String routeLogin         = "/";
  static const String routeHome          = "/home";
  static const String routeDetalle       = "/detalle";
  static const String routeConfiguracion = "/configuracion";
  static const String routeFAQs          = "/faqs";
  static const String routeRegistro      = "/registro";
  static const String routeCalculadora   = "/calculadora";

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      debugShowCheckedModeBanner: false,
      title: 'Mi Aplicación',
      // He eliminado el textTheme personalizado para evitar errores de interpolación
      // theme: CupertinoThemeData(
      //   primaryColor: CupertinoColors.systemBlue,
      // ),
      initialRoute: routeLogin,
      routes: {
        routeLogin:        (context) => const LoginPage(),
        routeHome:         (context) => const HomePage(),
        routeDetalle:      (context) => const DetallePage(),
        routeConfiguracion:(context) => const ConfiguracionPage(),
        routeFAQs:         (context) => const FAQsPage(),
        routeRegistro:     (context) => const RegistroPage(),
        routeCalculadora:  (context) => const CalculadoraPage(),
      },
    );
  }
}

// ---------------------------------
// LOGIN CON CUpertino (texto oscuro)
// ---------------------------------
class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final TextEditingController _userController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  bool _isPasswordVisible = false;

  final String correctUser = "Ismael";
  final String correctPass = "Quispe";

  void _showErrorDialog() {
    showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: const Text('Error de inicio de sesión'),
        content: const Text('Usuario o contraseña incorrectos.\nPor favor, inténtalo de nuevo.'),
        actions: [
          CupertinoDialogAction(
            isDefaultAction: true,
            child: const Text('ACEPTAR'),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  void _login() {
    if (_userController.text == correctUser &&
        _passController.text == correctPass) {
      Navigator.pushNamedAndRemoveUntil(
        context,
        MyApp.routeHome,
        (_) => false,
      );
    } else {
      _showErrorDialog();
    }
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Iniciar sesión'),
      ),
      child: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 40),
              const Icon(
                CupertinoIcons.person_circle,
                size: 80,
                color: CupertinoColors.activeBlue,
              ),
              const SizedBox(height: 32),
              const Text(
                'Bienvenido de nuevo',
                style: TextStyle(fontSize: 18, color: CupertinoColors.systemGrey),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              // Campo Usuario: texto negro forzado
              CupertinoTextField(
                controller: _userController,
                placeholder: 'Usuario',
                style: const TextStyle(color: CupertinoColors.black),
                placeholderStyle: const TextStyle(color: CupertinoColors.systemGrey2),
                prefix: const Padding(
                  padding: EdgeInsets.only(left: 8),
                  child: Icon(CupertinoIcons.person, color: CupertinoColors.systemGrey),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
              ),
              const SizedBox(height: 16),
              // Campo Contraseña: texto negro forzado
              CupertinoTextField(
                controller: _passController,
                placeholder: 'Contraseña',
                style: const TextStyle(color: CupertinoColors.black),
                placeholderStyle: const TextStyle(color: CupertinoColors.systemGrey2),
                prefix: const Padding(
                  padding: EdgeInsets.only(left: 8),
                  child: Icon(CupertinoIcons.lock, color: CupertinoColors.systemGrey),
                ),
                suffix: CupertinoButton(
                  padding: EdgeInsets.zero,
                  child: Icon(
                    _isPasswordVisible ? CupertinoIcons.eye_slash : CupertinoIcons.eye,
                    size: 20,
                    color: CupertinoColors.systemGrey,
                  ),
                  onPressed: () {
                    setState(() {
                      _isPasswordVisible = !_isPasswordVisible;
                    });
                  },
                ),
                obscureText: !_isPasswordVisible,
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                textInputAction: TextInputAction.go,
                onSubmitted: (_) => _login(),
              ),
              const SizedBox(height: 24),
              CupertinoButton.filled(
                child: const Text(
                  'INICIAR SESIÓN',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                onPressed: _login,
              ),
              const SizedBox(height: 16),
              Align(
                alignment: Alignment.center,
                child: CupertinoButton(
                  padding: EdgeInsets.zero,
                  child: const Text('¿Olvidaste tus datos?'),
                  onPressed: () {
                    showCupertinoDialog(
                      context: context,
                      builder: (context) => CupertinoAlertDialog(
                        title: const Text('Función no implementada'),
                        actions: [
                          CupertinoDialogAction(
                            child: const Text('OK'),
                            onPressed: () => Navigator.pop(context),
                          )
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ---------------------------------
// HOME PAGE CON CUpertino (sin congelar)
// ---------------------------------
class MenuItem {
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  const MenuItem({required this.title, required this.icon, required this.onTap});
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<MenuItem> menuItems = [
      MenuItem(
        title: "Preguntas frecuentes",
        icon: CupertinoIcons.question_circle,
        onTap: () {
          Navigator.pushNamed(context, MyApp.routeFAQs);
        },
      ),
      MenuItem(
        title: "Registro de cualquier cosa",
        icon: CupertinoIcons.calendar,
        onTap: () {
          Navigator.pushNamed(context, MyApp.routeRegistro);
        },
      ),
      MenuItem(
        title: "Calculadora",
        icon: CupertinoIcons.circle_grid_3x3,
        onTap: () {
          Navigator.pushNamed(context, MyApp.routeCalculadora);
        },
      ),
    ];

    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: const Text('Mi Aplicación'),
        trailing: CupertinoButton(
          padding: EdgeInsets.zero,
          child: const Icon(CupertinoIcons.power, color: CupertinoColors.systemGrey),
          onPressed: () {
            showCupertinoDialog(
              context: context,
              builder: (context) => CupertinoAlertDialog(
                title: const Text('Cerrar sesión'),
                content: const Text('¿Estás seguro que deseas cerrar la sesión?'),
                actions: [
                  CupertinoDialogAction(
                    child: const Text('CANCELAR'),
                    onPressed: () => Navigator.pop(context),
                  ),
                  CupertinoDialogAction(
                    isDestructiveAction: true,
                    child: const Text('CERRAR SESIÓN'),
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        MyApp.routeLogin,
                        (_) => false,
                      );
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ),
      child: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 16),
            Column(
              children: [
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: CupertinoColors.systemBlue,
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: const Text(
                    "IQ",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: CupertinoColors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  "Bienvenido, Ismael",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                const Text(
                  "¿Qué deseas hacer hoy?",
                  style: TextStyle(fontSize: 14, color: CupertinoColors.systemGrey),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: menuItems.length,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  return CupertinoButton(
                    padding: EdgeInsets.zero,
                    onPressed: menuItems[index].onTap,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      decoration: BoxDecoration(
                        color: CupertinoColors.systemGrey6,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 36,
                            height: 36,
                            decoration: BoxDecoration(
                              color: CupertinoColors.systemBlue.withOpacity(0.1),
                              shape: BoxShape.circle,
                            ),
                            alignment: Alignment.center,
                            child: Icon(
                              menuItems[index].icon,
                              color: CupertinoColors.systemBlue,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              menuItems[index].title,
                              style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: CupertinoColors.black),
                            ),
                          ),
                          const Icon(CupertinoIcons.right_chevron,
                              color: CupertinoColors.systemGrey),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------
// PÁGINA: Preguntas Frecuentes (Cupertino)
// ---------------------------------
class FAQsPage extends StatelessWidget {
  const FAQsPage({Key? key}) : super(key: key);

  final List<Map<String, String>> faqs = const [
    {
      "question": "¿Cómo inicio sesión?",
      "answer": "Para iniciar sesión, ingresa tu usuario y contraseña en la pantalla de login."
    },
    {
      "question": "¿Cómo cierro sesión?",
      "answer": "Pulsa el icono de encendido en la esquina superior.\nSe mostrará un cuadro para confirmar."
    },
    {
      "question": "¿Dónde veo mis datos de perfil?",
      "answer": "En esta versión ya no hay sección de perfil; tal vez en próximas actualizaciones se agregue."
    },
  ];

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Preguntas Frecuentes'),
      ),
      child: SafeArea(
        child: ListView.separated(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          itemCount: faqs.length,
          separatorBuilder: (_, __) => const SizedBox(height: 12),
          itemBuilder: (context, index) {
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: CupertinoColors.systemGrey6,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    faqs[index]["question"]!,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    faqs[index]["answer"]!,
                    style: const TextStyle(fontSize: 14, color: CupertinoColors.systemGrey),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

// ---------------------------------
// PÁGINA: Registro (CupertinoDatePicker)
// ---------------------------------
class RegistroPage extends StatefulWidget {
  const RegistroPage({Key? key}) : super(key: key);

  @override
  RegistroPageState createState() => RegistroPageState();
}

class RegistroPageState extends State<RegistroPage> {
  DateTime _selectedDate = DateTime.now();

  void _onDateChanged(DateTime newDate) {
    setState(() {
      _selectedDate = newDate;
    });
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Registro de cualquier cosa'),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              const Text(
                "Selecciona una fecha:",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: 200,
                child: CupertinoDatePicker(
                  mode: CupertinoDatePickerMode.date,
                  initialDateTime: _selectedDate,
                  onDateTimeChanged: _onDateChanged,
                  use24hFormat: true,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                "Fecha elegida: ${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}",
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 24),
              CupertinoButton.filled(
                child: const Text('Registrar'),
                onPressed: () {
                  showCupertinoDialog(
                    context: context,
                    builder: (_) => CupertinoAlertDialog(
                      title: const Text('Registro'),
                      content: Text(
                        'Fecha registrada:\n${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}',
                      ),
                      actions: [
                        CupertinoDialogAction(
                          isDefaultAction: true,
                          child: const Text('OK'),
                          onPressed: () => Navigator.pop(context),
                        )
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ---------------------------------
// PÁGINA: Calculadora (Cupertino)
// ---------------------------------
class CalculadoraPage extends StatefulWidget {
  const CalculadoraPage({Key? key}) : super(key: key);

  @override
  CalculadoraPageState createState() => CalculadoraPageState();
}

class CalculadoraPageState extends State<CalculadoraPage> {
  String _display = "0";
  String _operator = "";
  double _firstOperand = 0;
  bool _shouldClearDisplay = false;

  void _numClick(String text) {
    setState(() {
      if (_shouldClearDisplay || _display == "0") {
        _display = text;
        _shouldClearDisplay = false;
      } else {
        _display += text;
      }
    });
  }

  void _clear() {
    setState(() {
      _display = "0";
      _operator = "";
      _firstOperand = 0;
      _shouldClearDisplay = false;
    });
  }

  void _setOperator(String op) {
    setState(() {
      _firstOperand = double.parse(_display);
      _operator = op;
      _shouldClearDisplay = true;
    });
  }

  void _calculate() {
    double secondOperand = double.parse(_display);
    double result = 0;

    switch (_operator) {
      case "+":
        result = _firstOperand + secondOperand;
        break;
      case "-":
        result = _firstOperand - secondOperand;
        break;
      case "×":
        result = _firstOperand * secondOperand;
        break;
      case "÷":
        if (secondOperand != 0) {
          result = _firstOperand / secondOperand;
        } else {
          showCupertinoDialog(
            context: context,
            builder: (_) => CupertinoAlertDialog(
              title: const Text('Error'),
              content: const Text('División por cero'),
              actions: [
                CupertinoDialogAction(
                  isDefaultAction: true,
                  child: const Text('OK'),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
          );
          return;
        }
        break;
      default:
        return;
    }

    setState(() {
      _display = result.toString();
      _operator = "";
      _shouldClearDisplay = true;
    });
  }

  Widget _buildButton(String label, {Color? color, required VoidCallback onTap}) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: CupertinoButton(
          color: color ?? CupertinoColors.systemGrey5,
          borderRadius: BorderRadius.circular(8),
          padding: const EdgeInsets.symmetric(vertical: 20),
          onPressed: onTap,
          child: Text(
            label,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: color != null ? CupertinoColors.white : CupertinoColors.black,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Calculadora'),
      ),
      child: SafeArea(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              color: CupertinoColors.systemGrey6,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              child: Text(
                _display,
                textAlign: TextAlign.right,
                style: const TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  color: CupertinoColors.black,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: Column(
                children: [
                  Row(
                    children: [
                      _buildButton("7", onTap: () => _numClick("7")),
                      _buildButton("8", onTap: () => _numClick("8")),
                      _buildButton("9", onTap: () => _numClick("9")),
                      _buildButton("÷",
                          color: CupertinoColors.systemBlue,
                          onTap: () => _setOperator("÷")),
                    ],
                  ),
                  Row(
                    children: [
                      _buildButton("4", onTap: () => _numClick("4")),
                      _buildButton("5", onTap: () => _numClick("5")),
                      _buildButton("6", onTap: () => _numClick("6")),
                      _buildButton("×",
                          color: CupertinoColors.systemBlue,
                          onTap: () => _setOperator("×")),
                    ],
                  ),
                  Row(
                    children: [
                      _buildButton("1", onTap: () => _numClick("1")),
                      _buildButton("2", onTap: () => _numClick("2")),
                      _buildButton("3", onTap: () => _numClick("3")),
                      _buildButton("-",
                          color: CupertinoColors.systemBlue,
                          onTap: () => _setOperator("-")),
                    ],
                  ),
                  Row(
                    children: [
                      _buildButton("0", onTap: () => _numClick("0")),
                      _buildButton("C", onTap: _clear),
                      _buildButton("=", color: CupertinoColors.systemBlue, onTap: _calculate),
                      _buildButton("+",
                          color: CupertinoColors.systemBlue,
                          onTap: () => _setOperator("+")),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------
// PÁGINA: Detalle (Cupertino)
// ---------------------------------
class DetallePage extends StatelessWidget {
  const DetallePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text("Mi Perfil"),
      ),
      child: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                color: CupertinoColors.systemGrey6,
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        color: CupertinoColors.systemBlue,
                        shape: BoxShape.circle,
                      ),
                      alignment: Alignment.center,
                      child: const Text(
                        "IQ",
                        style: TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                          color: CupertinoColors.white,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      "Ismael Quispe",
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: CupertinoColors.activeBlue,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: const Text(
                        "Usuario Activo",
                        style: TextStyle(
                          color: CupertinoColors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: CupertinoColors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: CupertinoColors.systemGrey.withOpacity(0.2),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Información Personal",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: CupertinoColors.systemBlue,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      height: 1,
                      color: CupertinoColors.systemGrey4,
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        const Icon(CupertinoIcons.person, color: CupertinoColors.systemBlue),
                        const SizedBox(width: 8),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              "Nombre",
                              style: TextStyle(fontWeight: FontWeight.w500),
                            ),
                            Text("Ismael"),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        const Icon(CupertinoIcons.person_alt, color: CupertinoColors.systemBlue),
                        const SizedBox(width: 8),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              "Apellido",
                              style: TextStyle(fontWeight: FontWeight.w500),
                            ),
                            Text("Quispe"),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        const Icon(CupertinoIcons.mail, color: CupertinoColors.systemBlue),
                        const SizedBox(width: 8),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              "Correo electrónico",
                              style: TextStyle(fontWeight: FontWeight.w500),
                            ),
                            Text("nombre@ejemplo.com"),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: CupertinoButton.filled(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(CupertinoIcons.settings,
                          size: 20, color: CupertinoColors.white),
                      SizedBox(width: 6),
                      Text("EDITAR PERFIL"),
                    ],
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, MyApp.routeConfiguracion);
                  },
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}

// ---------------------------------
// PÁGINA: Configuración (Cupertino)
// ---------------------------------
class ConfiguracionPage extends StatelessWidget {
  const ConfiguracionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text("Configuración"),
      ),
      child: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(vertical: 8),
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Text(
                "Ajustes de la aplicación",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: CupertinoColors.systemBlue,
                ),
              ),
            ),
            // Sección de ajustes generales
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: CupertinoColors.systemGrey6,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  // Cambiar idioma
                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () {
                      showCupertinoDialog(
                        context: context,
                        builder: (_) => CupertinoAlertDialog(
                          title: const Text('Función no implementada'),
                          actions: [
                            CupertinoDialogAction(
                              isDefaultAction: true,
                              child: const Text('OK'),
                              onPressed: () => Navigator.pop(context),
                            ),
                          ],
                        ),
                      );
                    },
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      child: Row(
                        children: [
                          Icon(CupertinoIcons.globe, color: CupertinoColors.systemBlue),
                          SizedBox(width: 12),
                          Expanded(child: Text("Cambiar idioma")),
                          Icon(CupertinoIcons.right_chevron, color: CupertinoColors.systemGrey),
                        ],
                      ),
                    ),
                  ),
                  Container(height: 1, color: CupertinoColors.systemGrey4),
                  // Notificaciones
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    child: Row(
                      children: [
                        const Icon(CupertinoIcons.bell, color: CupertinoColors.systemBlue),
                        const SizedBox(width: 12),
                        const Expanded(child: Text("Notificaciones")),
                        CupertinoSwitch(
                          value: true,
                          onChanged: (val) {
                            showCupertinoDialog(
                              context: context,
                              builder: (_) => CupertinoAlertDialog(
                                title: const Text('Función no implementada'),
                                actions: [
                                  CupertinoDialogAction(
                                    isDefaultAction: true,
                                    child: const Text('OK'),
                                    onPressed: () => Navigator.pop(context),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Text(
                "Seguridad",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: CupertinoColors.systemBlue,
                ),
              ),
            ),
            // Sección de Seguridad
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: CupertinoColors.systemGrey6,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  // Privacidad
                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () {
                      showCupertinoDialog(
                        context: context,
                        builder: (_) => CupertinoAlertDialog(
                          title: const Text('Función no implementada'),
                          actions: [
                            CupertinoDialogAction(
                              isDefaultAction: true,
                              child: const Text('OK'),
                              onPressed: () => Navigator.pop(context),
                            ),
                          ],
                        ),
                      );
                    },
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      child: Row(
                        children: [
                          Icon(CupertinoIcons.lock_shield, color: CupertinoColors.systemBlue),
                          SizedBox(width: 12),
                          Expanded(child: Text("Privacidad")),
                          Icon(CupertinoIcons.right_chevron, color: CupertinoColors.systemGrey),
                        ],
                      ),
                    ),
                  ),
                  Container(height: 1, color: CupertinoColors.systemGrey4),
                  // Cambiar contraseña (reemplazo del icono “key” por “lock”)
                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () {
                      showCupertinoDialog(
                        context: context,
                        builder: (_) => CupertinoAlertDialog(
                          title: const Text('Función no implementada'),
                          actions: [
                            CupertinoDialogAction(
                              isDefaultAction: true,
                              child: const Text('OK'),
                              onPressed: () => Navigator.pop(context),
                            ),
                          ],
                        ),
                      );
                    },
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      child: Row(
                        children: [
                          Icon(CupertinoIcons.lock, color: CupertinoColors.systemBlue),
                          SizedBox(width: 12),
                          Expanded(child: Text("Cambiar contraseña")),
                          Icon(CupertinoIcons.right_chevron, color: CupertinoColors.systemGrey),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Text(
                "Sobre la app",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: CupertinoColors.systemBlue,
                ),
              ),
            ),
            // Sección “Sobre la app”
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: CupertinoColors.systemGrey6,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  // Acerca de
                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () {
                      showCupertinoDialog(
                        context: context,
                        builder: (_) => CupertinoAlertDialog(
                          title: const Text('Función no implementada'),
                          actions: [
                            CupertinoDialogAction(
                              isDefaultAction: true,
                              child: const Text('OK'),
                              onPressed: () => Navigator.pop(context),
                            ),
                          ],
                        ),
                      );
                    },
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      child: Row(
                        children: [
                          Icon(CupertinoIcons.info, color: CupertinoColors.systemBlue),
                          SizedBox(width: 12),
                          Expanded(child: Text("Acerca de")),
                          Icon(CupertinoIcons.right_chevron, color: CupertinoColors.systemGrey),
                        ],
                      ),
                    ),
                  ),
                  Container(height: 1, color: CupertinoColors.systemGrey4),
                  // Ayuda
                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () {
                      showCupertinoDialog(
                        context: context,
                        builder: (_) => CupertinoAlertDialog(
                          title: const Text('Función no implementada'),
                          actions: [
                            CupertinoDialogAction(
                              isDefaultAction: true,
                              child: const Text('OK'),
                              onPressed: () => Navigator.pop(context),
                            ),
                          ],
                        ),
                      );
                    },
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      child: Row(
                        children: [
                          Icon(CupertinoIcons.question, color: CupertinoColors.systemBlue),
                          SizedBox(width: 12),
                          Expanded(child: Text("Ayuda")),
                          Icon(CupertinoIcons.right_chevron, color: CupertinoColors.systemGrey),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
