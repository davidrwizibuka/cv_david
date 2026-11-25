import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'services/api_service.dart';
=======
>>>>>>> d149a715d63b812119916d4a1895b8cf14ba2efd

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
<<<<<<< HEAD
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const LoginPage(),
=======
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginPage(),
>>>>>>> d149a715d63b812119916d4a1895b8cf14ba2efd
    );
  }
}

// ================= PAGE CONNEXION =================

class LoginPage extends StatefulWidget {
<<<<<<< HEAD
  const LoginPage({super.key});

=======
>>>>>>> d149a715d63b812119916d4a1895b8cf14ba2efd
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
<<<<<<< HEAD
  final _formKey = GlobalKey<FormState>();
  final identifiantController = TextEditingController();
  final passwordController = TextEditingController();
  final ApiService _api = ApiService();
  bool _loading = false;
  String? _error;

  Future<void> _seConnecter() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      final account = await _api.login(
        identifiantController.text,
        passwordController.text,
      );
      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => MainNavigation(account: account)),
      );
    } on ApiException catch (error) {
      if (mounted) setState(() => _error = error.message);
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  void dispose() {
    identifiantController.dispose();
    passwordController.dispose();
    super.dispose();
  }
=======
  final TextEditingController identifiantController =
      TextEditingController();

  final TextEditingController passwordController =
      TextEditingController();
>>>>>>> d149a715d63b812119916d4a1895b8cf14ba2efd

  @override
  Widget build(BuildContext context) {
    return Scaffold(
<<<<<<< HEAD
      appBar: AppBar(title: const Text("Connexion")),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  controller: identifiantController,
                  keyboardType: TextInputType.emailAddress,
                  autofillHints: const [AutofillHints.email],
                  validator: (value) => value == null || !value.contains('@')
                      ? 'Saisissez une adresse e-mail valide.'
                      : null,
                  decoration: const InputDecoration(
                    labelText: "Adresse e-mail",
                    border: OutlineInputBorder(),
                  ),
                  onFieldSubmitted: (_) => _seConnecter(),
                ),

                const SizedBox(height: 20),

                TextFormField(
                  controller: passwordController,
                  obscureText: true,
                  validator: (value) => value == null || value.isEmpty
                      ? 'Saisissez votre mot de passe.'
                      : null,
                  onFieldSubmitted: (_) => _seConnecter(),
                  decoration: const InputDecoration(
                    labelText: "Mot de passe",
                    border: OutlineInputBorder(),
                  ),
                ),

                const SizedBox(height: 20),

                if (_error != null) ...[
                  Text(_error!, style: const TextStyle(color: Colors.red)),
                  const SizedBox(height: 12),
                ],
                ElevatedButton(
                  onPressed: _loading ? null : _seConnecter,
                  child: _loading
                      ? const SizedBox.square(
                          dimension: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Text("Se connecter"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ================ NAVIGATION PRINCIPALE ================

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key, required this.account});

  final Map<String, dynamic> account;

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _selectedIndex = 0;
  final _familyKey = GlobalKey<FamilyPageState>();

  void _showAccount() {
    final account = widget.account;
    showDialog<void>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Compte connecté'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('E-mail : ${account['email'] ?? 'Non disponible'}'),
            const SizedBox(height: 8),
            Text('Identifiant : ${account['id'] ?? 'Non disponible'}'),
            if (account['created_at'] != null) ...[
              const SizedBox(height: 8),
              Text('Créé le : ${account['created_at']}'),
            ],
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Fermer'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const titles = ['Mon CV', 'Ma Famille', 'Contact'];
    return Scaffold(
      appBar: AppBar(
        title: Text(titles[_selectedIndex]),
        actions: [
          if (_selectedIndex == 1)
            IconButton(
              onPressed: () => _familyKey.currentState?.reload(),
              tooltip: 'Actualiser la liste',
              icon: const Icon(Icons.refresh),
            ),
          IconButton(
            onPressed: _showAccount,
            tooltip: 'Afficher le compte connecté',
            icon: const Icon(Icons.account_circle_outlined),
          ),
        ],
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          const HomePage(),
          FamilyPage(key: _familyKey),
          const ContactPage(),
        ],
      ),
      floatingActionButton: _selectedIndex == 1
          ? FloatingActionButton.extended(
              onPressed: () => _familyKey.currentState?.addMember(),
              icon: const Icon(Icons.person_add),
              label: const Text('Ajouter'),
            )
          : null,
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (index) =>
            setState(() => _selectedIndex = index),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: 'CV',
          ),
          NavigationDestination(
            icon: Icon(Icons.family_restroom_outlined),
            selectedIcon: Icon(Icons.family_restroom),
            label: 'Famille',
          ),
          NavigationDestination(
            icon: Icon(Icons.contact_page_outlined),
            selectedIcon: Icon(Icons.contact_page),
            label: 'Contact',
=======
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
>>>>>>> d149a715d63b812119916d4a1895b8cf14ba2efd
          ),
        ],
      ),
    );
  }
}

