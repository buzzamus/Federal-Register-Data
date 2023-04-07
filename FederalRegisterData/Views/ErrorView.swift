//
//  ErrorView.swift
//  FederalRegisterData
//
//  Created by Brent Busby on 4/2/23.
//

import Foundation
import SwiftUI


struct ErrorView: View {
    let errorMessage: String
    
    var body: some View {
        Section {
            Text(errorMessage)
                .frame(width: 330)
                .foregroundColor(.red)
                .font(.headline)
                .multilineTextAlignment(.leading)
                .padding(10)
        }.border(.red)
    }
}
