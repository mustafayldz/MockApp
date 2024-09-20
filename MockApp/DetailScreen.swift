//
//  DetailScreen.swift
//  MockApp
//
//  Created by Mustafa yıldiz on 2024-09-20.
//

import Foundation
import SwiftUI

struct DetailScreen: View {
    var body: some View {
        VStack {
            Text("This is a new screen").font(.largeTitle).padding()
            
            Text("More content can go here.")
        }
        .navigationTitle("Detail Page")
    }
}

#Preview {
    DetailScreen()
}
