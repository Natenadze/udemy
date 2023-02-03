//
//  ViewController.swift
//  Bankey
//
//  Created by Davit Natenadze on 02.02.23.
//

import UIKit

class LoginViewController: UIViewController {
    
    let mainTitleLabel = UILabel()
    let subTitleLabel = UILabel()
    let loginView = LoginView()
    let signInButton = UIButton(type: .system)
    let errorMessageLabel = UILabel()
    
    var username: String? {
        loginView.userNameTextField.text
    }
    var password: String? {
        loginView.passwordTextField.text
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
    }
    
}

// MARK: - Actions
extension LoginViewController {
    
    @objc func signInTapped(sender: UIButton) {
//        errorMessageLabel.isHidden = true
        login()
    }
    
    private func login() {
        guard let username, let password else {
            return
        }
        
        if username.isEmpty || password.isEmpty {
            configure(with: "Username/Password cannot be blank")
        }else if username == "Davit" && password == "123456" {
            signInButton.configuration?.showsActivityIndicator = true
        }else {
            configure(with: "Incorrect username / password")
        }
    }
    
    private func configure(with message: String) {
        errorMessageLabel.isHidden = false
        errorMessageLabel.text = message
    }
}

// MARK: - Style and Layouts

extension LoginViewController {
    
    private func style() {
        loginView.translatesAutoresizingMaskIntoConstraints = false
        
        // - mainTitleLabel -
        mainTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        mainTitleLabel.font = .preferredFont(forTextStyle: .headline)
        mainTitleLabel.textAlignment = .center
        mainTitleLabel.text = "Bankey"
        mainTitleLabel.font = UIFont.systemFont(ofSize: 32)
        
        // - subTitleLabel -
        subTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        subTitleLabel.font = .preferredFont(forTextStyle: .subheadline)
        subTitleLabel.numberOfLines = 0
        subTitleLabel.textAlignment = .center
        subTitleLabel.text = "Your premium source for all things banking!"
        subTitleLabel.font = UIFont.systemFont(ofSize: 22)
        
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
    
    private func layout() {
        view.addSubview(mainTitleLabel)
        view.addSubview(subTitleLabel)
        view.addSubview(loginView)
        view.addSubview(signInButton)
        view.addSubview(errorMessageLabel)
        
        NSLayoutConstraint.activate([
            
            // - mainTitleLabel -
            mainTitleLabel.bottomAnchor.constraint(equalTo: subTitleLabel.topAnchor, constant: -5),
            mainTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mainTitleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mainTitleLabel.heightAnchor.constraint(equalToConstant: 40),
            
            // - subtitleLabel -
            subTitleLabel.bottomAnchor.constraint(equalTo: loginView.topAnchor, constant: -20),
            subTitleLabel.leadingAnchor.constraint(equalTo: loginView.leadingAnchor),
            subTitleLabel.trailingAnchor.constraint(equalTo: loginView.trailingAnchor),
            subTitleLabel.heightAnchor.constraint(equalToConstant: 75),
            
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


