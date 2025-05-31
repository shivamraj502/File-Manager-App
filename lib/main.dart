import 'package:flutter/material.dart';

void main() {
  runApp(const FileManagerApp());
}

class FileManagerApp extends StatelessWidget {
  const FileManagerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'File Manager',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const MainScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;
  
  final List<Widget> _pages = [
    const HomePage(),
    const FilesPage(),
    const FavoritesPage(),
    const SettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_getAppBarTitle()),
        actions: [
          if (_currentIndex == 1)
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {},
            ),
        ],
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.folder),
            label: 'Files',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorites',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
      floatingActionButton: _currentIndex == 1
          ? FloatingActionButton(
              onPressed: () {},
              child: const Icon(Icons.add),
              tooltip: 'Add File',
            )
          : null,
    );
  }

  String _getAppBarTitle() {
    switch (_currentIndex) {
      case 0: return 'Home';
      case 1: return 'My Files';
      case 2: return 'Favorites';
      case 3: return 'Settings';
      default: return 'File Manager';
    }
  }
}

// Home Page
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Storage Overview',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 16),
          _buildStorageCard(context),
          const SizedBox(height: 24),
          Text(
            'Quick Access',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 16),
          _buildQuickAccessGrid(),
          const SizedBox(height: 24),
          Text(
            'Recent Files',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 16),
          _buildRecentFilesList(),
        ],
      ),
    );
  }

  Widget _buildStorageCard(BuildContext context) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            LinearProgressIndicator(
              value: 0.65,
              backgroundColor: Colors.grey[200],
              valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
              minHeight: 10,
            ),
            const SizedBox(height: 8),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('65% used'),
                Text('13.2 GB of 32 GB'),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildStorageCategory(Icons.image, 'Images', '4.2 GB'),
                _buildStorageCategory(Icons.music_note, 'Audio', '2.1 GB'),
                _buildStorageCategory(Icons.video_library, 'Videos', '5.8 GB'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStorageCategory(IconData icon, String label, String size) {
    return Column(
      children: [
        Icon(icon, size: 30),
        const SizedBox(height: 4),
        Text(label),
        const SizedBox(height: 4),
        Text(size, style: const TextStyle(fontWeight: FontWeight.bold)),
      ],
    );
  }

  Widget _buildQuickAccessGrid() {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      childAspectRatio: 2,
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      children: [
        _buildQuickAccessItem(Icons.folder, 'Documents', Colors.blue),
        _buildQuickAccessItem(Icons.image, 'Pictures', Colors.green),
        _buildQuickAccessItem(Icons.music_note, 'Music', Colors.purple),
        _buildQuickAccessItem(Icons.video_library, 'Videos', Colors.orange),
      ],
    );
  }

  Widget _buildQuickAccessItem(IconData icon, String label, Color color) {
    return Card(
      elevation: 2,
      color: color.withOpacity(0.1),
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(4),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              Icon(icon, color: color, size: 28),
              const SizedBox(width: 12),
              Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRecentFilesList() {
    final List<Map<String, dynamic>> recentFiles = [
      {'name': 'Project Proposal.docx', 'type': 'doc', 'date': 'Today', 'size': '2.4 MB'},
      {'name': 'Budget.xlsx', 'type': 'xls', 'date': 'Yesterday', 'size': '1.8 MB'},
      {'name': 'Profile Picture.jpg', 'type': 'jpg', 'date': '2 days ago', 'size': '3.2 MB'},
      {'name': 'Meeting Notes.pdf', 'type': 'pdf', 'date': '3 days ago', 'size': '4.5 MB'},
      {'name': 'Presentation.pptx', 'type': 'ppt', 'date': '1 week ago', 'size': '8.7 MB'},
    ];

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: recentFiles.length,
      separatorBuilder: (context, index) => const Divider(height: 1),
      itemBuilder: (context, index) {
        final file = recentFiles[index];
        return ListTile(
          leading: _getFileIcon(file['type']),
          title: Text(file['name']),
          subtitle: Text('${file['date']} • ${file['size']}'),
          trailing: IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {},
          ),
          onTap: () {},
        );
      },
    );
  }

  Widget _getFileIcon(String type) {
    switch (type) {
      case 'doc':
        return const Icon(Icons.description, size: 32, color: Colors.blue);
      case 'xls':
        return const Icon(Icons.table_chart, size: 32, color: Colors.green);
      case 'jpg':
        return const Icon(Icons.image, size: 32, color: Colors.orange);
      case 'pdf':
        return const Icon(Icons.picture_as_pdf, size: 32, color: Colors.red);
      case 'ppt':
        return const Icon(Icons.slideshow, size: 32, color: Colors.orange);
      default:
        return const Icon(Icons.insert_drive_file, size: 32, color: Colors.grey);
    }
  }
}

