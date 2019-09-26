//
//  AppDelegate.swift
//  PoPo
//
//  Created by 吉田侑生 on 2019/09/23.
//  Copyright © 2019 吉田侑生. All rights reserved.
//

import UIKit
import Photos

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        /*
        print("application")
        
        let photos = PHPhotoLibrary.authorizationStatus()
        
        if photos == .notDetermined {
            print("if photos")
            PHPhotoLibrary.requestAuthorization({status in
                if status == .authorized{
                    self.gotoVC()
                } else {
                    print("if status else")
                    let alert = UIAlertController(title: "Photos Access Denied", message: "App needs access to photos library.", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.window?.rootViewController?.present(alert, animated: true, completion: nil)
                }
            })
            print("fin PHPhotoLibrary.requestAuthorization")
        } else if photos == .authorized {
            gotoVC()
        }
        */
        print("application fin")
        return true
        
    }
    /*
    func gotoVC() {
        DispatchQueue.main.async(execute: { () -> Void in
            self.window = UIWindow(frame: UIScreen.main.bounds)
            if let window = self.window {
                window.backgroundColor = UIColor.white
                
                let nav = UINavigationController()
                let mainView = ViewController()
                nav.viewControllers = [mainView]
                window.rootViewController = nav
                window.makeKeyAndVisible()
            }
        })
    }*/
    
    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

