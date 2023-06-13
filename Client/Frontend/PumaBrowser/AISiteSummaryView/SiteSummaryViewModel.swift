// This Source Code Form is subject to the terms of the Mozilla Public
// License, v. 2.0. If a copy of the MPL was not distributed with this
// file, You can obtain one at http://mozilla.org/MPL/2.0/

import SwiftUI

@MainActor
final class SiteSummaryViewModel: ObservableObject {
    @Published private(set) var isLoading = false
    @Published private(set) var summary: String?

    let siteURL: URL
    private let openAIClient: OpenAIClient

    init(siteURL: URL,
         openAIClient: OpenAIClient = OpenAIClientFactory.client) {
        self.siteURL = siteURL
        self.openAIClient = openAIClient
    }

    func fetchSummary() async {
        guard !isLoading else { return }
        isLoading = true
        do {
            self.summary = try await openAIClient.fetchSummary(siteURL)
        } catch {
            self.summary = "Failed to load summary for content from site: \(siteURL.absoluteString)"
        }
        isLoading = false
    }
}
