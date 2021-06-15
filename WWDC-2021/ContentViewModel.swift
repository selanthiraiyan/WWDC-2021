//
//  ContentViewModel.swift
//  WWDC-2021
//
//  Created by Sharma Elanthiraiyan on 13/06/21.
//

import Foundation
import SwiftUI
import Combine

final class ContentViewModel: ObservableObject {
    @Published private(set) var title: String = "Test"
    
    func download(from url: URL) async throws -> String {
        let (_, response) = try await URLSession.shared.data(from: url, delegate: nil)
        guard let response = response as? HTTPURLResponse else {
            return "No response"
        }
        return "\(response.statusCode)"
    }
    
    func downloadText() async throws -> String {
        debugPrint("Downloading text...")
        let fromGoogle = try await download(from: URL(string: "https://www.google.com/")!)
        let fromFB = try await download(from: URL(string: "https://www.facebook.com/")!)
        let fromTwitter = try await download(from: URL(string: "https://www.twitter.com/")!)
        return fromGoogle + " " + fromFB + " " + fromTwitter
    }
    
    func onAppear() {
        debugPrint("onAppear")
        async {
            do {
                let text = try await downloadText()
                DispatchQueue.main.sync {
                    title = text
                }
            } catch {
                DispatchQueue.main.sync {
                    title = "Error occured"
                }
            }
        }
    }
}
