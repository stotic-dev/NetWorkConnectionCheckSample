//
//  ConnectionStatusModel.swift
//  NetWorkConnectionCheckSample
//
//  Created by 佐藤汰一 on 2023/06/21.
//

import Foundation
import Combine

enum ConnectionTarget: String {
    case wifi
    case mobileData
    case other
    case unConnect
}

class ConnectionStatusModel: ObservableObject{
    @Published var isConnection: Bool = false
    @Published var connectionTarget: ConnectionTarget = .unConnect
}
