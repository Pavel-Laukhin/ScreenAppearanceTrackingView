//
//  ViewWithScroll.swift
//  IsVisible
//
//  Created by PAVEL LAUKHIN on 25.01.2023.
//

import UIKit

class ViewWithScroll: UIView {

    // MARK: - Private Properties

    private let scrollView = UIScrollView().toAutoLayout()
    private let stackView = UIStackView().toAutoLayout()
    
    private let view1 = InspectableView(color: .systemGray, name: "Gray1")
    private let view2 = InspectableView(color: .systemGray2, name: "Gray2")
    private let view3 = InspectableView(color: .systemGray3, name: "Gray3")
    private let view4 = InspectableView(color: .systemGray4, name: "Gray4")

    private var notShownViewsArray: [InspectableView] =  []

    // MARK: - Initializers

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Private Methods

    private func setup() {
        scrollView.delegate = self

        addSubview(scrollView)
        scrollView.addSubview(stackView)

        stackView.addArrangedSubview(view1)
        stackView.addArrangedSubview(view2)
        stackView.addArrangedSubview(view3)
        stackView.addArrangedSubview(view4)

        [
            view1,
            view2,
            view3,
            view4
        ].forEach {
            notShownViewsArray.append($0)
        }

        NSLayoutConstraint.activate([
            view1.widthAnchor.constraint(equalToConstant: 120),
            view1.heightAnchor.constraint(equalToConstant: 300),

            view2.widthAnchor.constraint(equalToConstant: 120),
            view2.heightAnchor.constraint(equalToConstant: 300),

            view3.widthAnchor.constraint(equalToConstant: 120),
            view3.heightAnchor.constraint(equalToConstant: 300),

            view4.widthAnchor.constraint(equalToConstant: 120),
            view4.heightAnchor.constraint(equalToConstant: 300),

            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.widthAnchor.constraint(equalTo: widthAnchor),

            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor)
        ])
    }

}

// MARK: - UIScrollViewDelegate

extension ViewWithScroll: UIScrollViewDelegate {

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        NotificationCenter.default.post(name: .screenAppearanceDidChange, object: nil)
    }
}
