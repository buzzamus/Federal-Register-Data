//
//  DocumentsView.swift
//  FederalRegisterData
//
//  Created by Brent Busby on 4/6/23.
//

import SwiftUI

struct DocumentsView: View {
    var documents = [Document]()
    @State var showWebView = false
    var body: some View {
        ForEach(documents) { document in
            VStack {
                Text(document.title)
                    .font(.headline)
                Button {
                    showWebView.toggle()
                } label: {
                    Text("Read Full Article")
                        .font(.headline)
                }
                .sheet(isPresented: $showWebView) {
                    WebView(url: URL(string: document.body_html_url)!)
                }
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 20)
            .padding(.horizontal, 5)
            .background(.regularMaterial)
            .clipShape(RoundedRectangle(cornerRadius: 10))
        }
    }
}

struct DocumentsView_Previews: PreviewProvider {
    static var previews: some View {
        DocumentsView()
    }
}
