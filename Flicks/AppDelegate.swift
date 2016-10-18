//
//  AppDelegate.swift
//  Flicks
//
//  Created by Craig Vargas on 10/14/16.
//  Copyright © 2016 Cvar. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        //bind constant to the main.storyboard
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        // Set up the first View Controller
        let nowPlayingNavCtrl = storyboard.instantiateViewController(withIdentifier: "MoviesNavCtrl") as! UINavigationController
        let nowPlayingViewCtrl = nowPlayingNavCtrl.topViewController as! MoviesViewController
        nowPlayingViewCtrl.apiEndPoint = "now_playing"
        nowPlayingViewCtrl.view.backgroundColor = UIColor.orange
        nowPlayingViewCtrl.tabBarItem.title = "Now Playing"
        nowPlayingViewCtrl.tabBarItem.image = UIImage(named: "iconmonstr-video-3-32")
        print("nav ctrlr: \(nowPlayingViewCtrl.navigationController)")
        
        // Set up the second View Controller
        let topRatedNavCtrl = storyboard.instantiateViewController(withIdentifier: "MoviesNavCtrl") as! UINavigationController
        let topRatedViewCtrl = topRatedNavCtrl.topViewController as! MoviesViewController
        topRatedViewCtrl.apiEndPoint = "top_rated"
        topRatedViewCtrl.view.backgroundColor = UIColor.purple
        topRatedViewCtrl.tabBarItem.title = "Top Rated"
        topRatedViewCtrl.tabBarItem.image = UIImage(named: "iconmonstr-trophy-7-32")
        
        // Set up the Tab Bar Controller to have two tabs
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [nowPlayingNavCtrl, topRatedNavCtrl]
        
        // Make the Tab Bar Controller the root view controller
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

