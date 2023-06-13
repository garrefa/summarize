// This Source Code Form is subject to the terms of the Mozilla Public
// License, v. 2.0. If a copy of the MPL was not distributed with this
// file, You can obtain one at http://mozilla.org/MPL/2.0/

import SwiftUI
import Shared

struct SiteSummaryView: View {
    @StateObject var viewModel: SiteSummaryViewModel
    @State private var textColor: Color = .clear

    // Theming
    @Environment(\.themeType)
    var themeVal

    var body: some View {
        VStack {
            Spacer()
            if let summary = viewModel.summary {
                Text(summary)
                    .padding()
            } else if viewModel.isLoading {
                ProgressView()
                Text("Loading summary...")
                    .padding(.top, 18)
            }
            Spacer()
        }
        .foregroundColor(textColor)
        .padding()
        .onAppear {
            applyTheme(theme: themeVal.theme)
            Task {
                await viewModel.fetchSummary()
            }
        }.onChange(of: themeVal) { newValue in
            applyTheme(theme: newValue.theme)
        }
    }

    func applyTheme(theme: Theme) {
        let color = theme.colors
        textColor = Color(color.textPrimary)
    }
}
