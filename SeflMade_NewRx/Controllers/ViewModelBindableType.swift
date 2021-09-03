//
//  ViewModelBindableType.swift
//  SeflMade_NewRx
//
//  Created by 김우성 on 2021/09/03.
//

import UIKit

protocol  ViewModelBindableType {
    associatedtype viewModelType
    
    var viewModel: viewModelType! { get set }
    func bindViewModel()
}

extension ViewModelBindableType where Self: UIViewController {
    
    mutating func bind(viewModel: Self.viewModelType) {
        
        self.viewModel = viewModel
        
        loadViewIfNeeded()
        
        bindViewModel()
    }
}
