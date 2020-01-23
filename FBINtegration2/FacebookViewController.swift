//
//  FacebookViewController.swift
//  FBINtegration2
//
//  Created by R Shantha Kumar on 1/22/20.
//  Copyright © 2020 R Shantha Kumar. All rights reserved.
//

import UIKit
import FacebookCore
import FacebookLogin
import FacebookShare

class FacebookViewController: UIViewController,SharingDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    
    let imagePicker = UIImagePickerController()
    func sharer(_ sharer: Sharing, didCompleteWithResults results: [String : Any]) {
        print("share success")
    }
    
    func sharer(_ sharer: Sharing, didFailWithError error: Error) {
        print("sharing fail")
    }
    
    func sharerDidCancel(_ sharer: Sharing) {
        print("sharing cancel")
    }
    

    
    @IBOutlet weak var profile: UIImageView!
    
    @IBOutlet weak var fullName: UILabel!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
   
    override func viewWillAppear(_ animated: Bool) {
        
        let graphreg = GraphRequest(graphPath: "/me", parameters: ["fields" : "name,picture.width(400)"], tokenString: AccessToken.current?.tokenString, version: Settings.defaultGraphAPIVersion, httpMethod: .get)
        
        let connection = GraphRequestConnection()
        
        connection.add(graphreg) { (connection, value, error) in
            
            
            if let wholeData = value as? [String:Any]{
                
                
                let fullName = wholeData["name"] as! String
                
                let picture = wholeData["picture"] as! [String:Any]
                let pictureData = picture["data"] as! [String:Any]
                let pictureURL = pictureData["url"] as! String
                
                do{
                    
                    let url = URL(fileURLWithPath: pictureURL)
                    
                    let image5 = try Data(contentsOf: url)
                    let uiImage5 = UIImage(data: image5)
                    
                    
                    self.profile.image = uiImage5
                    
                    self.fullName.text = fullName
                    
                }
                
                
                catch{
                    print("asomething went wrong")
                    
                }
                
            }
            
            
            
            
            
        }
        connection.start()
        
    }
    
    
    @IBAction func shareLink(_ sender: Any) {
        let  sharedlink = ShareLinkContent()
        sharedlink.contentURL = URL(string: "http://google.com")!
        
        let haredDialog = ShareDialog(fromViewController:self, content: sharedlink, delegate: self)
        
        haredDialog.mode = .automatic
        haredDialog.show()
       
    
        
        
    }
    
    @IBAction func sahrePhoto(_ sender: Any) {
        
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        imagePicker.mediaTypes = ["public.image"]
        
        present(imagePicker, animated: true, completion: nil)
        
    }
    
    
    @IBAction func shareVideo(_ sender: Any) {
        
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        imagePicker.mediaTypes = ["public.image"]
        
        present(imagePicker, animated: true, completion: nil)
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage{
            
        }
        if let image2 = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            
             let url = URL(string: "fb://")
            
            if UIApplication.shared.canOpenURL(url!){
                
                
                let imageOn = SharePhoto(image: image2, userGenerated: true)
                
                let photoContent = SharePhotoContent()
                
                photoContent.photos = [imageOn]
            let sharedDialog = ShareDialog(fromViewController: self, content: photoContent, delegate: self)
                
                sharedDialog.mode = .automatic
                sharedDialog.show()
                
                
                
            }else
            {
                
                print("app not installed")
                
                
            }
            
            
            
        }
        else if let videoURL = info[UIImagePickerController.InfoKey.referenceURL] as? URL{
            
            let url2 = URL(string: "fb://")
            
            
            if UIApplication.shared.canOpenURL(url2!){
                
                
                let videoURL2 = ShareVideo(videoURL: url2!)
    
                let content = ShareVideoContent()
                
                content.video = videoURL2
                
                let sharedDialog = ShareDialog(fromViewController: self, content: content, delegate: self)
                
                sharedDialog.mode = .automatic
                sharedDialog.show()
                
                
                
            }
            
            
        }
        
        
        
    }

    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
