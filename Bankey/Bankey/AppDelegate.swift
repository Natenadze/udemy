//
//  AppDelegate.swift
//  Bankey
//
//  Created by Davit Natenadze on 02.02.23.
//

import UIKit

let appColor: UIColor = .systemTeal

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    var loginViewController = LoginViewController()
    var onboardingContainerVC = OnboardingContainerVC()
    let mainVC = MainViewController()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.backgroundColor = .systemBackground
        
        onboardingContainerVC.delegate = self
        loginViewController.delegate = self

        let vc = mainVC
        vc.setStatusBar()
        
        UINavigationBar.appearance().isTranslucent = false
        UINavigationBar.appearance().backgroundColor = appColor
        window?.rootViewController = vc
        
        return true
    }
    
}


extension AppDelegate: LoginViewControllerDelegate {
    func didLogin() {
        if LocalState.hasOnboarded {
            setRootVC(mainVC)
        }else {
            setRootVC(onboardingContainerVC)
        }
    }
}

extension AppDelegate: OnboardingContainerVCDelegate {
    func didFinishOnboarding() {
        LocalState.hasOnboarded = true
        setRootVC(mainVC)
    }
}

extension AppDelegate: LogoutDelegate {
    func didLogout() {
        setRootVC(loginViewController)
    }
    
    
}

// MARK: -  for smooth transition between the Views
extension AppDelegate {
    func setRootVC(_ vc: UIViewController, animated: Bool = true) {
        guard animated, let window = self.window else {
            self.window?.rootViewController = vc
            self.window?.makeKeyAndVisible()
            return
        }
        window.rootViewController = vc
        window.makeKeyAndVisible()
        UIView.transition(with: window,
                          duration: 0.4,
                          options: .transitionCrossDissolve,
                          animations: nil,
                          completion: nil)
    }
}
