//
//  LocationPermissionMessagingController.swift
//  RunBuddy
//
//  Created by Kevin Lopez on 12/3/16.
//  Copyright © 2016 Kevin E Lopez. All rights reserved.
//

protocol LocationPermissionMessagingDelegate: class {
    func dismissMessaging()
    func ctaButtonPressed()
}

class LocationPermissionMessagingController: UIViewController {
    @IBOutlet weak var allowButton: UIButton! {
        didSet {
            allowButton.apply(ButtonStyle.solid)
        }
    }
    @IBOutlet weak var dismissButton: UIButton! {
        didSet {
            dismissButton.imageView?.tintColor = ColorStyle.charcoal
        }
    }
    @IBOutlet weak var titleLable: UILabel! {
        didSet {
            titleLable.apply(TextStyle.header2.bold)
        }
    }
    @IBOutlet weak var messageLabel: UILabel! {
        didSet {
            messageLabel.apply(TextStyle.header1)
        }
    }

    @IBOutlet weak var locationImageView: UIImageView! {
        didSet {
            locationImageView.tintColor = ColorStyle.charcoal
        }
    }

    @IBOutlet weak var messagingView: LocationMessagingView!

    fileprivate var messagingViewVerticalOffset: CGFloat = 0.0

    weak var delegate: LocationPermissionMessagingDelegate?

    func configureViewWith(_ tabBarHeight: CGFloat) {
        view.setNeedsLayout()

        messagingView.translatesAutoresizingMaskIntoConstraints = true
        messagingView.backgroundColor = .white

        let viewOrigin = CGPoint(x: 0, y: screenHeight)
        let viewSize = CGSize(width: screenWidth, height: messagingView.frame.height)
        messagingView.frame = CGRect(origin: viewOrigin, size: viewSize)

        messagingViewVerticalOffset = screenHeight - tabBarHeight - messagingView.frame.height
    }

    func animateMessagingToShow() {
        UIView.animate(withDuration: 0.4, delay: 0.0, options: [], animations: { [weak self] in
            self?.messagingView.frame.origin.y = self?.messagingViewVerticalOffset ?? screenHeight
        }) { (finished) in
            TrackingManager.trackPresentation(LocationNagModalLabel.locationNagModal)
        }
    }

    func animateMessagingToHide(_ completion: @escaping () -> ()) {
        UIView.animate(withDuration: 0.4, delay: 0.0, options: [], animations: { [weak self] in
            self?.messagingView.frame.origin.y = screenHeight
            }) { (success) in
            completion()
        }
    }

    @IBAction func buttonPressed(_ sender: AnyObject) {
        TrackingManager.trackButtonPressFor(LocationNagModalLabel.allowLocationNagModal)
        delegate?.ctaButtonPressed()
    }

    @IBAction func dismissButtonPressed(_ sender: UIButton) {
        TrackingManager.trackButtonPressFor(LocationNagModalLabel.closeLocationNagModal)
        delegate?.dismissMessaging()
    }
}

class LocationMessagingView: UIView {
    var titleLabel: UILabel?
}
