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
