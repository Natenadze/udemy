//
//  LocalState.swift
//  Bankey
//
//  Created by Davit Natenadze on 07.02.23.
//

import Foundation


public class LocalState {
    
    private enum Keys: String {
        case hasOnboarded
    }
    
    public static var hasOnboarded: Bool {
        get {
            UserDefaults.standard.bool(forKey: Keys.hasOnboarded.rawValue)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: Keys.hasOnboarded.rawValue)
            UserDefaults.standard.synchronize()
            // synchronize, to immediately write any changes made to the UserDefaults to disk. This ensures that the updated value is persisted even if the app is terminated
        }
    }
}
