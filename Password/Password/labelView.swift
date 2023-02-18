//
//  labelView.swift
//  Password
//
//  Created by Davit Natenadze on 18.02.23.
//

import Foundation

import UIKit

class LabelView: UIView {
    
    let label = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        style()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    

    
}

extension LabelView {
    
    func style() {
        translatesAutoresizingMaskIntoConstraints = false
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.text = " Use at leasat 3 of these 4 criteria when setting your password"
        label.numberOfLines = 0
        
    }
    
    func layout() {
        addSubview(label)
        
        label.frame = bounds
        
//        NSLayoutConstraint.activate([
//            label.topAnchor.constraint(equalTo: topAnchor),
//            label.bottomAnchor.constraint(equalTo: bottomAnchor),
//            label.leadingAnchor.constraint(equalTo: leadingAnchor),
//            label.trailingAnchor.constraint(equalTo: trailingAnchor),
//        ])
        
    }
}
