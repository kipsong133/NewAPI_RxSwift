//
//  MainCoordinator.swift
//  SeflMade_NewRx
//
//  Created by 김우성 on 2021/09/03.
//

import UIKit

class MainCoordinator: Coordinator {
    
    var childCoordinator: [Coordinator] = []
    private var navigationController: UINavigationController!
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        var vc = MainViewController()
        vc.bind(viewModel: MainViewModel(articleService: ArticleService()))
        self.navigationController.viewControllers = [vc]
    }
}
