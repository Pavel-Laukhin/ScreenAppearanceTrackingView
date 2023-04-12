//
//  Extensions.swift
//  IsVisible
//
//  Created by PAVEL LAUKHIN on 12.04.2023.
//

import UIKit

// MARK: - UIView + toAutoLayout

public extension UIView {
    func toAutoLayout() -> Self {
        translatesAutoresizingMaskIntoConstraints = false
        return self
    }
}


// MARK: - CGRect + area

public extension CGRect {
    var area: Int {
        Int(width * height)
    }
}

// MARK: - UIResponder + keyWindow

public extension UIResponder {
    var keyWindow: UIWindow? {
        UIApplication
            .shared
            .connectedScenes
            .flatMap { ($0 as? UIWindowScene)?.windows ?? [] }
            .first(where: { $0.isKeyWindow })
    }
}

// MARK: - Notification.Name

public extension Notification.Name {
    static let needUpdateShowStatus = Notification.Name("needUpdateShowStatus")
}
