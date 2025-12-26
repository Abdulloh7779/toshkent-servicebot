import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

/* ================= LANGUAGE ================= */

enum Lang { uz, ru, en }

Lang currentLang = Lang.uz;

final Map<Lang, Map<String, String>> t = {
  Lang.uz: {
    "title": "Toshkent Servis",
    "start": "Boshlash",
    "send": "Yuborish",
    "sent": "Telegramga yuborildi ✅",

    "name": "Ism",
    "surname": "Familiya",
    "email": "Email",
    "phone": "Telefon raqam",
    "address": "Manzil",

    "hair": "Soch olish",
    "plumbing": "Santexnika",
    "electric": "Elektrik",
    "cleaning": "Tozalash",
    "computer": "Kompyuter",
  },
  Lang.ru: {
    "title": "Сервисы Ташкента",
    "start": "Начать",
    "send": "Отправить",
    "sent": "Отправлено в Telegram ✅",

    "name": "Имя",
    "surname": "Фамилия",
    "email": "Эл. почта",
    "phone": "Телефон",
    "address": "Адрес",

    "hair": "Стрижка",
    "plumbing": "Сантехника",
    "electric": "Электрик",
    "cleaning": "Уборка",
    "computer": "Компьютер",
  },
  Lang.en: {
    "title": "Tashkent Services",
    "start": "Start",
    "send": "Send",
    "sent": "Sent to Telegram ✅",

    "name": "First name",
    "surname": "Last name",
    "email": "Email",
    "phone": "Phone number",
    "address": "Address",

    "hair": "Haircut",
    "plumbing": "Plumbing",
    "electric": "Electrician",
    "cleaning": "Cleaning",
    "computer": "Computer",
  },
};

/* ================= MAIN ================= */

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  void changeLang(Lang lang) => setState(() => currentLang = lang);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(brightness: Brightness.dark),
      home: RegisterScreen(onLangChange: changeLang),
    );
  }
}

/* ================= COMMON INPUT ================= */

Widget glassInput(
  String hint,
  TextEditingController c, {
  TextInputType type = TextInputType.text,
}) {
  IconData icon = Icons.text_fields;

  // hint bo‘yicha mos icon tanlash
  if (hint.contains("Ism")  hint.contains("Имя")  hint.contains("First")) {
    icon = Icons.person;
  } else if (hint.contains("Familiya") 
      hint.contains("Фамилия") 
      hint.contains("Last")) {
    icon = Icons.person_outline;
  } else if (hint.contains("Email")  hint.contains("почта")) {
    icon = Icons.email;
  } else if (hint.contains("Telefon") 
      hint.contains("Phone") 
      hint.contains("Телефон")) {
    icon = Icons.phone;
  } else if (hint.contains("Manzil") 
      hint.contains("Address") ||
      hint.contains("Адрес")) {
    icon = Icons.location_on;
  }

  return Container(
    margin: const EdgeInsets.only(bottom: 14),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(22),
      color: Colors.white.withAlpha(40),
    ),
    child: TextField(
      controller: c,
      keyboardType: type,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: Colors.white70),
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.white70),
        border: InputBorder.none,
        contentPadding: const EdgeInsets.symmetric(vertical: 18),
      ),
    ),
  );
}

/* ================= REGISTER ================= */

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key, required this.onLangChange});
  final Function(Lang) onLangChange;

  static final name = TextEditingController();
  static final surname = TextEditingController();
  static final email = TextEditingController();
/// 🔥 REGISTRATION UCHUN MAXSUS PREMIUM INPUT
  Widget registerInput({
    required String hint,
    required IconData icon,
    required TextEditingController controller,
    TextInputType type = TextInputType.text,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(26),
        gradient: const LinearGradient(
          colors: [Color(0xff4facfe), Color(0xff00f2fe)],
        ),
      ),
      padding: const EdgeInsets.all(1.6),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: Colors.black.withOpacity(0.55),
        ),
        child: TextField(
          controller: controller,
          keyboardType: type,
          style: const TextStyle(color: Colors.white, fontSize: 16),
          decoration: InputDecoration(
            prefixIcon: Icon(icon, color: Colors.white),
            hintText: hint,
            hintStyle: const TextStyle(color: Colors.white70),
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(
              vertical: 20,
              horizontal: 16,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: topBar(onLangChange),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xff1e3c72), Color(0xff2a5298)],
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                child: Container(
                  padding: const EdgeInsets.all(24),
                  color: Colors.white.withAlpha(40),
                  child: Column(
                    children: [
                      Text(
                        t[currentLang]!["title"]!,
                        style: const TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 28),

                      /// 👤 ISM
                      registerInput(
                        hint: t[currentLang]!["name"]!,
                        icon: Icons.person_rounded,
                        controller: name,
                      ),

                      /// 👤 FAMILIYA
                      registerInput(
                        hint: t[currentLang]!["surname"]!,
                        icon: Icons.person_outline_rounded,
                        controller: surname,
                      ),

                      /// 📧 EMAIL
                      registerInput(
                        hint: t[currentLang]!["email"]!,
                        icon: Icons.email_rounded,
                        controller: email,
                        type: TextInputType.emailAddress,
                      ),

                      const SizedBox(height: 10),
ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(double.infinity, 56),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          backgroundColor: Colors.blueAccent,
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const HomeScreen(),
                            ),
                          );
                        },
                        child: Text(
                          t[currentLang]!["start"]!,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
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
      ),
    );
  }
}

