// 
//  SPConnectProtocols.swift
//  Seena Patient
//
//  Created by Ahmed Khalifa on 09/06/2022.
//  Copyright © 2022 RKAnjel. All rights reserved.
//

import Foundation

// MARK: - Router
protocol SPConnectRouterProtocol: AnyObject {
    func go(to route: SPConnectRouter.Route)
}

// MARK: - Interactor
protocol SPConnectInteractorOutputProtocol: AnyObject {
}

protocol SPConnectInteractorProtocol: AnyObject {

    var presenter: SPConnectInteractorOutputProtocol?  { get set }
}

// MARK: - Presenter
protocol SPConnectPresenterProtocol: AnyObject {

    var view: SPConnectViewProtocol? { get set }
    var router: SPConnectRouterProtocol { get set }
    var interactor: SPConnectInteractorProtocol { get set }
    var localization: SPConnectLocalization { get }
    func viewDidLoad()
}

// MARK: - View
protocol SPConnectViewProtocol: AnyObject {

    var presenter: SPConnectPresenterProtocol! { get set }
    
    func setupUI()
}
