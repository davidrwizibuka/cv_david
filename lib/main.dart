import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CV Flutter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginPage(),
    );
  }
}

// ================= PAGE CONNEXION =================

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController identifiantController =
      TextEditingController();

  final TextEditingController passwordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Connexion"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: identifiantController,
              decoration: const InputDecoration(
                labelText: "Identifiant",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: "Mot de passe",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomePage(),
                  ),
                );
              },
              child: const Text("Se connecter"),
            )
          ],
        ),
      ),
    );
  }
}

// ================= MENU =================

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Center(
              child: Text(
                "CV FLUTTER",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                ),
              ),
            ),
          ),

          ListTile(
            leading: const Icon(Icons.person),
            title: const Text("Mon CV"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HomePage(),
                ),
              );
            },
          ),

          ListTile(
            leading: const Icon(Icons.family_restroom),
            title: const Text("Ma Famille"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FamilyPage(),
                ),
              );
            },
          ),

          ListTile(
            leading: const Icon(Icons.contact_phone),
            title: const Text("Contact"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ContactPage(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

// ================= PAGE CV =================

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(),

      appBar: AppBar(
        title: const Text("Mon CV"),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            const CircleAvatar(
              radius: 60,
              backgroundImage:
                  AssetImage('assets/images/moi.jpg'),
            ),

            const SizedBox(height: 15),

            const Text(
              "david",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const Text(
              "Développeur Flutter",
              style: TextStyle(fontSize: 18),
            ),

            const Divider(),

            const ListTile(
              leading: Icon(Icons.school),
              title: Text("Formation"),
              subtitle: Text(
                "Licence en Informatique"
              ),
            ),

            const ListTile(
              leading: Icon(Icons.work),
              title: Text("Expériences"),
              subtitle: Text(
                "Projet Flutter, Stage de développement"
              ),
            ),

            const ListTile(
              leading: Icon(Icons.code),
              title: Text("Compétences"),
              subtitle: Text(
                "Flutter, Dart, HTML, CSS, Java, PHP"
              ),
            ),

            const ListTile(
              leading: Icon(Icons.language),
              title: Text("Langues"),
              subtitle: Text(
                "Français, Anglais"
              ),
            ),

            const ListTile(
              leading: Icon(Icons.sports_soccer),
              title: Text("Centres d'intérêt"),
              subtitle: Text(
                "Football, Lecture, Informatique"
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ================= PAGE FAMILLE =================

class FamilyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(),

      appBar: AppBar(
        title: const Text("Ma Famille"),
      ),

      body: ListView(
        padding: const EdgeInsets.all(10),
        children: [

          Card(
            child: ListTile(
              leading: const CircleAvatar(
                backgroundImage:
                AssetImage("assets/images/pere.jpg"),
              ),
              title: const Text("Nom du père"),
              subtitle: const Text(
                "Père - Enseignant"
              ),
            ),
          ),

          Card(
            child: ListTile(
              leading: const CircleAvatar(
                backgroundImage:
                AssetImage("assets/images/mere.jpg"),
              ),
              title: const Text("Nom de la mère"),
              subtitle: const Text(
                "Mère - Infirmière"
              ),
            ),
          ),

          Card(
            child: ListTile(
              leading: const CircleAvatar(
                backgroundImage:
                AssetImage("assets/images/frere.jpg"),
              ),
              title: const Text("Nom du frère"),
              subtitle: const Text(
                "Frère - Étudiant"
              ),
            ),
          ),

          Card(
            child: ListTile(
              leading: const CircleAvatar(
                backgroundImage:
                AssetImage("assets/images/soeur.jpg"),
              ),
              title: const Text("Nom de la sœur"),
              subtitle: const Text(
                "Sœur - Élève"
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ================= PAGE CONTACT =================

class ContactPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(),

      appBar: AppBar(
        title: const Text("Contact"),
      ),

      body: ListView(
        children: const [

          ListTile(
            leading: Icon(Icons.phone),
            title: Text("+243 XXX XXX XXX"),
          ),

          ListTile(
            leading: Icon(Icons.email),
            title: Text("votreadresse@gmail.com"),
          ),

          ListTile(
            leading: Icon(Icons.home),
            title: Text("Goma, RDC"),
          ),

          ListTile(
            leading: Icon(Icons.link),
            title: Text(
              "linkedin.com/in/votreprofil",
            ),
          ),

          ListTile(
            leading: Icon(Icons.code),
            title: Text(
              "github.com/votreprofil",
            ),
          ),
        ],
      ),
    );
  }
}