/* ================= APP BAR ================= */

PreferredSizeWidget topBar(Function(Lang) onLangChange) {
  return AppBar(
    title: Text(t[currentLang]!["title"]!),
    actions: [
      DropdownButtonHideUnderline(
        child: DropdownButton<Lang>(
          value: currentLang,
          dropdownColor: Colors.black,
          icon: const Icon(Icons.language, color: Colors.white),
          items: const [
            DropdownMenuItem(value: Lang.uz, child: Text("🇺🇿 UZ")),
            DropdownMenuItem(value: Lang.ru, child: Text("🇷🇺 RU")),
            DropdownMenuItem(value: Lang.en, child: Text("🇺🇸 EN")),
          ],
          onChanged: (v) => onLangChange(v!),
        ),
      ),
      const SizedBox(width: 12),
    ],
  );
}

/* ================= HOME ================= */

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  final services = const [
    {"key": "hair", "icon": Icons.cut},
    {"key": "plumbing", "icon": Icons.plumbing},
    {"key": "electric", "icon": Icons.electrical_services},
    {"key": "cleaning", "icon": Icons.cleaning_services},
    {"key": "computer", "icon": Icons.computer},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: topBar((_) {}),
      body: GridView.builder(
        padding: const EdgeInsets.all(18),
        itemCount: services.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        itemBuilder: (context, i) {
          final key = services[i]['key'] as String;
          final icon = services[i]['icon'] as IconData;
return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => OrderScreen(service: t[currentLang]![key]!),
                ),
              );
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(28),
                gradient: const LinearGradient(
                  colors: [Color(0xff4facfe), Color(0xff00f2fe)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              padding: const EdgeInsets.all(1.6),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(26),
                  color: Colors.black.withOpacity(0.55),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(icon, size: 46, color: Colors.white),
                    const SizedBox(height: 12),
                    Text(
                      t[currentLang]![key]!,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

/* ================= ORDER ================= */

/* ================= ORDER ================= */

class OrderScreen extends StatelessWidget {
  final String service;
  OrderScreen({super.key, required this.service});

  final phone = TextEditingController();
  final address = TextEditingController();

  Future<void> sendToTelegram() async {
    const botToken = "8539288946:AAEEg4WV0-63cA0QgaTBKQe6UVyKU6uJGU8";
    const chatId = "6469083657";

    final text =
        """
🛎 YANGI BUYURTMA
🧰 $service

👤 ${RegisterScreen.name.text} ${RegisterScreen.surname.text}
📧 ${RegisterScreen.email.text}
📞 ${phone.text}
📍 ${address.text}
""";

    await http.post(
      Uri.parse("https://api.telegram.org/bot$botToken/sendMessage"),
      body: {"chat_id": chatId, "text": text},
    );
  }

  /// 🔥 MAXSUS DIZAYN (FAKAT ORDER UCHUN)
  Widget orderInput({
    required String hint,
    required IconData icon,
    required TextEditingController controller,
    TextInputType type = TextInputType.text,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(26),
        gradient: const LinearGradient(
          colors: [Color(0xff4facfe), Color(0xff00f2fe)],
        ),
      ),
      padding: const EdgeInsets.all(1.6),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: Colors.black.withOpacity(0.55),
        ),
        child: TextField(
          controller: controller,
          keyboardType: type,
          style: const TextStyle(color: Colors.white, fontSize: 16),
          decoration: InputDecoration(
            prefixIcon: Icon(icon, color: Colors.white),
            hintText: hint,
            hintStyle: const TextStyle(color: Colors.white70),
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(
              vertical: 20,
              horizontal: 16,
            ),
          ),
        ),
      ),
    );
  }
@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(service)),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            /// 📞 TELEFON
            orderInput(
              hint: t[currentLang]!["phone"]!,
              icon: Icons.phone_rounded,
              controller: phone,
              type: TextInputType.phone,
            ),

            /// 📍 MANZIL
            orderInput(
              hint: t[currentLang]!["address"]!,
              icon: Icons.location_on_rounded,
              controller: address,
            ),

            const SizedBox(height: 10),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 56),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                backgroundColor: Colors.greenAccent.shade700,
              ),
              onPressed: () async {
                await sendToTelegram();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(t[currentLang]!["sent"]!)),
                );
                Navigator.popUntil(context, (r) => r.isFirst);
              },
              child: Text(
                t[currentLang]!["send"]!,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

}
