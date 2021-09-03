#  News API를 활용한 Rx_News 

공개 API로 구성한  `MVVM - C + RxSwift` 데모  프로젝트입니다.

- RxSwift 는 Controller와 ViewModel에만 적용했습니다.
(Coordinator는 적용하지 않았습니다.)
- API는 NewAPI.io 에서 제공하는 API를 활용했습니다.


## 구현 순서

1. Coordinator 
2. Model 
3. API Service
4. ViewModel
5. UICollectionView 및 UICollectionViewCell
<br/><br/>


### 1. Coordinator
---

앱 전반의 Coordinator을 관리하는 "AppCoordinator" 를 생성합니다.

프로토콜에 내용을 보면 다음과 같이 선언하고 있습니다.
- var childCoordinator: [Coordinator] { get set }
=> 하위 코디네이터를 관리하는 프로퍼티입니다. 화면을 보여주게 되면, 이 곳에 추가합니다. 역으로 화면에서 제거되면(dismiss or pop) 해당 코디네이터를 제거합니다.  

- func start()
=> 해당 메소드는 앱 프로젝트가 실행되면, 최초에 보여줄 화면을 실행하도록 합니다. VC(ViewController) 의 코디네이터를 실행하고, 해당 코디네이터의 `start()` 를 실행하여 화면을 출력합니다.

AppCoordinator > 특정VC의 Coodinator > VC

이런 구조로 되어있습니다. 만약 VC에서 특정 이벤트로 인해 화면 전환이 필요한 경우 delegate Pattern으로 자신의 Coordinator에게 전달하고 delegate Pattern을 다시 한번 활용하여 AppCoordinator에게 전달합니다. 이후 AppCoordinator에서 어떤 VC's Coordinator를 호출할 지 결정하고 화면에 나타냅니다.

cf. 화면 전환 시, 로직
(VC이벤트 발생 -> 자신의 Coordinator에게 전달 -> App Coordinator에게 전달 -> 원하는 Coordinator 호출 -> 원하는 VC 호출) 
<br/><br/>


### 2. Model
---

API로 부터 받는 원천데이터를 `Article` 구조체에서 선언하고 있습니다.
JSON -> Struct 로 직렬화하기 위하여 Codable 프로토콜을 채택합니다.

<br/><br/>


### 3. API Service
---

API 연동을 위한 클래스는 `ArtivleServiceProtol` 을 채택하여 구현합니다.






