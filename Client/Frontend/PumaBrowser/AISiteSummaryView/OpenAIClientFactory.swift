// This Source Code Form is subject to the terms of the Mozilla Public
// License, v. 2.0. If a copy of the MPL was not distributed with this
// file, You can obtain one at http://mozilla.org/MPL/2.0/

import Foundation

struct OpenAIClientFactory {
    private struct OpenAI {
        struct Config {
            static let apiKey: String = {
                guard let apiKey = PumaConfig.OpenAI.apiKey else {
                    assertionFailure("Failed to read OpenAI API Key")
                    return "missing api key"
                }
                return apiKey
            }()
        }

        struct Completions {
            /// Using OpenAPI Completions
            /// https://platform.openai.com/docs/api-reference/completions
            /// summary prompt = TLDR:URL
            static let pathURL = URL(string: "https://api.openai.com/v1/completions")!

            struct Request: Encodable {
                let model = "text-davinci-003"
                let max_tokens = 700
                let temperature = 0
                let prompt: String

                init(url: URL) {
                    self.prompt = "TLDR:\(url.absoluteString)"
                }
            }

            struct Response: Decodable {
                let id: String
                let choices: [Choice]

                struct Choice: Decodable {
                    let text: String
                }
            }
        }
    }

    static var client: OpenAIClient {
        OpenAIClient { url in
            var request = URLRequest(url: OpenAI.Completions.pathURL)
            request.httpMethod = "POST"
            request.setValue("Bearer \(OpenAI.Config.apiKey)",
                             forHTTPHeaderField: "Authorization")
            request.setValue("application/json",
                             forHTTPHeaderField: "Content-Type")
            request.setValue("application/json",
                             forHTTPHeaderField: "Accept")
            let httpBody = OpenAI.Completions.Request(url: url)
            let httpBodyData = try JSONEncoder().encode(httpBody)
            request.httpBody = httpBodyData
            let (data, _) = try await URLSession.shared.data(for: request)
            let response = try JSONDecoder().decode(
                OpenAI.Completions.Response.self,
                from: data)
            guard let summary = response.choices.first?.text else {
                assertionFailure("Failed to fetch summary for site: \(url)")
                // So far I think this situation cannot happen.
                // But in case it happens, it will be obvious in debug.
                return "Failed to summarize site content."
            }
            return summary
        }
    }
}
