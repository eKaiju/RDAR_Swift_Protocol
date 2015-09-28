//
//  AppDelegate.swift
//  rdarForDidSetSwiftBug
//
//  Created by Bussiere, Mathieu on 2015-09-15.
//  Copyright © 2015 La Presse. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // test rdarValidator
        let validator = DidSetValidator()
        validator.validateDirectClassWithUnwrap()
        validator.validateDirectClassWithOptional()
        validator.validateProtocolImplementationWithUnwrap()
        validator.validateProtocolImplementationWithOptional()
        return true
    }
}

