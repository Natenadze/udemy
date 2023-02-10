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
    
    let loginViewController = LoginViewController()
    let onboardingContainerVC = OnboardingContainerVC()
    let mainVC = MainViewController()
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.backgroundColor = .systemBackground
        
        onboardingContainerVC.delegate = self
        loginViewController.delegate = self
        
        displayLogin()
        
        return true
    }
    
    private func displayLogin() {
        setRootVC(loginViewController)
    }
    
    private func displayNextScreen() {
        if LocalState.hasOnboarded {
            prepMainView()
            setRootVC(mainVC)
        } else {
            setRootVC(onboardingContainerVC)
        }
    }
    
    private func prepMainView() {
        mainVC.setStatusBar()
        UINavigationBar.appearance().isTranslucent = false
        UINavigationBar.appearance().backgroundColor = appColor
    }
    
}


extension AppDelegate: LoginViewControllerDelegate {
    func didLogin() {
      displayNextScreen()
    }
}

extension AppDelegate: OnboardingContainerVCDelegate {
    func didFinishOnboarding() {
        LocalState.hasOnboarded = true
        prepMainView()
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
