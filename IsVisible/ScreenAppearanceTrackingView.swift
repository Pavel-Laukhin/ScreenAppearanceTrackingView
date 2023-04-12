//
//  ScreenAppearanceTrackingView.swift
//  IsVisible
//
//  Created by PAVEL LAUKHIN on 13.04.2023.
//

import UIKit

public protocol ScreenAppearanceTrackingView: UIView {
    /// A sufficient proportion of the visible part of the view for the view to be considered as shown
    var visiblePercentThreshold: Double { get }
    var onVisiblePercentReached: (() -> Void)? { get }
    var firstScrollViewOrSuperview: UIView? { get }

    func handleScreenAppearanceUpdate(
        completion: (_ isShown: Bool, _ visibleArea: Int, _ area: Int) -> Void
    )
}

public extension ScreenAppearanceTrackingView {
    var visiblePercentThreshold: Double { return 0.8 }
    var onVisiblePercentReached: (() -> Void)? { return nil }
    var firstScrollViewOrSuperview: UIView? {
        return findFirstScrollViewOrSuperview()
    }

    func handleScreenAppearanceUpdate(
        completion: (_ isShown: Bool, _ visibleArea: Int, _ area: Int) -> Void
    ) {
        let frameOnWindow = superview?.convert(frame, to: nil) ?? .zero
        let superviewFrameOnWindow = firstScrollViewOrSuperview?.superview?
            .convert(firstScrollViewOrSuperview?.frame ?? .zero, to: nil) ?? .zero
        let intersectionSuperviewWithWindow = keyWindow?.frame.intersection(superviewFrameOnWindow)

        let area = frame.area
        let targetArea = Int(Double(area) * visiblePercentThreshold)
        let visibleArea = intersectionSuperviewWithWindow?.intersection(frameOnWindow).area ?? 0

        let isVisiblePercentReached = visibleArea > targetArea
        if isVisiblePercentReached {
            onVisiblePercentReached?()
        }

        completion(isVisiblePercentReached, visibleArea, area)
    }
}

// MARK: - UIView + findFirstScrollViewOrSuperview

public extension UIView {

    func findFirstScrollViewOrSuperview() -> UIView? {
        var view = self
        while let superview = view.superview {
            if let scrollView = superview as? UIScrollView {
                return scrollView
            }
            view = superview
        }
        return self.superview
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
