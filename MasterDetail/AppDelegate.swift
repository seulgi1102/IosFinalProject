//
//  AppDelegate.swift
//  MasterDetail
//
//  Created by SeulgiKim on 2024/06/19.
//

import UIKit
//import Firebase
//import FirebaseFirestore
//import FirenaseStorage


@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        //FirebaseApp.configure()
        
       // Firestore.firestore().colloection("test").document("name").setData(["name" : "Seulgi Kim"])
       // let image = UIImage(named: "Seoul")
       // let imageData = Image?.jpegData(compressionQuality: 1.0)
        //let reference = Storage.storage().reference().child("test").child("Seoul")
       // let metaData = StorageMetadata
        
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

