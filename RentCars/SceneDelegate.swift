//
//  SceneDelegate.swift
//  RentCars
//
//  Created by Oleh Dovhan on 09.06.2021.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
  var window: UIWindow?
  
  func scene(_ scene: UIScene,
             willConnectTo session: UISceneSession,
             options connectionOptions: UIScene.ConnectionOptions) {
    guard let _ = (scene as? UIWindowScene) else { return }
    let vc = window?.rootViewController as! ViewController
    let mainContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    vc.context = mainContext
  }
  
  func sceneDidDisconnect(_ scene: UIScene) {
  }
  
  func sceneDidBecomeActive(_ scene: UIScene) {
  }
  
  func sceneWillResignActive(_ scene: UIScene) {
  }
  
  func sceneWillEnterForeground(_ scene: UIScene) {
  }
  
  func sceneDidEnterBackground(_ scene: UIScene) {
    (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
  }
}

