//
//  PasswordView.swift
//  Password
//
//  Created by Davit Natenadze on 17.02.23.
//

import UIKit

class PasswordTextField: UIView {
    
    let lockImageView = UIImageView(image: UIImage(systemName: "lock.fill"))
    let textField = UITextField()
    let eyeButton = UIButton(type: .custom)
    let dividerView = UIView()
    let errorLabel = UILabel()
    
    let placeHolderText: String
    
    
    
    init(placeHolderText: String) {
        self.placeHolderText  = placeHolderText
        
        super.init(frame: .zero)  // in order to call 'super.init', first,  we need to initialize every instance of a variable, defined in the class
        
        style()
        layout()
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var intrinsicContentSize: CGSize {
        CGSize(width: 200, height: 60)
    }
    
    
}

extension PasswordTextField {
    func style() {
        translatesAutoresizingMaskIntoConstraints = false
        
        // lockImageView
        lockImageView.translatesAutoresizingMaskIntoConstraints = false
        
        // textField
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.isSecureTextEntry = false
        textField.placeholder = placeHolderText
        textField.delegate = self
        // preventing emojis to be used
        textField.keyboardType = .asciiCapable
        // to set custom color for placeholder text
        textField.attributedPlaceholder = NSAttributedString(string: placeHolderText, attributes: [NSAttributedString.Key.foregroundColor: UIColor.secondaryLabel])
        
        // eyeImageView
        eyeButton.translatesAutoresizingMaskIntoConstraints = false
        eyeButton.setImage(UIImage(systemName: "eye.circle"), for: .normal)
        eyeButton.setImage(UIImage(systemName: "eye.slash.circle"), for: .selected)
        eyeButton.addTarget(self, action: #selector(togglePasswordView), for: .touchUpInside)
        
        // divider
        dividerView.translatesAutoresizingMaskIntoConstraints = false
        dividerView.backgroundColor = .separator
        
        // errorLabel
        errorLabel.translatesAutoresizingMaskIntoConstraints = false
        errorLabel.text = "Your password must meet the requirements below"
        errorLabel.textColor = .systemRed
        errorLabel.font = .preferredFont(forTextStyle: .body)
//        errorLabel.adjustsFontSizeToFitWidth = true  // Reduce font size if needed
//        errorLabel.minimumScaleFactor = 0.8   // but until minimum 80% of original size

        errorLabel.numberOfLines = 0 // if we want to make it multiline
        errorLabel.lineBreakMode = .byWordWrapping  // doesn't split the word
        errorLabel.isHidden = false

        
    }
    
    func layout() {
        addSubview(lockImageView)
        addSubview(textField)
        addSubview(eyeButton)
        addSubview(dividerView)
        addSubview(errorLabel)
        
        
        NSLayoutConstraint.activate([
            // lockImageView
            lockImageView.centerYAnchor.constraint(equalTo: textField.centerYAnchor),
            lockImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            lockImageView.widthAnchor.constraint(equalToConstant: 20),
            
            // textField
            textField.topAnchor.constraint(equalTo: topAnchor),
            textField.leadingAnchor.constraint(equalToSystemSpacingAfter: lockImageView.trailingAnchor, multiplier: 1),
            
            // eyeImageView
            eyeButton.leadingAnchor.constraint(equalToSystemSpacingAfter: textField.trailingAnchor, multiplier: 1),
            eyeButton.trailingAnchor.constraint(equalTo: trailingAnchor),
            eyeButton.centerYAnchor.constraint(equalTo: textField.centerYAnchor),
            
            // divider
            dividerView.heightAnchor.constraint(equalToConstant: 1),
            dividerView.topAnchor.constraint(equalToSystemSpacingBelow: textField.bottomAnchor, multiplier: 1),
            dividerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            dividerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            // errorLabel
            errorLabel.topAnchor.constraint(equalTo: dividerView.bottomAnchor, constant: 4),
            errorLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            errorLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
        
        // CHCR
//         doesn't stretch
        lockImageView.setContentHuggingPriority(UILayoutPriority.defaultHigh, for: .horizontal)
        // textfield stretches (defaultlow)
        textField.setContentHuggingPriority(UILayoutPriority.defaultLow, for: .horizontal)
        // doesn't stretch (high)
        eyeButton.setContentHuggingPriority(UILayoutPriority.defaultHigh, for: .horizontal)

       
        
    }
}

extension PasswordTextField {
    @objc func togglePasswordView(_ sender: Any) {
        textField.isSecureTextEntry.toggle()
        eyeButton.isSelected.toggle()
    }
}

extension PasswordTextField: UITextFieldDelegate {
    
}
