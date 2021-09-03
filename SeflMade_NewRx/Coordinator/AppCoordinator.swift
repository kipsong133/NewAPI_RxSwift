//
//  AppCoordinator.swift
//  SeflMade_NewRx
//
//  Created by 김우성 on 2021/09/03.
//

import UIKit

protocol Coordinator: AnyObject {
    
    var childCoordinator: [Coordinator] { get set }
    func start()
}

class AppCoordinator: Coordinator {
    
    var childCoordinator: [Coordinator] = []
    
    private var navigationController: UINavigationController!
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    /// 앱을 최초로 실행했을 때, 호출될 화면을 결정하는 메소드
    /// - 만약 로그인 로직이 있다면,  메소드를 추가하여 로그인 상태에 따라서 다른 coordinator를 호출한다.
    func start() {
        let coordinator = MainCoordinator(navigationController: self.navigationController)
        coordinator.start()
        self.childCoordinator.append(coordinator)
    }
}
