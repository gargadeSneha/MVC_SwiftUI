//
//  TextField.swift
//  MVC_SwiftUI
//
//  Created by Sneha Gargade on 21/02/24.
//

import SwiftUI

struct CustomTextField: View {
    var placeholder: String
       @Binding var text: String

    var body: some View {
        TextField(placeholder, text: $text)
            .border(.gray, width: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)
            .frame(width: 340, height: 50)
            .background(Color.white)
            .cornerRadius(5)
        

    }

}
