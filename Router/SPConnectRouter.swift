// 
//  SPConnectRouter.swift
//  Seena Patient
//
//  Created by Ahmed Khalifa on 09/06/2022.
//  Copyright © 2022 RKAnjel. All rights reserved.
//

import UIKit

class SPConnectRouter: SPConnectRouterProtocol {
    
    enum Route {
    }
    
    // MARK: - Attributes
    weak var viewController: UIViewController?

    // MARK: - Methods
    static func assembleModule() -> UIViewController {
        let view = SPConnectViewController(nibName: nil, bundle: nil)
        let interactor = SPConnectInteractor()
        let router = SPConnectRouter()
        let presenter = SPConnectPresenter(view: view, interactor: interactor, router: router)

        view.presenter = presenter
        interactor.presenter = presenter
        router.viewController = view

        return view
    }
    
    // MARK: - Navigation
    func go(to route: Route) {
    }
}
