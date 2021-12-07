//
//  UserTableViewCell.swift
//  ImageLoadingIntoTableViewDemo
//
//  Created by James Lane on 11/13/21.
//

import UIKit

class UserTableViewCell : UITableViewCell {
    
    // MARK: IBOutlets
    
    @IBOutlet var gravatarImageView: UIImageView!
    @IBOutlet var ImageLoadingIndicatorView: UIActivityIndicatorView!
    @IBOutlet var UsernameLabel: UILabel!
    
    // MARK: Private properties
    
    var profileUrlString : String?
    
    // MARK: Lifecycle
    
    override func prepareForReuse() {
        self.gravatarImageView.image = nil
        self.ImageLoadingIndicatorView.startAnimating()
    }
    
    public func SetupCellFor(user : User)
    {
        self.UsernameLabel.text = user.username
        self.profileUrlString = user.profileUrl
        
        UsersService.shared.downloadGravatarImageFor(user: user) { result in
            
            do {
                self.ImageLoadingIndicatorView.stopAnimating()
                self.gravatarImageView.image = try result.get()
            }
            catch let error {
                print(String(describing:error))
            }
        }
    }
    
    //MARK: IBActions
    
    @IBAction func didTapGoToProfileButton(_ sender: Any) {
        
        if let profileUrl = self.profileUrlString, let url = URL(string: profileUrl) {
            UIApplication.shared.open(url)
        }
    }
}
