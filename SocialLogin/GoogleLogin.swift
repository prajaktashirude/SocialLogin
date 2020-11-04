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

protocol  GoogleLoginDelegate: class {
    func didSignInToGoogle()
    func diddidDisconnectWithGoogle()
    func didSignOutFromGoogle()
    func didSignInToFacebook()
    func didSignOutFromFaceBook()
    func didSignInTwitter()
    func didSignOutTwitter()
}

class GoogleLogin: NSObject {

    static let shared =  GoogleLogin()
    weak var delegate: GoogleLoginDelegate?


    private override init(){}

    func setClientID(clientID: String) {
       GIDSignIn.sharedInstance().clientID = clientID
       GIDSignIn.sharedInstance().delegate = self
    }

    func handleGoogleSignIn(url: URL) -> Bool {
        return GIDSignIn.sharedInstance().handle(url)
    }

    func getGoogleSignInObj() -> GIDSignIn {
        return GIDSignIn.sharedInstance()
    }

    func getGoogleCurrentUser() -> GIDGoogleUser? {
        return GIDSignIn.sharedInstance()?.currentUser
    }

    func getLoginButton() -> GIDSignInButton {
        return GIDSignInButton()
    }

    func setPresentingViewController(vc: UIViewController) {
        GIDSignIn.sharedInstance().presentingViewController = vc
    }

    func signOutFromGoogle() {
        GIDSignIn.sharedInstance().signOut()
        self.delegate?.didSignOutFromGoogle()
    }
}

extension GoogleLogin: GIDSignInDelegate {
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!,
    withError error: Error!) {
        self.delegate?.didSignInToGoogle()
    }

    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!,
    withError error: Error!) {
        self.delegate?.diddidDisconnectWithGoogle()
    }
}

