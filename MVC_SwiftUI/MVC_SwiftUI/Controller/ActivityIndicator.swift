//
//  ActivityIndicator.swift
//  MVC_SwiftUI
//
//  Created by Sneha Gargade on 22/02/24.
//

import SwiftUI

struct ActivityIndicator: View {
    @State private var isLoadingData = true // State variable to track loading
    let data = ["Item 1", "Item 2", "Item 3", "Item 4", "Item 5"]
    var body: some View {
        VStack{
            if isLoadingData {
                ProgressView("Loading...") // Display ProgressView while loading
            } else {
                List {
                    ForEach(data, id: \.self) { item in
                            Text(item)
                       
                    }
                }
            }
        }
    }
}

#Preview {
    ActivityIndicator()
}
