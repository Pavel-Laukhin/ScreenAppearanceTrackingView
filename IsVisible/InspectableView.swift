//
//  InspectableView.swift
//  IsVisible
//
//  Created by PAVEL LAUKHIN on 26.01.2023.
//

import UIKit

class InspectableView: UIView, ScreenAppearanceTrackingView {

    // MARK: - Public Properties

    var onVisiblePercentReached: (() -> Void)? {
        return { [weak self] in
            guard let self else { return }
            // uncomment next line before release
            // NotificationCenter.default.removeObserver(self)
        }
    }

    // MARK: - Private Properties

    private let name: String

    // MARK: - Initializers

    init(color: UIColor, name: String? = nil) {
        self.name = name ?? String(describing: color.accessibilityName).capitalized
        super.init(frame: .zero)
        backgroundColor = color

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(handleScreenAppearanceUpdate),
            name: .screenAppearanceDidChange,
            object: nil
        )
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Private Methods

    @objc private func handleScreenAppearanceUpdate() {
        // Uncomment next line to see the log about 1 view only
        // guard name == "Blue" else { return }

        handleScreenAppearanceUpdate { [weak self] (isShown, visibleArea, area) -> Void in
            self?.printToConsole(isShown: isShown, visibleArea: visibleArea, area: area)
        }

    }
}

// MARK: - Print to console

extension InspectableView {
    private func printToConsole(isShown: Bool, visibleArea: Int, area: Int) {
        let isShownStatus = "\(isShown)".padding(
            toLength: 5,
            withPad: " ",
            startingAt: 0
        )
        let visibleAreaPercent = Int(ceil(Double(visibleArea) / Double(area) * 100))
        print(
            colorIcon,
            name.padding(toLength: 5, withPad: " ", startingAt: 0),
            "isShown: \(isShownStatus)", isShown ? "✅" : "❌",
            "visibleArea: ",
            "\(visibleAreaPercent)%"
        )
    }

    private var colorIcon: String {
        switch name {
        case "Cyan": return "🔷"
        case "Red": return "🟥"
        case "Blue": return "🟦"
        case "Green": return "🟩"
        case "Gray1": return "⬛️"
        case "Gray2": return "⬜️"
        case "Gray3": return "◻️"
        default: return "▫️"
        }
    }
}
