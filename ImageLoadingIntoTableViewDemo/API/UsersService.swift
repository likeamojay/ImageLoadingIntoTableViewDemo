//  UsersService.swift
//  Manager for retrieving the resulting JSON from a single API call to the StackOverflow Users Endpoint,
//  asynchronously downloading gravatar images, and
//  then providing the content in friendly struct formats
//  Created by James Lane on 11/13/21.
//

import Foundation
import UIKit

public class UsersService {
    
    // MARK: Singleton
    
    public static let shared = UsersService()
    
    private init() {}
    
    // MARK: Public properties
    
    public var users : [User]?
    
    //MARK: Private properties
    
    /* Cache to contain gravatar images that have already downloaded
     Key = account id Value = the gravatar image*/
    private var gravatarImageCache = [Int: UIImage]()
    
    /* Keep track of pending download requests to make sure we don't try to do simultaneous downloads for the same image. We use the unique url as the key */
    private var pendingDownloads = [URL : [(Result<UIImage,UserServiceError>) -> Void]]()
    
    // MARK: Public methods
    
    public func downloadGravatarImageFor(user : User, completion: @escaping (Result<UIImage,UserServiceError>) -> Void) {
        
        
        // If we've already donwloaded the image then don't do it again and return early
        if let image = self.gravatarImageCache[user.accountId] {
            DispatchQueue.main.async {
                // Let the screen know we're done
                completion(.success(image))
            }
            return
        }
        
        if let url = URL(string: user.gravatarImageUrl) {
            
            if pendingDownloads[url] != nil {
                pendingDownloads[url]?.append(completion)
                return // Exit out if we're already trying to download this image
            } else {
                pendingDownloads[url] = [completion] // Otherwise keep track of this task and go ahead
            }
            
            let task = URLSession.shared.dataTask(with: url) { data, response, imageDownloadError in
                
                guard let imageData = data, let image = UIImage(data: imageData),
                      let completionBlocks = self.pendingDownloads[url], imageDownloadError == nil else {
                        DispatchQueue.main.async {
                            completion(.failure(imageDownloadError as! UserServiceError))
                        }
                        return
                    }
                    // Save image to cache
                    self.gravatarImageCache[user.accountId] = image
                
                    // Iterate over any pending completion blocks and fire them off to let them know the image is downloaded and ready
                    for block in completionBlocks {
                        DispatchQueue.main.async {
                            block(.success(image))
                        }
                        
                        return
                    }
            }
            
            task.resume()
        }
        else
        {

            DispatchQueue.main.async {
                completion(.failure(UserServiceError.BadUrl))
            }
            
            return
        }
    }
    
    public func downloadUsers(completion : @escaping (_ success : Bool)-> Void) {

        if self.users == nil {
        
            if let url = URL(string: Constants.REQUEST_URL) {
                
                let task = URLSession.shared.dataTask(with: url) { data, response, downloadError in
                    
                    if downloadError == nil, let jsonData = data {

                        do {
                            
                            let userData = try JSONDecoder().decode(UserData.self, from: jsonData)
                            
                            self.users = userData.users
                           
                            // Let the screen know we're done
                            DispatchQueue.main.async {
                                completion(true)
                            }
                            
                            return
                        }
                        catch let parseError {
                            
                            print("Failed to decode JSON with error " + parseError.localizedDescription)
                            
                            // Let the screen know we're done
                            DispatchQueue.main.async {
                                completion(false)
                            }
            
                            return
                        }
                    }
                    else
                    {
                        // Let the screen know we're done
                        DispatchQueue.main.async {
                            completion(false)
                        }
                        
                        return
                    }
                }
                
                task.resume()
            }
        }
        else
        {
            // Already have data
            DispatchQueue.main.async {
                completion(true)
            }
        }
    }
}