// Files Page
class FilesPage extends StatelessWidget {
  const FilesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildStorageInfo(),
          const SizedBox(height: 24),
          _buildFileList(),
        ],
      ),
    );
  }

  Widget _buildStorageInfo() {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Internal Storage',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              LinearProgressIndicator(
                value: 0.65,
                backgroundColor: Colors.grey[200],
                valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
              ),
              const SizedBox(height: 4),
              const Text('13.2 GB of 32 GB used'),
            ],
          ),
        ),
        const SizedBox(width: 16),
        IconButton(
          icon: const Icon(Icons.storage),
          onPressed: () {},
        ),
      ],
    );
  }

  Widget _buildFileList() {
    final List<Map<String, dynamic>> folders = [
      {'name': 'Documents', 'count': 24, 'icon': Icons.folder, 'color': Colors.blue},
      {'name': 'Pictures', 'count': 156, 'icon': Icons.image, 'color': Colors.green},
      {'name': 'Music', 'count': 89, 'icon': Icons.music_note, 'color': Colors.purple},
      {'name': 'Videos', 'count': 32, 'icon': Icons.video_library, 'color': Colors.orange},
      {'name': 'Downloads', 'count': 47, 'icon': Icons.download, 'color': Colors.red},
      {'name': 'Backups', 'count': 5, 'icon': Icons.backup, 'color': Colors.amber},
    ];

    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      childAspectRatio: 1.5,
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      children: folders.map((folder) {
        return Card(
          elevation: 2,
          child: InkWell(
            onTap: () {},
            borderRadius: BorderRadius.circular(4),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(folder['icon'], size: 32, color: folder['color']),
                  const SizedBox(height: 12),
                  Text(
                    folder['name'],
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${folder['count']} items',
                    style: const TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                ],
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}

// Favorites Page
class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.favorite, size: 64, color: Colors.red),
          const SizedBox(height: 16),
          const Text(
            'Your Favorite Files',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text(
            'Files you mark as favorite will appear here',
            style: TextStyle(color: Colors.grey),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {},
            child: const Text('Browse Files'),
          ),
        ],
      ),
    );
  }
}

// Settings Page
class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Settings',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 16),
          Card(
            elevation: 2,
            child: Column(
              children: [
                _buildSettingsItem(
                  context,
                  Icons.palette,
                  'Appearance',
                  'Dark mode, accent color',
                  trailing: Switch(value: false, onChanged: (val) {}),
                ),
                const Divider(height: 1),
                _buildSettingsItem(
                  context,
                  Icons.security,
                  'Privacy',
                  'File access permissions',
                  trailing: const Icon(Icons.chevron_right),
                ),
                const Divider(height: 1),
                _buildSettingsItem(
                  context,
                  Icons.storage,
                  'Storage',
                  'Default save location',
                  trailing: const Icon(Icons.chevron_right),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'About',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 16),
          Card(
            elevation: 2,
            child: Column(
              children: [
                _buildSettingsItem(
                  context,
                  Icons.info,
                  'About App',
                  'Version 1.0.0',
                  trailing: const Icon(Icons.chevron_right),
                ),
                const Divider(height: 1),
                _buildSettingsItem(
                  context,
                  Icons.help,
                  'Help & Feedback',
                  'Get help or send feedback',
                  trailing: const Icon(Icons.chevron_right),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsItem(
    BuildContext context,
    IconData icon,
    String title,
    String subtitle, {
    Widget? trailing,
  }) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: trailing,
      onTap: () {},
    );
  }
}