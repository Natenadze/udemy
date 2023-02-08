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
    let dummyVC = DummyVC()
    let mainVC = MainViewController()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.backgroundColor = .systemBackground
        
        dummyVC.logoutDelegate = self
        onboardingContainerVC.delegate = self
        loginViewController.delegate = self
//        window?.rootViewController = loginViewController
        window?.rootViewController = mainVC
        //        window?.rootViewController = onboardingContainerVC
        //        window?.rootViewController = OnboardingVC()
        
        mainVC.selectedIndex = 0  // When view appears, we select here which tab bar to show
        return true
    }
    
}


extension AppDelegate: LoginViewControllerDelegate {
    func didLogin() {
        if LocalState.hasOnboarded {
            setRootVC(dummyVC)
        }else {
            setRootVC(onboardingContainerVC)
        }
    }
}

extension AppDelegate: OnboardingContainerVCDelegate {
    func didFinishOnboarding() {
        LocalState.hasOnboarded = true
        setRootVC(dummyVC)
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
