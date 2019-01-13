//
//  AppDelegate.swift
//  MemeMe2.0-App
//
//  Created by Yazeedo on 13/01/2019.
//  Copyright © 2019 Yazeedo. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    var memes = [Meme]()
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }
    
}
