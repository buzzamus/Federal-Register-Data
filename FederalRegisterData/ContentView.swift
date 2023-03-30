//
//  ContentView.swift
//  FederalRegisterData
//
//  Created by Brent Busby on 3/28/23.
//

import SwiftUI

struct ContentView: View {
    let columns = [
        GridItem(.adaptive(minimum: 300))
    ]
    @State var agencies = [Agency]()
    @State var connectionError = false
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: columns) {
                    Text(offlineMessage())
                        .foregroundColor(.red)
                    ForEach(agencies) { agency in
                        NavigationLink {
                            AgencyView(agency: agency)
                        } label: {
                            VStack {
                                Text(agency.name)
                                    .font(.title)
                                    .multilineTextAlignment(.center)
                            }
                            .padding(.vertical)
                            .frame(maxWidth: .infinity)
                        }
                        Divider()
                    }
                }
                .padding([.horizontal, .bottom])
            }
            .navigationTitle("Federal Register Data").font(.title)
            .preferredColorScheme(.dark)
            .task {
                await retrieveData()
            }
        }
    }
    
    func offlineMessage() -> String {
        if self.connectionError {
            return "There was an error retrieving the data"
        } else {
            return ""
        }
    }
    
    func retrieveData() async {
        guard let url = URL(string: Configuration.agenciesEndpoint) else {
            fatalError("Invalid Federal Register Endpoint")
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            
            if let agencyData = try? JSONDecoder().decode([Agency].self, from: data) {
                agencies = agencyData
            }
        } catch {
            print("Error Retrieving Data")
            connectionError = true
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
