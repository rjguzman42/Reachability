//
//  Network.swift
//  Reachability
//
//  Created by Roberto Guzman on 4/18/19.
//  Copyright © 2019 Fortytwo Sports. All rights reserved.
//

import Foundation

struct Network {
    static var reachability: Reachability!
    enum Status: String {
        case unreachable, wifi, wwan
    }
    enum Error: Swift.Error {
        case failedToSetCallout
        case failedToSetDispatchQueue
        case failedToCreateWith(String)
        case failedToInitializeWith(sockaddr_in)
    }
}
