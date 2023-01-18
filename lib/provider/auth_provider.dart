import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../model/user_model.dart';
import '../screen/error_screen.dart';
import '../screen/home_screen.dart';
import '../screen/login_screen.dart';
import '../screen/one_screen.dart';
import '../screen/three_screen.dart';
import '../screen/two_screen.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final authStateProvider = AuthNotifier(ref: ref);

  return GoRouter(
    initialLocation: '/login',
    errorBuilder: (context, state) {
      return ErrorScreen(
        error: state.error.toString(),
      );
    },
    redirect: authStateProvider._redirectLogic,
    refreshListenable: authStateProvider, // 상태 바뀔 때마다 호출 -> 바로 윗줄도 동시에 실행하려는 의도도 있음
    routes: authStateProvider._routes, // 같은 파일 안에서는 private 값을 가져올 수 있다
  );
});

class AuthNotifier extends ChangeNotifier {
  final Ref ref;

  AuthNotifier({
    required this.ref,
  }) {
    ref.listen<UserModel?>(userProvider, (previous, next) {
      if (previous != next) {
        notifyListeners(); // ChangeNotifier 바라보고 있는 것들을 rebuild 하는 기능
      }
    });
  }

  String? _redirectLogic(BuildContext context, GoRouterState state) {
    // UserModel 의 인스턴스나 null
    final user = ref.read(userProvider);

    // 로그인을 하려는 상태인지
    final loggingIn = state.location == '/login';

    // 유저 정보가 없다 - 로그인한 상태가 아니다
    //
    // 유저 정보가 없고
    // 로그인하려는 중이 아니라면
    // 로그인 페이지로 이동한다
    if (user == null) {
      return loggingIn ? null : '/login';
    }

    // 유저 정보가 있는데
    // 로그인 페이지라면
    // 홈으로 이동
    if (loggingIn) {
      return '/';
    }
    return null; // 나머지는 원래 가려던 곳으로 보내버림
  }

  List<GoRoute> get _routes => [
        GoRoute(
          path: '/', builder: (_, state) => const HomeScreen(), // state 를 받으면 상태를 사용할 수 있다
          routes: [
            GoRoute(path: 'one', builder: (_, state) => const OneScreen(),
                // http://..../one/two (/, one, two 합친 라우트의 페이지가 생김)
                routes: [
                  GoRoute(path: 'two', builder: (_, state) => const TwoScreen(), routes: [
                    GoRoute(
                      path: 'three',
                      name: ThreeScreen.routeName,
                      builder: (_, state) => const ThreeScreen(),
                    ),
                  ]),
                ]),
          ],
        ),
        GoRoute(
          path: '/one',
          builder: (_, state) => const OneScreen(),
        ),
        // http://..../two
        GoRoute(
          path: '/two',
          builder: (_, state) => const TwoScreen(),
        ),
        GoRoute(
          path: '/login',
          builder: (_, state) => const LoginScreen(),
        ),
      ];
}

final userProvider = StateNotifierProvider<UserStateNotifier, UserModel?>(
  (ref) => UserStateNotifier(),
);

// 로그인한 상태면 UserModel 인스턴스 상태로 넣어주기
// 로그아웃 상태면 null 상태로 넣어주기
class UserStateNotifier extends StateNotifier<UserModel?> {
  // 로그인한 상태이면 UserModel 이 존재할 것이다
  UserStateNotifier() : super(null); // 처음엔 로그인 안 한 상태이니까 null 값 넣어줌

  logIn({
    required String name,
  }) {
    state = UserModel(name: name);
  }

  logOut() {
    state = null;
  }
}
