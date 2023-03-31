//
//  ContentView.swift
//  FederalRegisterData
//
//  Created by Brent Busby on 3/28/23.
//

import SwiftUI

struct ContentView: View {
    let offlineMessage = "There was an error retrieving the data.\n Either the service is down, or you are not connected to wifi or a mobile network.\n Try again later."
    let columns = [
        GridItem(.adaptive(minimum: 300))
    ]
    @State var agencies = [Agency]()
    @State var connectionError = false
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: columns) {
                    Divider()
                    if (self.connectionError) {
                        Section {
                            Text(offlineMessage)
                                .frame(width: 330)
                                .foregroundColor(.red)
                                .font(.headline)
                                .multilineTextAlignment(.leading)
                                .padding(10)
                        }.border(.red)
                    }
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
