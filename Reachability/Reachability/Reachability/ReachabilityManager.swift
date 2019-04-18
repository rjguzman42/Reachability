//
//  ReachabilityManager.swift
//  Reachability
//
//  Created by Roberto Guzman on 4/18/19.
//  Copyright © 2019 Fortytwo Sports. All rights reserved.
//

import Foundation
import UIKit

/*
 * IMPLEMENTATION
 * EX1:
 * let reachabilityManager = ReachabilityManager.shared
 *
 * EX2:
 * let reachabilityManager = ReachabilityManager.shared
 * let testView = ReachabilityView()
 * reachabilityManager.setUpWith(view: testView)
 *
 *
 * PURPOSE
 * Handles all changes in network connectivity and displays a message to the user accordingly
 * To use a custom view, conform your view to the ReachabilityView protocol and use the ReachabilityViewDelegate to communicate with the ReachabilityManager
 */

public class ReachabilityManager {
    public static let shared = ReachabilityManager()
    
    lazy var defaultView: ReachabilityDefaultView = {
        let height: CGFloat = UIScreen.main.bounds.size.height / 14
        let view = ReachabilityDefaultView(frame: CGRect(x: 0, y: UIScreen.main.bounds.maxY, width: UIScreen.main.bounds.size.width, height: height))
        return view
    }()
    var reachabilityView: ReachabilityView?
    var timer: Timer?
    
    private init() {
        setupNetworkReachability()
        setupWithDefaultView()
        subscribeToNotifications()
    }
    
    deinit {
        unsubscribeToNotifications()
    }
    
    
    //MARK: Public Methods
    
    //display the default ReachabilityDefaultView
    public func setupWithDefaultView() {
        setupWith(view: defaultView)
    }
    
    //display a custom view that conforms to the ReachabilityView protocol
    public func setupWith(view: ReachabilityView) {
        reachabilityView = view
        reachabilityView?.delegate = self
    }
    
    
    //MARK: Network Connections
    
    private func setupNetworkReachability() {
        do {
            try Network.reachability = Reachability(hostname: "www.google.com")
        }
        catch {
            switch error as? Network.Error {
            case let .failedToCreateWith(hostname)?:
                print("Network error:\nFailed to create reachability object With host named:", hostname)
            case let .failedToInitializeWith(address)?:
                print("Network error:\nFailed to initialize reachability object With address:", address)
            case .failedToSetCallout?:
                print("Network error:\nFailed to set callout")
            case .failedToSetDispatchQueue?:
                print("Network error:\nFailed to set DispatchQueue")
            case .none:
                print(error)
            }
        }
    }
    
    
    //MARK: Notifications
    
    private func subscribeToNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(statusManager), name: .flagsChanged, object: nil)
    }
    
    private func unsubscribeToNotifications() {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func statusManager(_ notification: Notification) {
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
        showTemporaryMessage(textToShow)
    }
    
    
    //MARK: Actions
    
    fileprivate func showTemporaryMessage(_ message: String = "") {
        guard reachabilityView != nil else { return }
        reachabilityView?.loadMessage(message: message)
        attachView()
        startTimer()
        reachabilityView?.showView()
    }
    
    fileprivate func attachView() {
        guard reachabilityView != nil else { return }
        if let appDelegate = UIApplication.shared.delegate as UIApplicationDelegate? {
            appDelegate.window??.addSubview(reachabilityView!)
            appDelegate.window??.windowLevel = UIWindow.Level.statusBar + 1
        }
    }
    
    fileprivate func removeView() {
        reachabilityView?.removeFromSuperview()
        if let appDelegate = UIApplication.shared.delegate as UIApplicationDelegate? {
            appDelegate.window??.windowLevel = UIWindow.Level.statusBar - 1
        }
    }
    
    fileprivate func startTimer() {
        if #available(iOS 10.0, *) {
            timer = Timer.scheduledTimer(withTimeInterval: 4.0, repeats: false) {[weak self] (timer) in
                guard self != nil else { return }
                self?.reachabilityView?.hideView()
            }
        } else {
            // Fallback on earlier versions
        }
    }
}

extension ReachabilityManager: ReachabilityViewDelegate {
    public func reachabilityViewDidShow() {
        
    }
    
    public func reachabilityViewDidHide() {
        removeView()
    }
}

extension ReachabilityManager: CustomStringConvertible {
    public var description: String {
        var output: String = ""
        output.append("Reachability Summary")
        output.append("\nStatus:" + Network.reachability.status.rawValue)
        output.append("\nHostName:" + (Network.reachability.hostname ?? "nil"))
        output.append("\nReachable:" + Network.reachability.isReachable.description)
        output.append("\nWifi:" + Network.reachability.isReachableViaWiFi.description)
        return  output
    }
}
