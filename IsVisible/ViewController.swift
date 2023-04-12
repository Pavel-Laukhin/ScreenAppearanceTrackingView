//
//  ViewController.swift
//  IsVisible
//
//  Created by PAVEL LAUKHIN on 25.01.2023.
//

import UIKit

class ViewController: UIViewController {

    // MARK: - Constants for testing

    /// System under test
    var sut: InspectableView { view1 }

    /// A sufficient proportion of the visible part of the view for the view to be considered as shown
    var intersectionTargetRatio: Double { 0.8 }

    // MARK: - Private Properties

    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView().toAutoLayout()
        scrollView.backgroundColor = .systemBlue
        scrollView.delegate = self
        return scrollView
    }()

    private let stackView: UIStackView = {
        let stackView = UIStackView().toAutoLayout()
        stackView.axis = .vertical
        return stackView
    }()

    private let view1 = InspectableView(color: .red)
    private let view2 = InspectableView(color: .green)
    private let view3 = InspectableView(color: .blue)
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

    private func updateShowStatus() {
        let sutFrameOnWindow = scrollView.convert(sut.frame, to: nil)
        let sutArea = sut.frame.area // 90_000
        let targetArea = Int(Double(sutArea) * intersectionTargetRatio)

        let intersectionArea = keyWindow?.frame.intersection(sutFrameOnWindow).area ?? 0

        // You can comment next 2 lines in order
        // to print just the log of grey views show statuses
        print("\n\(sut.name) intersectionArea:", intersectionArea) // max 90_000
        print("\(sut.name) isShown:", intersectionArea > targetArea) // true from 72_000 (80%)

        NotificationCenter.default.post(name: .needUpdateShowStatus, object: nil)
    }

    private func setupLayout() {
        view.addSubview(scrollView)
        scrollView.addSubview(stackView)

        stackView.addArrangedSubview(view1)
        stackView.addArrangedSubview(view2)
        stackView.addArrangedSubview(view3)
        stackView.addArrangedSubview(view4)

        NSLayoutConstraint.activate([
            view1.widthAnchor.constraint(equalToConstant: 300),
            view1.heightAnchor.constraint(equalToConstant: 300),

            view2.widthAnchor.constraint(equalToConstant: 300),
            view2.heightAnchor.constraint(equalToConstant: 300),

            view3.widthAnchor.constraint(equalToConstant: 300),
            view3.heightAnchor.constraint(equalToConstant: 300),

            view4.widthAnchor.constraint(equalToConstant: 300),
            view4.heightAnchor.constraint(equalToConstant: 300),

            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
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
        updateShowStatus()
    }
}
