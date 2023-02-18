//
//  ViewController.swift
//  Password
//
//  Created by Davit Natenadze on 17.02.23.
//

import UIKit

class ViewController: UIViewController {
    
    let stackView = UIStackView()
    
    let passwordTextField = PasswordTextField(placeHolderText: "New password")
    let criteriaView = PasswordCriteriaView(text: "8-32 characters (no spaces)")
    let labelView = LabelView()
    let sampleView2 = PasswordCriteriaView(text: "uppercase letter (A-Z)")
    let sampleView3 = PasswordCriteriaView(text: "lowercase (a-z)")
    let sampleView4 = PasswordCriteriaView(text: "digit (0-9)")
    let sampleView5 = PasswordCriteriaView(text: "special character (e.g. !@#$%^)")

    
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
    }
    

}

// MARK: - Style & Layout -

extension ViewController {
    
    
    func style() {
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 20

    }
    
    func layout() {
        view.addSubview(stackView)
        stackView.addArrangedSubview(passwordTextField)
        stackView.addArrangedSubview(criteriaView)
        stackView.addArrangedSubview(labelView)
        stackView.addArrangedSubview(sampleView2)
        stackView.addArrangedSubview(sampleView3)
        stackView.addArrangedSubview(sampleView4)
        stackView.addArrangedSubview(sampleView5)
        
        NSLayoutConstraint.activate([
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 2),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: stackView.trailingAnchor, multiplier: 2)
        ])
        
    }
}