// ================= PAGE CV =================

class HomePage extends StatelessWidget {
<<<<<<< HEAD
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(15),
      child: Column(
        children: [
          const CircleAvatar(radius: 60, child: Icon(Icons.person, size: 64)),

          const SizedBox(height: 15),

          const Text(
            "david",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),

          const Text("Développeur Flutter", style: TextStyle(fontSize: 18)),

          const Divider(),

          const ListTile(
            leading: Icon(Icons.school),
            title: Text("Formation"),
            subtitle: Text("Licence en Informatique"),
          ),

          const ListTile(
            leading: Icon(Icons.work),
            title: Text("Expériences"),
            subtitle: Text("Projet Flutter, Stage de développement"),
          ),

          const ListTile(
            leading: Icon(Icons.code),
            title: Text("Compétences"),
            subtitle: Text("Flutter, Dart, HTML, CSS, Java, PHP"),
          ),

          const ListTile(
            leading: Icon(Icons.language),
            title: Text("Langues"),
            subtitle: Text("Français, Anglais"),
          ),

          const ListTile(
            leading: Icon(Icons.sports_soccer),
            title: Text("Centres d'intérêt"),
            subtitle: Text("Football, Lecture, Informatique"),
          ),
        ],
=======
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
>>>>>>> d149a715d63b812119916d4a1895b8cf14ba2efd
      ),
    );
  }
}

// ================= PAGE FAMILLE =================

<<<<<<< HEAD
class FamilyPage extends StatefulWidget {
  const FamilyPage({super.key});

  @override
  FamilyPageState createState() => FamilyPageState();
}

class FamilyPageState extends State<FamilyPage> {
  final ApiService _api = ApiService();
  late Future<List<FamilyMember>> _members;

  @override
  void initState() {
    super.initState();
    _members = _api.getFamilyMembers();
  }

  void reload() {
    setState(() {
      _members = _api.getFamilyMembers();
    });
  }

  Future<void> addMember() => _editMember();

  Future<void> _editMember([FamilyMember? member]) async {
    final result = await showDialog<FamilyMember>(
      context: context,
      builder: (_) => _FamilyMemberDialog(member: member),
    );
    if (result == null || !mounted) return;
    try {
      if (member == null) {
        await _api.addFamilyMember(result);
      } else {
        await _api.updateFamilyMember(result);
      }
      if (!mounted) return;
      reload();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(member == null ? 'Membre ajouté.' : 'Membre modifié.'),
        ),
      );
    } on ApiException catch (error) {
      if (mounted) _showError(error.message);
    }
  }

  Future<void> _deleteMember(FamilyMember member) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Supprimer ce membre ?'),
        content: Text(
          '${member.prenom} ${member.nom} sera supprimé de la base de données.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: const Text('Annuler'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(dialogContext, true),
            child: const Text('Supprimer'),
=======
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
>>>>>>> d149a715d63b812119916d4a1895b8cf14ba2efd
          ),
        ],
      ),
    );
<<<<<<< HEAD
    if (confirmed != true || member.id == null) return;
    try {
      await _api.deleteFamilyMember(member.id!);
      if (!mounted) return;
      reload();
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Membre supprimé.')));
    } on ApiException catch (error) {
      if (mounted) _showError(error.message);
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.red.shade700),
    );
  }

  @override
  Widget build(BuildContext context) => FutureBuilder<List<FamilyMember>>(
    future: _members,
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return const Center(child: CircularProgressIndicator());
      }
      if (snapshot.hasError) {
        return Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.cloud_off, size: 48),
                const SizedBox(height: 12),
                Text(snapshot.error.toString(), textAlign: TextAlign.center),
                const SizedBox(height: 12),
                FilledButton.icon(
                  onPressed: reload,
                  icon: const Icon(Icons.refresh),
                  label: const Text('Réessayer'),
                ),
              ],
            ),
          ),
        );
      }
      final members = snapshot.data ?? [];
      if (members.isEmpty) {
        return const Center(
          child: Text(
            'Aucun membre enregistré. Ajoutez le premier membre de la famille.',
          ),
        );
      }
      return RefreshIndicator(
        onRefresh: () async => reload(),
        child: ListView.builder(
          padding: const EdgeInsets.fromLTRB(12, 12, 12, 88),
          itemCount: members.length,
          itemBuilder: (context, index) {
            final member = members[index];
            return Card(
              child: ListTile(
                leading: CircleAvatar(
                  child: member.imageUrl == null
                      ? const Icon(Icons.person)
                      : ClipOval(
                          child: Image.network(
                            member.imageUrl!,
                            width: 40,
                            height: 40,
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) =>
                                const Icon(Icons.person),
                          ),
                        ),
                ),
                title: Text(
                  '${member.prenom} ${member.nom} ${member.postnom}'.trim(),
                ),
                subtitle: Text(
                  '${member.parente} · Né(e) le ${member.dateNaissance}\n${member.lieuNaissance}',
                ),
                isThreeLine: true,
                trailing: PopupMenuButton<String>(
                  onSelected: (action) => action == 'edit'
                      ? _editMember(member)
                      : _deleteMember(member),
                  itemBuilder: (_) => const [
                    PopupMenuItem(value: 'edit', child: Text('Modifier')),
                    PopupMenuItem(value: 'delete', child: Text('Supprimer')),
                  ],
                ),
              ),
            );
          },
        ),
      );
    },
  );
}

