import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'screen/error_screen.dart';

import 'screen/home_screen.dart';
import 'screen/one_screen.dart';
import 'screen/three_screen.dart';
import 'screen/two_screen.dart';

void main() {
  runApp(const _App());
}

class _App extends StatelessWidget {
  const _App();

  GoRouter get _router => GoRouter(
        initialLocation: '/',
        errorBuilder: ((context, state) {
          return ErrorScreen(error: state.error.toString());
        }),
        routes: [
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
        ],
      );

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      // 라우트 정보를 전달
      // routeInformationProvider: _router.routeInformationProvider,

      // // URI String 을 상태 및 Go Router 에서 사용할 수 있는 형태로
      // // 변환해주는 함수
      // routeInformationParser: _router.routeInformationParser,

      // // 위에서 변경된 값으로
      // // 실제로 어떤 라우트를 보여줄지
      // // 정하는 함수
      // routerDelegate: _router.routerDelegate,
      routerConfig: _router,
    );
  }
}
