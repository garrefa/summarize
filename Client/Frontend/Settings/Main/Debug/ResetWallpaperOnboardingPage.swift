// This Source Code Form is subject to the terms of the Mozilla Public
// License, v. 2.0. If a copy of the MPL was not distributed with this
// file, You can obtain one at http://mozilla.org/MPL/2.0/

import Foundation
import Shared

class ResetWallpaperOnboardingPage: HiddenSetting, FeatureFlaggable {
    override var title: NSAttributedString? {
        let seenStatus = UserDefaults.standard.bool(forKey: PrefsKeys.Wallpapers.OnboardingSeenKey) ? "seen" : "unseen"
        return NSAttributedString(string: "Reset wallpaper onboarding sheet (\(seenStatus))",
                                  attributes: [NSAttributedString.Key.foregroundColor: theme.colors.textPrimary])
    }

    override func onClick(_ navigationController: UINavigationController?) {
        UserDefaults.standard.set(false, forKey: PrefsKeys.Wallpapers.OnboardingSeenKey)
        updateCell(navigationController)
    }
}
