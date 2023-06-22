//
//  NetWorkMng.swift
//  NetWorkConnectionCheckSample
//
//  Created by 佐藤汰一 on 2023/06/21.
//

import Foundation
import Network
import Combine

class NetworkMng{
    
    static let shared = NetworkMng()
    
    private let nwMonitor = NWPathMonitor()
    
    private var cancelable: Set<AnyCancellable> = []
    
    private let connectionObserver: PassthroughSubject<NWPath.Status, Never> = PassthroughSubject()
    
    init() {}
    
    func startObserveConnection(){
        nwMonitor.pathUpdateHandler = {path in
            print("Connection Status is \(path.status)")
            print("Connection interfaces is \(path.availableInterfaces)")
            
            self.connectionObserver.send(path.status)
        }
        
        DispatchQueue.global(qos: .userInteractive).async {
            self.nwMonitor.start(queue: DispatchQueue.global(qos: .background))
            
            Thread.sleep(forTimeInterval: 0.05)
            
            print("---------- start NWMonitoring ----------")
            print("status: \(self.nwMonitor.currentPath.status)")
            print("availableInterfaces: \(self.nwMonitor.currentPath.availableInterfaces.reduce(""){"\($0),\($1)"})")
            print("----------------------------------------")
        }
        
    }
    
    func createObservable(receivedHandler: @escaping (NWPath.Status) -> Void){
        connectionObserver.sink { path in
            receivedHandler(path)
        }
        .store(in: &cancelable)
    }
    
    func endObserve(){
        for cancelItem in cancelable{
            cancelItem.cancel()
        }
        
        nwMonitor.cancel()
    }
}
