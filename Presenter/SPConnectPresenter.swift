// 
//  SPConnectPresenter.swift
//  Seena Patient
//
//  Created by Ahmed Khalifa on 09/06/2022.
//  Copyright © 2022 RKAnjel. All rights reserved.
//

import UIKit

class SPConnectPresenter: SPConnectPresenterProtocol {

    // MARK: - Attributes
    weak var view: SPConnectViewProtocol?
    var interactor: SPConnectInteractorProtocol
    var router: SPConnectRouterProtocol
    let localization = SPConnectLocalization()
    // MARK: - Init
    init(view: SPConnectViewProtocol, interactor: SPConnectInteractorProtocol, router: SPConnectRouterProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }

    // MARK: - Life Cycle
    func viewDidLoad() {
        view?.setupUI()
    }
}

// MARK: - SPConnectInteractorOutputProtocol
extension SPConnectPresenter: SPConnectInteractorOutputProtocol {
}
