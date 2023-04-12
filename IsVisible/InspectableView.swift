//
//  InspectableView.swift
//  IsVisible
//
//  Created by PAVEL LAUKHIN on 26.01.2023.
//

import UIKit

class InspectableView: UIView {
    let name: String

    init(color: UIColor, name: String? = nil) {
        self.name = name ?? String(describing: color.accessibilityName).capitalized
        super.init(frame: .zero)
        backgroundColor = color
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
