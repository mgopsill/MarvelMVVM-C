//
//  AppDelegate.swift
//  MarvelMVVM-C
//
//  Created by Mike Gopsill on 22/01/2019.
//  Copyright © 2019 Mike Gopsill. All rights reserved.
//

import UIKit

class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var coordinator: RootCoordinator?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let navigationViewController = UINavigationController()
        coordinator = RootCoordinator(navigationController: navigationViewController)
        coordinator?.start()
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = coordinator?.navigationController
        window?.makeKeyAndVisible()
        
        return true
    }
}

