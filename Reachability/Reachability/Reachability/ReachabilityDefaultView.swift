//
//  ReachabilityDefaultView.swift
//  Reachability
//
//  Created by Roberto Guzman on 4/18/19.
//  Copyright © 2019 Fortytwo Sports. All rights reserved.
//

import Foundation
import UIKit

/*
 * ABOUT
 * ReachabilityDefaultView is the default view used by the ReachabilityManager
 * It conforms to the ReachabilityView protocol
 */
class ReachabilityDefaultView: UIView {
    
    lazy var messageLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height))
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .white
        label.textAlignment = .left
        return label
    }()

    var delegate: ReachabilityViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: UI
    
    private func setupSubViews() {
        backgroundColor = .darkGray
        attachSubViews()
        setupConstraints()
    }
    
    private func attachSubViews() {
        addSubview(messageLabel)
    }
    
    private func setupConstraints() {
        addConstraintsWithFormat(format: "H:|-20-[v0]-20-|", views: messageLabel)
        addConstraintsWithFormat(format: "V:|[v0]|", views: messageLabel)
    }
}

extension ReachabilityDefaultView: ReachabilityView {
    
    func loadMessage(message: String?) {
        if let newMessage = message {
            messageLabel.text = newMessage
        }
    }
    
    func showView() {
        UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 0, options: [.curveEaseIn], animations: {
           self.frame.origin.y = UIScreen.main.bounds.maxY - self.frame.size.height
        }, completion: { (true) in
            self.delegate?.reachabilityViewDidShow()
        })
    }
    
    func hideView() {
        UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 0, options: [.curveEaseIn], animations: {
            self.frame.origin.y = UIScreen.main.bounds.maxY
        }, completion: { (true) in
            self.delegate?.reachabilityViewDidHide()
        })
    }
}
