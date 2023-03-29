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
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: columns) {
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
        }

        .onAppear(perform: retrieveData)
    }
    
    func retrieveData() {
        guard let url = URL(string: Configuration.agenciesEndpoint) else {
            fatalError("Invalid Federal Register Endpoint")
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error  in
            let agencyData = try! JSONDecoder().decode([Agency].self, from: data!)
            
            DispatchQueue.main.async {
                agencies = agencyData
                print(agencies[0].url)
            }
        }.resume()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
