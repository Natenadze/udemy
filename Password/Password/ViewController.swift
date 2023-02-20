//
//  ViewController.swift
//  Password
//
//  Created by Davit Natenadze on 17.02.23.
//

import UIKit

class ViewController: UIViewController {
    
    typealias CustomValidation = PasswordTextField.CustomValidation
    
    let stackView = UIStackView()
    
    let newPasswordTextField = PasswordTextField(placeHolderText: "New password")
    let statusView = PasswordStatusView()
    let confirmPasswordTextField = PasswordTextField(placeHolderText: "Re-enter new password")
    let resetButton = UIButton(type: .system)
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()   // dismiss keyboard on tap
        style()
        layout()
    }
    
    private func setupDismissKeyboardGesture() {
        let dismissKeyboardTap = UITapGestureRecognizer(target: self, action: #selector(viewTapped(_: )))
        view.addGestureRecognizer(dismissKeyboardTap)
    }
    
    @objc func viewTapped(_ recognizer: UITapGestureRecognizer) {
        view.endEditing(true) // resign first responder
    }
    
    
}

// MARK: - Style & Layout -

extension ViewController {
    
    func setup() {
        setupNewPassword()
        setupConfirmPassword()
        setupDismissKeyboardGesture()
        setupKeyboardHiding()
    }
    
    // MARK: - Keyboard show up settings
    
    private func setupKeyboardHiding() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
   // solution 1 ?
//    @objc func keyboardWillShow(sender: NSNotification) {
//        view.frame.origin.y = view.frame.origin.y - 200
//    }
//
    @objc func keyboardWillHide(notification: NSNotification) {
        view.frame.origin.y = 0
    }
    
    @objc func keyboardWillShow(sender: NSNotification) {
        guard let userInfo = sender.userInfo,
              let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue,
              let currentTextField = UIResponder.currentFirst() as? UITextField else { return }
        
        // check if the top of the keyboard is above the bottom of the currently focused textbox
        let keyboardTopY = keyboardFrame.cgRectValue.origin.y
        
        // to convert 1 coordinate system into another
        let convertedTextFieldFrame = view.convert(currentTextField.frame, from: currentTextField.superview)
        let textFieldBottomY = convertedTextFieldFrame.origin.y + convertedTextFieldFrame.size.height

        // if textField bottom is below keyboard bottom - bump the frame up
        if textFieldBottomY > keyboardTopY {
            let textBoxY = convertedTextFieldFrame.origin.y
            let newFrameY = (textBoxY - keyboardTopY / 2) * -1
            view.frame.origin.y = newFrameY
        }

    }
   
    
    
    // typealias CustomValidation = (_ textValue: String?) -> (Bool, String)?
    
    private func setupNewPassword() {
        
        let newPasswordValidation: CustomValidation = { text in
            
            // Empty text
            guard let text = text, !text.isEmpty else {
                self.statusView.reset()
                return (false, "Enter your password")
            }
            
            // Valid characters
            let validChars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789.,@:?!()$\\/#"
            let invalidSet = CharacterSet(charactersIn: validChars).inverted
            guard text.rangeOfCharacter(from: invalidSet) == nil else {
                self.statusView.reset()
                return (false, "Enter valid special chars (.,@:?!()$\\/#) with no spaces")
            }
            
            // Criteria met
            self.statusView.updateDisplay(text)
            if !self.statusView.validate(text) {
                return (false, "Your password must meet the requirements below")
            }
            
            
            return (true, "")
        }
        
        newPasswordTextField.customValidation = newPasswordValidation
    }
    
    // MARK: - Password Confirmation
    private func setupConfirmPassword() {
        let confirmPasswordValidation: CustomValidation = { text in
            guard let text = text, !text.isEmpty else {
                return (false, "Enter your password.")
            }

            guard text == self.newPasswordTextField.text else {
                return (false, "Passwords do not match.")
            }

            return (true, "")
        }

        confirmPasswordTextField.customValidation = confirmPasswordValidation
        confirmPasswordTextField.delegate = self
    }
    
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
         resetButton.addTarget(self, action: #selector(resetPasswordButtonTapped), for: .primaryActionTriggered)
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

// MARK: - PasswordTextField Delegate

extension ViewController: PasswordTextFieldDelegate {
    
    func editingChanged(_ sender: PasswordTextField) {
        statusView.updateDisplay(sender.textField.text ?? "")
        
    }
    
    func editingDidEnd(_ sender: PasswordTextField) {
        statusView.shouldResetCriteria = false
        if sender === newPasswordTextField {
            _ = newPasswordTextField.validate()
        } else if sender == confirmPasswordTextField {
            _ = confirmPasswordTextField.validate()
        }
    }
    
}


// MARK: Actions
extension ViewController {

    @objc func resetPasswordButtonTapped(sender: UIButton) {
        view.endEditing(true)

        let isValidNewPassword = newPasswordTextField.validate()
        let isValidConfirmPassword = confirmPasswordTextField.validate()

        if isValidNewPassword && isValidConfirmPassword {
            showAlert(title: "Success", message: "You have successfully changed your password.")
        }
    }

    private func showAlert(title: String, message: String) {
        let alert =  UIAlertController(title: "", message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))

        alert.title = title
        alert.message = message
        present(alert, animated: true, completion: nil)
    }
}
