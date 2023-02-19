//
//  ViewController.swift
//  Password
//
//  Created by Davit Natenadze on 17.02.23.
//

import UIKit

class ViewController: UIViewController {
    
    let stackView = UIStackView()
    
    let newPasswordTextField = PasswordTextField(placeHolderText: "New password")
    let statusView = PasswordStatusView()
    let confirmPasswordTextField = PasswordTextField(placeHolderText: "Re-enter new password")
    let resetButton = UIButton(type: .system)


    
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
    }
    

}

// MARK: - Style & Layout -

extension ViewController {
    
    
    func style() {
        newPasswordTextField.translatesAutoresizingMaskIntoConstraints = false
        newPasswordTextField.delegate = self
        
        // stackView
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 20
//        stackView.distribution = .equalSpacing

        // statusView
        statusView.layer.cornerRadius = 6
        stackView.clipsToBounds = true
        
        // confirmPasswordTextField
        confirmPasswordTextField.translatesAutoresizingMaskIntoConstraints = false
        
        // reset Button
        resetButton.translatesAutoresizingMaskIntoConstraints = false
        resetButton.configuration = .filled()
        resetButton.setTitle("Reset password", for: [])
        // resetButton.addTarget(self, action: #selector(resetPasswordButtonTapped), for: .primaryActionTriggered)
    }
    
    func layout() {
        view.addSubview(stackView)
        stackView.addArrangedSubview(newPasswordTextField)
        stackView.addArrangedSubview(statusView)
        stackView.addArrangedSubview(confirmPasswordTextField)
        stackView.addArrangedSubview(resetButton)
   
        
        NSLayoutConstraint.activate([
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 2),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: stackView.trailingAnchor, multiplier: 2)
        ])
        
    }
}


extension ViewController: PasswordTextFieldDelegate {
    func editingChanged(_ sender: PasswordTextField) {
        statusView.updateDisplay(sender.textField.text ?? "")
    }
    

}
