//
//  ContentView.swift
//  NetWorkConnectionCheckSample
//
//  Created by 佐藤汰一 on 2023/06/21.
//

import SwiftUI


struct ContentView: View {
    @EnvironmentObject var viewModel: ConnectionStatusModel
    
    var body: some View {
        
        VStack {
            connectionStatusImage
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text(viewModel.isConnection ? viewModel.connectionTarget.rawValue : "not connect")
        }
        .padding()
    }
    
    var connectionStatusImage: some View {
        Image(systemName: viewModel.isConnection ? "wifi" : "wifi.slash")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(ConnectionStatusModel())
    }
}
