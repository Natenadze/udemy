//
//  ViewController.swift
//  Bankey
//
//  Created by Davit Natenadze on 02.02.23.
//

import UIKit

protocol LogoutDelegate: AnyObject {
    func didLogout()
}

protocol LoginViewControllerDelegate: AnyObject {
    func didLogin()
}

class LoginViewController: UIViewController {
    
    let mainTitleLabel = UILabel()
    let subTitleLabel = UILabel()
    let loginView = LoginView()
    let signInButton = UIButton(type: .system)
    let errorMessageLabel = UILabel()
    
    weak var delegate: LoginViewControllerDelegate?
    
    var username: String? {
        loginView.userNameTextField.text
    }
    var password: String? {
        loginView.passwordTextField.text
    }
    
    // MARK: - animations
    var leadingEdgeOnScreen: CGFloat = 16
    var leadingEdgeOffScreen: CGFloat = -1000
    
    var titleLeadingAnchor: NSLayoutConstraint?
    var subTitleLeadingAnchor: NSLayoutConstraint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        animate()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        signInButton.configuration?.showsActivityIndicator = false
    }
    
}

// MARK: - Actions
extension LoginViewController {
    
    @objc func signInTapped(sender: UIButton) {
        login()
    }
    
    private func login() {
        guard let username, let password else {
            return
        }
        
        if username.isEmpty || password.isEmpty {
            configure(with: "Username/Password cannot be blank")
        }else if username == "A" && password == "a" {
            
            signInButton.configuration?.showsActivityIndicator = true
            delegate?.didLogin()
        }else {
            configure(with: "Incorrect username / password")
        }
    }
    
    private func configure(with message: String) {
        errorMessageLabel.isHidden = false
        errorMessageLabel.text = message
        shakeButton()
    }
    
    
    // MARK: - Shake animation
    
    private func shakeButton() {
        let animation = CAKeyframeAnimation()
        animation.keyPath = "position.x"
        animation.values = [0, 10, -10, 10, 0]
        animation.keyTimes = [0, 0.16, 0.5, 0.83, 1]
        animation.duration = 0.3

        animation.isAdditive = true
        signInButton.layer.add(animation, forKey: "shake")
    }
}

// MARK: - Style and Layouts

extension LoginViewController {
    
    private func style() {
        loginView.translatesAutoresizingMaskIntoConstraints = false
        
        // - mainTitleLabel -
        mainTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        mainTitleLabel.font = .preferredFont(forTextStyle: .largeTitle)
        mainTitleLabel.textAlignment = .center
        mainTitleLabel.adjustsFontForContentSizeCategory = true   // adjust font for diff screen sizes
        mainTitleLabel.text = "Bankey"
        mainTitleLabel.alpha = 0
        
        // - subTitleLabel -
        subTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        subTitleLabel.font = .preferredFont(forTextStyle: .title3)
        subTitleLabel.numberOfLines = 0
        subTitleLabel.textAlignment = .center
        subTitleLabel.adjustsFontForContentSizeCategory = true   // adjust font for diff screen sizes
        subTitleLabel.text = "Your premium source for all things banking!"
        
        // - signInButton -
        signInButton.translatesAutoresizingMaskIntoConstraints = false
        signInButton.configuration = .filled()
        signInButton.configuration?.imagePadding = 7  // space for activity indicator
        signInButton.setTitle("Sign in", for: [])
        signInButton.addTarget(self, action: #selector(signInTapped), for: .primaryActionTriggered)
        
        // - errorMessageLabel -
        errorMessageLabel.translatesAutoresizingMaskIntoConstraints = false
        errorMessageLabel.textColor = .systemRed
        errorMessageLabel.textAlignment = .center
        errorMessageLabel.numberOfLines = 0
        errorMessageLabel.isHidden = true
        
    }
    
    // MARK: - Auto Layout
    
    private func layout() {
        view.addSubview(mainTitleLabel)
        view.addSubview(subTitleLabel)
        view.addSubview(loginView)
        view.addSubview(signInButton)
        view.addSubview(errorMessageLabel)
        
        
        NSLayoutConstraint.activate([
            mainTitleLabel.bottomAnchor.constraint(equalTo: subTitleLabel.topAnchor, constant: -6),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: mainTitleLabel.trailingAnchor, multiplier: 2)
        ])
        
        // For animation
        titleLeadingAnchor = mainTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: leadingEdgeOffScreen)
        titleLeadingAnchor?.isActive = true
        
        NSLayoutConstraint.activate([
            subTitleLabel.bottomAnchor.constraint(equalTo: loginView.topAnchor, constant: -50),
            subTitleLabel.trailingAnchor.constraint(equalTo: loginView.trailingAnchor)
        ])
        
        // For Animation
        subTitleLeadingAnchor = subTitleLabel.leadingAnchor.constraint(equalTo: loginView.leadingAnchor, constant: leadingEdgeOffScreen)
        subTitleLeadingAnchor?.isActive = true
        
        NSLayoutConstraint.activate([
            // - loginView -
            loginView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            loginView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 1),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: loginView.trailingAnchor, multiplier: 1),
            
            // -  signInButton -
            signInButton.topAnchor.constraint(equalToSystemSpacingBelow: loginView.bottomAnchor, multiplier: 2),
            signInButton.leadingAnchor.constraint(equalTo: loginView.leadingAnchor),
            signInButton.trailingAnchor.constraint(equalTo: loginView.trailingAnchor),
            signInButton.heightAnchor.constraint(equalToConstant: 45),
            
            // - errorMessageLabel -
            errorMessageLabel.topAnchor.constraint(equalToSystemSpacingBelow: signInButton.bottomAnchor, multiplier: 0.5),
            errorMessageLabel.leadingAnchor.constraint(equalTo: loginView.leadingAnchor),
            errorMessageLabel.trailingAnchor.constraint(equalTo: loginView.trailingAnchor),
            errorMessageLabel.heightAnchor.constraint(equalToConstant: 35)
        ])
        
    }
}


// MARK: - Animations

extension LoginViewController {
    private func animate() {
        let animator1 = UIViewPropertyAnimator(duration: 1, curve: .easeInOut) {
            self.titleLeadingAnchor?.constant = self.leadingEdgeOnScreen
            self.view.layoutIfNeeded()
        }
        animator1.startAnimation()
        
        // Same code, but second animation comes with delay
        let animator2 = UIViewPropertyAnimator(duration: 1, curve: .easeInOut) {
            self.subTitleLeadingAnchor?.constant = self.leadingEdgeOnScreen
            self.view.layoutIfNeeded()
        }
        animator2.startAnimation(afterDelay: 0.3)
        
        // alpha changing animation for no reason ))
        let animator3 = UIViewPropertyAnimator(duration: 1, curve: .easeInOut) {
            self.mainTitleLabel.alpha = 1
            self.view.layoutIfNeeded()
        }
        animator3.startAnimation(afterDelay: 1)
        
    }
}
