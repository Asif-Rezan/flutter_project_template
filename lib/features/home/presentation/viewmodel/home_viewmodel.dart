import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

import '../../../../core/services/api_services/api_services.dart';
import '../../data/model/home_banner.dart';
import '../../data/model/home_product_model.dart';
import '../../data/model/home_user_model.dart';
import '../../data/repositories/home_repository_impl.dart';
import '../../domain/repositories/home_repository.dart';

// ====================== STATE ======================
class HomeState {
  final bool isLoading;
  final List<HomeBanner> banners;
  final List<HomeProduct> products;
  final List<HomeUser> users;

  const HomeState({
    this.isLoading = false,
    this.banners = const [],
    this.products = const [],
    this.users = const [],
  });

  HomeState copyWith({
    bool? isLoading,
    List<HomeBanner>? banners,
    List<HomeProduct>? products,
    List<HomeUser>? users,
  }) {
    return HomeState(
      isLoading: isLoading ?? this.isLoading,
      banners: banners ?? this.banners,
      products: products ?? this.products,
      users: users ?? this.users,
    );
  }
}

// ====================== NOTIFIER ======================
class HomeNotifier extends StateNotifier<HomeState> {
  final HomeRepository _repository;

  HomeNotifier(this._repository) : super(const HomeState());

  Future<void> loadAllData() async {
    state = state.copyWith(isLoading: true);

    try {
      final results = await Future.wait([
        _repository.fetchBanners(),
        _repository.fetchProducts(),
        _repository.fetchUsers(),
      ]);

      state = state.copyWith(
        banners: results[0] as List<HomeBanner>,
        products: results[1] as List<HomeProduct>,
        users: results[2] as List<HomeUser>,
      );
    } catch (e) {
      if (kDebugMode) {
        print("Error loading home data: $e");
      }
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }

  Future<void> refreshProducts() async {
    try {
      final products = await _repository.fetchProducts();
      state = state.copyWith(products: products);
    } catch (e) {
      if (kDebugMode) print("Error refreshing products: $e");
    }
  }

  Future<void> refreshUsers() async {
    try {
      final users = await _repository.fetchUsers();
      state = state.copyWith(users: users);
    } catch (e) {
      if (kDebugMode) print("Error refreshing users: $e");
    }
  }

  Future<void> refreshBanners() async {
    try {
      final banners = await _repository.fetchBanners();
      state = state.copyWith(banners: banners);
    } catch (e) {
      if (kDebugMode) print("Error refreshing banners: $e");
    }
  }
}

// ====================== PROVIDER ======================

// Main provider for HomeScreen - Direct instantiation (as per your request)
final homeProvider = StateNotifierProvider<HomeNotifier, HomeState>(
      (ref) {
    // Direct creation of repository implementation
    final repository = HomeRepositoryImpl(ApiService());
    return HomeNotifier(repository);
  },
);