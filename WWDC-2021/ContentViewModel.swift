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
    func downloadText() async -> String {
        debugPrint("Downloading text...")
        do {
            let (_, response) = try await URLSession.shared.data(from: URL(string: "https://www.google.com/")!, delegate: nil)
            guard let response = response as? HTTPURLResponse else {
                return "No response"
            }
            return "\(response.statusCode)"
        } catch {
            return "Error occured"
        }
    }
    
    func onAppear() {
        debugPrint("onAppear")
        async {
            let text = await downloadText()
            DispatchQueue.main.sync {
                title = text
            }
        }
    }
}
