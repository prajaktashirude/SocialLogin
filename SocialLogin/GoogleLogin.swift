//
//  GoogleLogin.swift
//  SocialLogin
//
//  Created by Apple on 04/11/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import Foundation
import GoogleSignIn
import UIKit

public protocol  GoogleLoginDelegate: class {
    func didSignInToGoogle()
    func diddidDisconnectWithGoogle()
    func didSignOutFromGoogle()
}

public class GoogleLogin: NSObject {

    public static let shared =  GoogleLogin()
    public weak var delegate: GoogleLoginDelegate?


    private override init(){}

    public func setClientID(clientID: String) {
       GIDSignIn.sharedInstance().clientID = clientID
       GIDSignIn.sharedInstance().delegate = self
    }

    public func handleGoogleSignIn(url: URL) -> Bool {
        return GIDSignIn.sharedInstance().handle(url)
    }

    public func getGoogleSignInObj() -> GIDSignIn {
        return GIDSignIn.sharedInstance()
    }

    public func getGoogleCurrentUser() -> GIDGoogleUser? {
        return GIDSignIn.sharedInstance()?.currentUser
    }

    public func getLoginButton() -> GIDSignInButton {
        return GIDSignInButton()
    }

    public func setPresentingViewController(vc: UIViewController) {
        GIDSignIn.sharedInstance().presentingViewController = vc
    }

    public func signOutFromGoogle() {
        GIDSignIn.sharedInstance().signOut()
        self.delegate?.didSignOutFromGoogle()
    }
}

extension GoogleLogin: GIDSignInDelegate {
    public func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!,
    withError error: Error!) {
        self.delegate?.didSignInToGoogle()
    }

    public func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!,
    withError error: Error!) {
        self.delegate?.diddidDisconnectWithGoogle()
    }
}

