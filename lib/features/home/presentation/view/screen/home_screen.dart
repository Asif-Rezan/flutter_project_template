import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../viewmodel/home_viewmodel.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadInitialData();
    });
  }

  void _loadInitialData() {
    final state = ref.read(homeProvider);
    final notifier = ref.read(homeProvider.notifier);

    if (state.banners.isEmpty &&
        state.products.isEmpty &&
        state.users.isEmpty &&
        !state.isLoading) {
      notifier.loadAllData();
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(homeProvider);
    final notifier = ref.read(homeProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        centerTitle: true,
      ),
      body: RefreshIndicator(
        onRefresh: notifier.loadAllData,
        child: state.isLoading &&
            state.banners.isEmpty &&
            state.products.isEmpty &&
            state.users.isEmpty
            ? const Center(child: CircularProgressIndicator())
            : ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // Banners
            if (state.banners.isNotEmpty) ...[
              const Text('Banners',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),
              SizedBox(
                height: 180,
                child: PageView.builder(
                  controller: PageController(viewportFraction: 0.9),
                  itemCount: state.banners.length,
                  itemBuilder: (context, index) {
                    final banner = state.banners[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.network(
                          banner.imageUrl,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                          const Icon(Icons.broken_image, size: 80),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 24),
            ],

            // Products
            if (state.products.isNotEmpty) ...[
              const Text('Products',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),
              Column(
                children: state.products.map((product) {
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    child: ListTile(
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          product.image,
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) =>
                          const Icon(Icons.image_not_supported),
                        ),
                      ),
                      title: Text(product.name),
                      subtitle: Text("\$${product.price.toStringAsFixed(2)}"),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 24),
            ],

            // Users
            if (state.users.isNotEmpty) ...[
              const Text('Users',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),
              Column(
                children: state.users.map((user) {
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(user.avatar),
                      onBackgroundImageError: (_, __) => const Icon(Icons.person),
                    ),
                    title: Text(user.name),
                  );
                }).toList(),
              ),
            ],

            if (state.banners.isEmpty &&
                state.products.isEmpty &&
                state.users.isEmpty &&
                !state.isLoading)
              const Center(
                child: Padding(
                  padding: EdgeInsets.all(32.0),
                  child: Text('No data available'),
                ),
              ),
          ],
        ),
      ),
    );
  }
}