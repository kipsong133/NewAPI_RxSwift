//
//  MainViewController.swift
//  SeflMade_NewRx
//
//  Created by 김우성 on 2021/09/03.
//

import UIKit
import RxSwift
import RxCocoa

class MainViewController: UIViewController, ViewModelBindableType {
    
    // MARK: - Properties
    var bag = DisposeBag()
    var viewModel: MainViewModel!
    
    private let cellViewModel = BehaviorRelay<[CellViewModel]>(value: [])
    var cellViewModelObserver: Observable<[CellViewModel]> {
        return cellViewModel.asObservable()
    }
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.delegate = self
        cv.dataSource = self
        cv.backgroundColor = .white
        return cv
    }()
    
    // MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        subscribe()
    }
    
    // MARK: - Helpers
    func setupLayout() {
        view.backgroundColor = .white
        
        self.collectionView.register(ArticleCell.self, forCellWithReuseIdentifier: "cell")
      
        
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        collectionView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        collectionView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
    }
    
    
    
    func bindViewModel() {
        
        self.title = viewModel.title
        
        // API -> Cell
        viewModel.fetchArticles()
            .subscribe(onNext: { cellVMs in
                self.cellViewModel.accept(cellVMs)
            })
            .disposed(by: bag)
    }
    
    func subscribe() {
        self.cellViewModelObserver
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { articles in
                self.collectionView.reloadData()
            })
            .disposed(by: bag)
    }
}

extension MainViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.cellViewModel.value.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ArticleCell
        
        cell.imageView.image = nil
        
        let cellVM = self.cellViewModel.value[indexPath.row]
        cell.viewModel.onNext(cellVM)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width,
                      height: 120)
    }
}
