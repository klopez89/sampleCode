//
//  LocationMessagingCoordinator.swift
//  RunBuddy
//
//  Created by Kevin Lopez on 4/15/17.
//  Copyright © 2017 Kevin E Lopez. All rights reserved.
//

final class LocationMessagingCoordinator: Coordinator {

    var identifier: String = CoordinatorType.locationMessaging.rawValue

    var appContext: AppContext? = nil

    var appDataManager: AppDataManager

    var rootViewController: UIViewController

    var rootWindow: UIWindow?

    var childCoordinators: [String : Coordinator] = [:]

    weak var parentCoordinator: Coordinator?

    // custom property

    var locationMessagingController: LocationPermissionMessagingController?

    init(with details: CoordinatorDetails) {
        self.appContext = details.appContext
        self.appDataManager = details.appDataManager
        self.parentCoordinator = details.parentCoordinator
        self.rootViewController = details.rootViewController
    }

    func start(withCallback completion: CoordinatorCallback?) {
        guard let locationMessagingController = MainStoryboard.locationPermissionMessagingController,
            let mainTabBarNavController = rootViewController as? MainTabNavController,
            let mainTabBarController = mainTabBarNavController.viewControllers.last as? MainTabBarController else {
                return
        }

        self.locationMessagingController = locationMessagingController
        locationMessagingController.delegate = self
        locationMessagingController.configureViewWith(mainTabBarController.tabBar.bounds.height)

        mainTabBarController.view.addSubview(locationMessagingController.messagingView)
        locationMessagingController.animateMessagingToShow()
    }

    func stop(withCallback completion: CoordinatorCallback?) {
        locationMessagingController?.messagingView.removeFromSuperview()
        locationMessagingController = nil
        completion?(self)
    }
}

extension LocationMessagingCoordinator: LocationPermissionMessagingDelegate {

    func dismissMessaging() {
        locationMessagingController?.animateMessagingToHide({ [weak self] in
            self?.removeLocationPermissionMessaging()
        })
    }

    func ctaButtonPressed() {
        if CLLocationManager.authorizationStatus() == .notDetermined {
            appDataManager.locationManager.triggerLocationServices(.fuzzy)
        } else {
            guard let settingsURL = URL(string: UIApplicationOpenSettingsURLString) else { return }
            UIApplication.shared.open(settingsURL, options: [:], completionHandler: nil)
        }
    }

    func removeLocationPermissionMessaging() {
        parentCoordinator?.stop(coordinatorWithIdentifier: identifier, callback: nil)
    }
}
