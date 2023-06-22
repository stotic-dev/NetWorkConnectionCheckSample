//
//  NetWorkConnectionCheckSampleApp.swift
//  NetWorkConnectionCheckSample
//
//  Created by 佐藤汰一 on 2023/06/21.
//

import SwiftUI

@main
struct NetWorkConnectionCheckSampleApp: App {
    
    var viewModel = ConnectionStatusModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(viewModel)
                .onAppear{
                    NetworkMng.shared.createObservable { status in
                        
                        DispatchQueue.main.async {
                            
                            switch status{
                            case .satisfied:
                                viewModel.isConnection = true
                                break
                                
                            case .unsatisfied,.requiresConnection:
                                viewModel.isConnection = false
                                break
                                
                            @unknown default:
                                fatalError("receive unnown connect status")
                            }
                        }
                        
                    }
                    NetworkMng.shared.startObserveConnection()
                }
        }
    }
}
