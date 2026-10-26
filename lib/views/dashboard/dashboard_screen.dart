
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final sections = [
      {
        'title': 'Departamentos',
        'description': 'Explora los departamentos de Colombia.',
        'path': '/listing/Department',
        'icon': Icons.map,
      },
      {
        'title': 'Regiones',
        'description': 'Conoce las regiones del país.',
        'path': '/listing/Region',
        'icon': Icons.public,
      },
      {
        'title': 'Presidentes',
        'description': 'Consulta información de los presidentes.',
        'path': '/listing/President',
        'icon': Icons.account_balance,
      },
      {
        'title': 'Atracciones turísticas',
        'description': 'Descubre lugares turísticos de Colombia.',
        'path': '/listing/TouristicAttraction',
        'icon': Icons.travel_explore,
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Datos Abiertos de Colombia'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'Explora Colombia',
            style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text(
            'Consulta información pública sobre nuestro país.',
            style: TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 20),
          ...sections.map((section) {
            return Card(
              margin: const EdgeInsets.only(bottom: 12),
              child: ListTile(
                leading: Icon(
                  section['icon'] as IconData,
                  size: 36,
                  color: Theme.of(context).colorScheme.primary,
                ),
                title: Text(
                  section['title'] as String,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(section['description'] as String),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () => context.push(section['path'] as String),
              ),
            );
          }),
        ],
      ),
    );
  }
}
