//
//  ReachabilityView.swift
//  Reachability
//
//  Created by Roberto Guzman on 4/18/19.
//  Copyright © 2019 Fortytwo Sports. All rights reserved.
//

import Foundation
import UIKit

/*
 * ABOUT
 * Conform to the ReachabilityView protocol to create a custom view that you can use along with the ReachabilityManager.
 * To use a custom view, conform your view to the ReachabilityView protocol and use the ReachabilityViewDelegate to communicate with the ReachabilityManager
 */
public protocol ReachabilityView: UIView {
    var delegate: ReachabilityViewDelegate?  { get set }
    
    func showView()
    func hideView()
    func loadMessage(message: String?)
}


/*
 * ABOUT
 * Create a ReachabilityViewDelegate property inside your ReachabilityView to community with the ReachabilityManager.
 * The ReachabilityManager conforms to the ReachabilityViewDelegate in order to listen to your ReachabilityView
 *
 * IMPLEMENTAITON
 * var delegate: ReachabilityViewDelegate?
 * delegate?.reachabilityViewDidShow()
 */
public protocol ReachabilityViewDelegate {
    func reachabilityViewDidShow()
    func reachabilityViewDidHide()
}
