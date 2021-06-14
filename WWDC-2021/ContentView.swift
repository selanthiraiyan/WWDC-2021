//
//  ContentView.swift
//  WWDC-2021
//
//  Created by Sharma Elanthiraiyan on 13/06/21.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = ContentViewModel()
    
    var body: some View {
        Text(viewModel.title)
            .padding()
            .onAppear {
                viewModel.onAppear()
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
