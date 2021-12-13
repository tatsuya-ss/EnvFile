//
//  AppDelegate.swift
//  EnvFile
//
//  Created by 坂本龍哉 on 2021/12/13.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        loadEnvFile()
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

extension AppDelegate {
    
    private func loadEnvFile() {
        guard let path = Bundle.main.path(forResource: ".env", ofType: nil) else {
            fatalError("Not found: '/path/to/.env'.\nPlease create .env file reference from .env.sample")
        }
        let url = URL(fileURLWithPath: path)
        do {
            let data = try Data(contentsOf: url)
            let dataString = String(data: data, encoding: .utf8) ?? "Empty File"
//        dataString: TWITTER_CONSUMER_KEY='a'
//                    TWITTER_CONSUMER_SECRET='b'
            let clean = dataString.replacingOccurrences(of: "\"", with: "").replacingOccurrences(of: "'", with: "")
//        clean: TWITTER_CONSUMER_KEY=a
//               TWITTER_CONSUMER_SECRET=b
            let envVars = clean.components(separatedBy:"\n")
//        envVars: ["TWITTER_CONSUMER_KEY=a", "TWITTER_CONSUMER_SECRET=b", "", ""]
            for envVar in envVars {
                let keyVal = envVar.components(separatedBy:"=")
//                keyVal: ["TWITTER_CONSUMER_KEY", "a"]
//                        ["TWITTER_CONSUMER_SECRET", "b"]
//                        [""]
//                        [""]
                if keyVal.count == 2 {
                    setenv(keyVal[0], keyVal[1], 1)
                }
            }
        } catch {
            fatalError(error.localizedDescription)
        }
    }


}

