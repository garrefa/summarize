// This Source Code Form is subject to the terms of the Mozilla Public
// License, v. 2.0. If a copy of the MPL was not distributed with this
// file, You can obtain one at http://mozilla.org/MPL/2.0/

import UIKit
import Shared
import Common
import SwiftUI

final class SiteSummaryViewController: UIViewController, Themeable {
    var themeManager: ThemeManager
    var themeObserver: NSObjectProtocol?
    var notificationCenter: NotificationProtocol

    private var summaryViewController: UIHostingController<SiteSummaryView>

    // MARK: Lifecycle

    init(themeManager: ThemeManager = AppContainer.shared.resolve(),
         notificationCenter: NotificationProtocol = NotificationCenter.default,
         viewModel: SiteSummaryViewModel) {
        self.themeManager = themeManager
        self.notificationCenter = notificationCenter
        self.summaryViewController = UIHostingController(
            rootView: SiteSummaryView(viewModel: viewModel))
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        viewSetup()
        listenForThemeChange(view)
        applyTheme()
    }

    func viewSetup() {
        guard let summaryView = summaryViewController.view else { return }
        summaryView.translatesAutoresizingMaskIntoConstraints = false

        addChild(summaryViewController)
        view.addSubview(summaryView)

        NSLayoutConstraint.activate([
            summaryView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            summaryView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            summaryView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            summaryView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
        ])
    }

    func applyTheme() {
        let theme = themeManager.currentTheme
        view.backgroundColor = theme.colors.layer1
    }
}
