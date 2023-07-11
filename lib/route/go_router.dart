import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:poke_graphql/domain/home/model/pokemon.dart';
import 'package:poke_graphql/presentation/pokemon_details/pokemon_details_screen.dart';

import '../presentation/home/home_screen.dart';

import '../presentation/splash/splash_screen.dart';

final routerProvider = Provider<GoRouter>((ref) {
  // final router = RouterNotifier(ref);
  final router = RouterNotifier();

  final listenable = ValueNotifier<bool>(true);

  return GoRouter(
      debugLogDiagnostics: true,
      refreshListenable: listenable,
      redirect: router._redirectLogic,
      routes: router._routes,
      initialLocation: SplashScreen.route,
      errorPageBuilder: router._errorPageBuilder,
      observers: [
        BotToastNavigatorObserver(),
      ]);
});

class RouterNotifier extends ChangeNotifier {
  // final Ref _ref;

  // RouterNotifier(this._ref) {
  RouterNotifier() {
    // _ref.listen<bool>(
    //   loggedInProvider.select((value) => value.loggedIn),
    //   (_, __) => notifyListeners(),
    // );
    // _ref.listen<bool>(
    //   loggedInProvider.select((value) => value.onboarding),
    //   (_, __) => notifyListeners(),
    // );
  }

  String? _redirectLogic(BuildContext context, GoRouterState state) {
    // final token = _ref.watch(loggedInProvider.notifier).token;
    // final user = _ref.watch(loggedInProvider.notifier).user;

    // final isLoggedIn = _ref.watch(loggedInProvider).loggedIn; //bool
    // // final isOnboarding = _ref.watch(loggedInProvider).onboarding; //bool

    // Logger.i('RouterNotifier: isLoggedIn - $isLoggedIn');
    // Logger.i('RouterNotifier:  $token, $user');

    // final areWeLoggingIn = state.location == LoginScreen.route;
    // final areWeRegistering = state.location == SignupScreen.route;

    // if (!isLoggedIn && areWeLoggingIn) {
    //   return areWeLoggingIn ? null : LoginScreen.route;
    // }
    // if (!isLoggedIn && areWeRegistering) {
    //   return areWeRegistering ? null : SignupScreen.route;
    // }

    // if (areWeLoggingIn || areWeRegistering) {
    //   return MainNav.route;
    // }

    return null;
  }

  List<GoRoute> get _routes => [
        GoRoute(
          path: SplashScreen.route,
          builder: (context, state) => const SplashScreen(),
        ),
        GoRoute(
            path: HomeScreen.route,
            builder: (context, state) => const HomeScreen(),
            routes: [
              GoRoute(
                path: PokemonDetailsScreen.route,
                name: PokemonDetailsScreen.route,
                builder: (context, state) {
                  Pokemon pokemon = state.extra as Pokemon;
                  return PokemonDetailsScreen(pokemon: pokemon);
                },
              ),
            ]),
      ];
  Page<void> _errorPageBuilder(BuildContext context, GoRouterState state) =>
      MaterialPage(
        key: state.pageKey,
        child: Scaffold(
          // backgroundColor: Theme.of(context).errorColor.withOpacity(.1),
          body: Center(
            child: Text('Error: ${state.error.toString()}'),
          ),
        ),
      );
}

class SlideRightToLeftTransitionPage extends CustomTransitionPage {
  SlideRightToLeftTransitionPage({
    LocalKey? key,
    required Widget child,
    bool fullscreenDialog = true,
  }) : super(
          key: key,
          fullscreenDialog: fullscreenDialog,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) {
            return SlideTransition(
              position: animation.drive(
                Tween(
                  begin: const Offset(1, 0),
                  end: Offset.zero,
                ).chain(
                  CurveTween(curve: Curves.easeInOut),
                ),
              ),
              child: child,
            );
          },
          child:
              child, // Here you may also wrap this child with some common designed widget
        );
}

class SlideBottomToTopTransitionPage extends CustomTransitionPage {
  SlideBottomToTopTransitionPage({
    LocalKey? key,
    required Widget child,
  }) : super(
          key: key,
          fullscreenDialog: true,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) {
            return SlideTransition(
              position: animation.drive(
                Tween(
                  begin: const Offset(0, 1),
                  end: Offset.zero,
                ).chain(
                  CurveTween(curve: Curves.easeInOut),
                ),
              ),
              child: child,
            );
          },
          child:
              child, // Here you may also wrap this child with some common designed widget
        );
}
