//
//  AppDelegate.swift
//  Movietrending
//
//  Created by Ильфат Салахов on 02.05.2024.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        let nc = UINavigationController(rootViewController: MainViewController())
        window.rootViewController = nc
        window.makeKeyAndVisible()
        
        self.window = window
        return true
    }
}

