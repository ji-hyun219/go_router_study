# go_router_study

앱/웹에서 사용한 라우팅 라이브러리인 GoRouter는 Dynamic Link, Deep Link, Redirect, Refresh 등 유용한 기능을 기본으로 제공해줍니다. 이를 통해 인증 시스템을 완벽히 구성해봅니다.

&nbsp;

### GoRouter

router 안에 router 넣을 때는 / 안 넣어도 된다 (nesting)

```dart
  ElevatedButton(
            onPressed: () {
              context.go('/one/two/three');
            },
            child: const Text('Go ThreeScreen'))
```

이렇게 하면 한번에 ThreeScreen 갔어도 뒤로 갈 때 Three > Two > One 으로 이동된다

&nbsp;

### refresh

- refresh 기능을 쓰려면 무조건 `changeNotifier` 기능을 써야 한다 / 혹은 `stream` 을 써주어야 한다
- `changeNotifer` 와 `stream` 은 모두 Flutter 에 `내장`되어 있다
- final authStateProvider = AuthNotifier(); 이걸 provider 안에 선언해주면 된다

&nbsp;

### changeNotifier

- ref 가 없다
- notifyListeners : ChangeNotifier 바라보고 있는 것들을 rebuild 하는 기능

&nbsp;

### redirect 로직

```dart
  redirect: authStateProvider._redirectLogic,
  refreshListenable: authStateProvider, // 상태 바뀔 때마다 호출 -> 바로 윗줄도 동시에 실행하려는 의도도 있음
```

- 첫 줄만 쓰면 라우팅할 때마다 redirect 로직이 실행되는데
- 두 번째 줄까지 씀으로써, 두번째 줄이 실행될 때마다 첫번째 로직도 같이 실행된다
