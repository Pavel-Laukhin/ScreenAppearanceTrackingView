//
//  ViewController.swift
//  IsVisible
//
//  Created by PAVEL LAUKHIN on 25.01.2023.
//

import UIKit

class ViewController: UIViewController {

    // MARK: - Private Properties

    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView().toAutoLayout()
        scrollView.backgroundColor = .systemYellow
        scrollView.delegate = self
        return scrollView
    }()

    private let stackView: UIStackView = {
        let stackView = UIStackView().toAutoLayout()
        stackView.axis = .vertical
        return stackView
    }()

    private let view0 = InspectableView(color: .systemCyan, name: "Cyan").toAutoLayout()
    private let view1 = InspectableView(color: .systemRed, name: "Red")
    private let view2 = InspectableView(color: .systemGreen, name: "Green")
    private let view3 = InspectableView(color: .blue, name: "Blue")
    private let view4 = ViewWithScroll()

    /// To prevent automatic triggering of the scrollViewDidScroll method at start
    private var isDidScrollMethodCallAllowed = false

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setupLayout()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        isDidScrollMethodCallAllowed = true
        scrollViewDidScroll(scrollView)
    }

    // MARK: - Private Methods

    private func setupLayout() {
        view.addSubview(view0)
        view.addSubview(scrollView)
        scrollView.addSubview(stackView)

        stackView.addArrangedSubview(view1)
        stackView.addArrangedSubview(view2)
        stackView.addArrangedSubview(view3)
        stackView.addArrangedSubview(view4)

        NSLayoutConstraint.activate([
            view0.widthAnchor.constraint(equalToConstant: 250),
            view0.heightAnchor.constraint(equalToConstant: 120),

            view1.widthAnchor.constraint(equalToConstant: 300),
            view1.heightAnchor.constraint(equalToConstant: 300),

            view2.widthAnchor.constraint(equalToConstant: 300),
            view2.heightAnchor.constraint(equalToConstant: 300),

            view3.widthAnchor.constraint(equalToConstant: 300),
            view3.heightAnchor.constraint(equalToConstant: 300),

            view4.widthAnchor.constraint(equalToConstant: 300),
            view4.heightAnchor.constraint(equalToConstant: 300),

            view0.topAnchor.constraint(equalTo: view.topAnchor),
            view0.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            view0.bottomAnchor.constraint(equalTo: scrollView.topAnchor),

            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.widthAnchor.constraint(equalTo: view.widthAnchor),

            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor)
        ])
    }
}

// MARK: - UIScrollViewDelegate

extension ViewController: UIScrollViewDelegate {

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard isDidScrollMethodCallAllowed else { return }
        NotificationCenter.default.post(name: .screenAppearanceDidChange, object: nil)
    }
}

// MARK: - UIView + toAutoLayout

public extension UIView {
    func toAutoLayout() -> Self {
        translatesAutoresizingMaskIntoConstraints = false
        return self
    }
}

// MARK: - Notification.Name

public extension Notification.Name {
    static let screenAppearanceDidChange = Notification.Name("ScreenAppearanceDidChange")
}
