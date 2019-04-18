//
//  Reachable.swift
//  Reachability
//
//  Created by Roberto Guzman on 4/18/19.
//  Copyright © 2019 Fortytwo Sports. All rights reserved.
//

import Foundation
import UIKit

/*
 * ABOUT
 * Conform to the Rechable protocol to get notified when the there is a change in the device connectectivity.
 * To comply with the protocol, you must call the subscribeToReachableNotifications function
 */
public protocol Reachable {
    func connectionDidChange(message: String)
}

/*
 * ABOUT
 * Reachable supports ViewControllers
 * Subscribe to the Reachable Notifications by calling the subscribeToReachableNotifications function inside your viewDidLoad. This will allow your ViewController to receive the connectionDidChange function
 */
extension Reachable where Self : UIViewController {
    public func subscribeToReachableNotifications() {
        NotificationCenter.default.addObserver(forName: .flagsChanged, object: nil, queue: nil) {[weak self] (notification) in
            guard self != nil else { return }
            self?.statusManager(notification)
        }
    }
    
    public func unsubscribeToReachableNotifications() {
        NotificationCenter.default.removeObserver(self)
    }
    
    private func statusManager(_ notification: Notification) {
        var textToShow: String = ""
        switch Network.reachability.status {
        case .unreachable:
            textToShow = "The internet connection appears to be offline."
            break
        case .wwan:
            textToShow = "You are online!"
            break
        case .wifi:
            textToShow = "You are online!"
            break
        }
        print(self.description)
        connectionDidChange(message: textToShow)
    }
}