class _FamilyMemberDialog extends StatefulWidget {
  const _FamilyMemberDialog({this.member});
  final FamilyMember? member;

  @override
  State<_FamilyMemberDialog> createState() => _FamilyMemberDialogState();
}

class _FamilyMemberDialogState extends State<_FamilyMemberDialog> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nom;
  late final TextEditingController _postnom;
  late final TextEditingController _prenom;
  late final TextEditingController _lieu;
  late final TextEditingController _date;
  late final TextEditingController _parente;

  @override
  void initState() {
    super.initState();
    final member = widget.member;
    _nom = TextEditingController(text: member?.nom ?? '');
    _postnom = TextEditingController(text: member?.postnom ?? '');
    _prenom = TextEditingController(text: member?.prenom ?? '');
    _lieu = TextEditingController(text: member?.lieuNaissance ?? '');
    _date = TextEditingController(text: member?.dateNaissance ?? '');
    _parente = TextEditingController(text: member?.parente ?? '');
  }

  @override
  void dispose() {
    for (final controller in [
      _nom,
      _postnom,
      _prenom,
      _lieu,
      _date,
      _parente,
    ]) {
      controller.dispose();
    }
    super.dispose();
  }

  String? _required(String? value) => value == null || value.trim().isEmpty
      ? 'Ce champ est obligatoire.'
      : null;

  Future<void> _selectBirthDate() async {
    final today = DateTime.now();
    final firstDate = DateTime(1900);
    final parsedDate = DateTime.tryParse(_date.text);
    final initialDate =
        parsedDate == null ||
            parsedDate.isBefore(firstDate) ||
            parsedDate.isAfter(today)
        ? today
        : parsedDate;
    final selected = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: today,
      helpText: 'Choisir la date de naissance',
      cancelText: 'Annuler',
      confirmText: 'Valider',
    );
    if (selected == null || !mounted) return;
    _date.text =
        '${selected.year.toString().padLeft(4, '0')}-'
        '${selected.month.toString().padLeft(2, '0')}-'
        '${selected.day.toString().padLeft(2, '0')}';
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    Navigator.pop(
      context,
      FamilyMember(
        id: widget.member?.id,
        nom: _nom.text.trim(),
        postnom: _postnom.text.trim(),
        prenom: _prenom.text.trim(),
        lieuNaissance: _lieu.text.trim(),
        dateNaissance: _date.text.trim(),
        parente: _parente.text.trim(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) => AlertDialog(
    title: Text(
      widget.member == null ? 'Ajouter un membre' : 'Modifier le membre',
    ),
    content: Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            for (final field in [
              ('Nom', _nom, false),
              ('Postnom', _postnom, false),
              ('Prénom', _prenom, false),
              ('Lieu de naissance', _lieu, false),
              ('Date de naissance', _date, true),
              ('Parenté', _parente, false),
            ])
              Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: TextFormField(
                  controller: field.$2,
                  readOnly: field.$3,
                  onTap: field.$3 ? _selectBirthDate : null,
                  validator: _required,
                  decoration: InputDecoration(
                    labelText: field.$1,
                    hintText: field.$3 ? 'AAAA-MM-JJ' : null,
                    border: const OutlineInputBorder(),
                    suffixIcon: field.$3
                        ? IconButton(
                            tooltip: 'Choisir une date',
                            onPressed: _selectBirthDate,
                            icon: const Icon(Icons.calendar_month),
                          )
                        : null,
                  ),
                ),
              ),
          ],
        ),
      ),
    ),
    actions: [
      TextButton(
        onPressed: () => Navigator.pop(context),
        child: const Text('Annuler'),
      ),
      FilledButton(onPressed: _submit, child: const Text('Enregistrer')),
    ],
  );
=======
  }
>>>>>>> d149a715d63b812119916d4a1895b8cf14ba2efd
}

// ================= PAGE CONTACT =================

class ContactPage extends StatelessWidget {
<<<<<<< HEAD
  const ContactPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: const [
        ListTile(leading: Icon(Icons.phone), title: Text("+243 XXX XXX XXX")),

        ListTile(
          leading: Icon(Icons.email),
          title: Text("votreadresse@gmail.com"),
        ),

        ListTile(leading: Icon(Icons.home), title: Text("Goma, RDC")),

        ListTile(
          leading: Icon(Icons.link),
          title: Text("linkedin.com/in/votreprofil"),
        ),

        ListTile(
          leading: Icon(Icons.code),
          title: Text("github.com/votreprofil"),
        ),
      ],
    );
  }
}
=======
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
>>>>>>> d149a715d63b812119916d4a1895b8cf14ba2efd
