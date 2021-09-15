//
//  AppDelegate.swift
//  RobotDemo
//
//  Created by Dominic Wood on 13/09/2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // running the app from here as no UI required for demo
        
        //after writing the code I realised the the map coords are only providfe on the first script, as this would have required refactoring the command funcs into another class I ran out of time.
        
        //The other caveat is that my offScreen doesn't seem to work, I think my understanding of 2D Swift Arrays is at fault here as the code logic looks good to me. Basically I ran out of time to complete 100%
        //But I hope the techniques used and logic behind thinking and TDD approach shows relevant skills.
        
        let robot = Robot()
        let input1 = "5 3\n1 1 E\nFRFRFRFR"
        robot.processCommand(input: input1)
        
        let input2 = "9 9\n3 2 N\nFRRFLLFFRRFLL"
        robot.processCommand(input: input2)
        
        let input3 = "9 9\n0 3 W\nLLFFFLFLFL"
        robot.processCommand(input: input3)
        
        return true
    }

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

