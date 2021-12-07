//
//  Utils.swift
//  ImageLoadingIntoTableViewDemo
//  Utility class for abstracting the HUD library usage
//  Created by James Lane on 11/13/21.
//

import Foundation
import UIKit
import PKHUD

extension UIViewController {
    
    func showProgress() {
        PKHUD.sharedHUD.contentView = PKHUDProgressView(title: Constants.DOWNLOAD_TITLE, subtitle: nil)
        PKHUD.sharedHUD.show(onView: self.view)
    }
    
    func hideProgess() {
        
        PKHUD.sharedHUD.hide()
    }
    
    func flashDownloadError(seconds : Double) {
        
        PKHUD.sharedHUD.contentView = PKHUDErrorView(title: Constants.DOWNLOAD_ERROR_TITLE, subtitle: nil)
        PKHUD.sharedHUD.show(onView: self.view)
    }
}
