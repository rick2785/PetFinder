//
//  AppDelegate.swift
//  Pet Finder
//
//  Created by Rickey Hrabowskie on 4/28/17.
//  Copyright © 2017 Rickey Hrabowskie. All rights reserved.
//


import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  // MARK: - Properties
  var window: UIWindow?
  private let solar = Solar(latitude: 40.758899, longitude: -73.9873197)!

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    initializeTheme()
    return true
  }

  func initializeTheme() {
    if solar.isDaytime {
      Theme.current.apply()
      scheduleThemeTimer()
    } else {
      Theme.dark.apply()
    }
  }

  func scheduleThemeTimer() {
    let timer = Timer(fire: solar.sunset!, interval: 0, repeats: false) { [weak self] _ in
      Theme.dark.apply()

      self?.window?.subviews.forEach({ (view: UIView) in
        view.removeFromSuperview()
        self?.window?.addSubview(view)
      })
    }

    RunLoop.main.add(timer, forMode: RunLoopMode.commonModes)
  }
}
