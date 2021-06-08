//
//  ExtensionImagePickerOption.swift
//  RoundTheTable
//
//  Created by nirzar on 29/05/18.
//  Copyright © 2018 . All rights reserved.
//


import SystemConfiguration
import MobileCoreServices
import Photos

protocol ChoosePicture {
    func takeAndChoosePhoto()
    func takeAndChooseVideo()
    func takePhoto()
    func takeVideo()
    func choosePhotoAndVideo(isPhoto : Bool,isVideo : Bool)
}

extension ChoosePicture where Self: UIViewController ,Self: UIImagePickerControllerDelegate , Self : UINavigationControllerDelegate {
    
    func alertPromptToAllowPhotoAccessViaSetting() {
        
        let alert = UIAlertController(title: nil, message: AlertMessage.msgPhotoLibraryPermission, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .default))
        alert.addAction(UIAlertAction(title: "Setting", style: .cancel) { (alert) -> Void in
            UIApplication.shared.open(URL(string:UIApplication.openSettingsURLString)!, options: [:], completionHandler: nil)
            DispatchQueue.main.async {
                _ = self.navigationController?.popViewController(animated: true)
            }
        })
        present(alert, animated: true)
    }
    
    func alertPromptToAllowCameraAccessViaSetting() {
        let alert = UIAlertController(title: nil, message: AlertMessage.msgCameraPermission, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .default))
        alert.addAction(UIAlertAction(title: "Setting", style: .cancel) { (alert) -> Void in
            UIApplication.shared.open(URL(string:UIApplication.openSettingsURLString)!, options: [:], completionHandler: nil)
            DispatchQueue.main.async {
                _ = self.navigationController?.popViewController(animated: true)
            }
        })
        present(alert, animated: true)
    }
    
    func takeAndChoosePhoto() {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let btnCancel = UIAlertAction(title: "Cancel", style: .cancel, handler: {(action: UIAlertAction) -> Void in
            //  UIAlertController will automatically dismiss the view
        })
        let btnTakePhoto = UIAlertAction(title: "Take Photo", style: .default, handler: {(action: UIAlertAction) -> Void in
            self.takePhoto()
        })
        let btnChooseExisting = UIAlertAction(title: "Choose Photo", style: .default, handler: {(_ action: UIAlertAction) -> Void in
            self.choosePhotoAndVideo(isPhoto: true, isVideo: false)
        })
        
        alert.addAction(btnCancel)
        alert.addAction(btnTakePhoto)
        alert.addAction(btnChooseExisting)
        
        //alert.view.tintColor = UIColor.black
        alert.popoverPresentationController?.sourceView = self.view //for iPad
        present(alert, animated: true)
        //present(alert, animated: true, completion: nil)
    }
    
    func takeAndChooseVideo() {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let btnCancel = UIAlertAction(title: "Cancel", style: .cancel, handler: {(action: UIAlertAction) -> Void in
            //  UIAlertController will automatically dismiss the view
        })
        let btnTakePhoto = UIAlertAction(title: "Take Video", style: .default, handler: {(action: UIAlertAction) -> Void in
            self.takeVideo()
        })
        let btnChooseExisting = UIAlertAction(title: "Choose Video", style: .default, handler: {(_ action: UIAlertAction) -> Void in
            
            self.choosePhotoAndVideo(isPhoto: false, isVideo: true)
        })
        
        
        alert.addAction(btnCancel)
        alert.addAction(btnTakePhoto)
        alert.addAction(btnChooseExisting)
        
        //alert.view.tintColor = UIColor.black
        present(alert, animated: true)
        //present(alert, animated: true, completion: nil)
    }
    
    func takePhoto() {
        if !UIImagePickerController.isSourceTypeAvailable(.camera) {
            self.view.makeToast(AlertMessage.msgNoCamera)
            
        }
        else {
            let authStatus = AVCaptureDevice.authorizationStatus(for: AVMediaType.video)
            switch authStatus {
            case .authorized: let imagePickerController = UIImagePickerController()
                imagePickerController.sourceType = .camera
                imagePickerController.delegate = self
                imagePickerController.modalPresentationStyle = .overFullScreen
                self.present(imagePickerController, animated: true, completion: {() -> Void in
                })
            case .denied: self.alertPromptToAllowCameraAccessViaSetting()
                
            default:
                let imagePickerController = UIImagePickerController()
                imagePickerController.sourceType = .camera
                imagePickerController.delegate = self
                imagePickerController.modalPresentationStyle = .overFullScreen
                self.present(imagePickerController, animated: true, completion: {() -> Void in
                })
            }
        }
    }
    
    func takeVideo() {
        if !UIImagePickerController.isSourceTypeAvailable(.camera) {
            self.view.makeToast(AlertMessage.msgNoCamera)
            
        }
        else {
            let authStatus = AVCaptureDevice.authorizationStatus(for: AVMediaType.video)
            switch authStatus {
            case .authorized: let imagePickerController = UIImagePickerController()
                imagePickerController.sourceType = .camera
                imagePickerController.delegate = self
                imagePickerController.modalPresentationStyle = .overFullScreen
                self.present(imagePickerController, animated: true, completion: {() -> Void in
                })
            case .denied: self.alertPromptToAllowCameraAccessViaSetting()
                
            default:
                let imagePickerController = UIImagePickerController()
                imagePickerController.sourceType = .camera
                imagePickerController.mediaTypes = ["public.movie"]
                imagePickerController.delegate = self
                imagePickerController.modalPresentationStyle = .overFullScreen
                self.present(imagePickerController, animated: true, completion: {() -> Void in
                })
            }
        }
    }
    
    func choosePhotoAndVideo(isPhoto : Bool,isVideo : Bool) {
        func openImagePickerController() {
            mainThread {
                let imagePickerController = UIImagePickerController()
                imagePickerController.sourceType = .photoLibrary
                if isPhoto && isVideo {
                    imagePickerController.mediaTypes = ["public.image","public.movie"]
                } else if isVideo {
                    imagePickerController.mediaTypes = ["public.movie"]
                }
                imagePickerController.delegate = self
                imagePickerController.modalPresentationStyle = .overFullScreen
                self.present(imagePickerController, animated: true, completion: {() -> Void in
                })
            }
        }
        //  The user tapped on "Choose existing"
        let status = PHPhotoLibrary.authorizationStatus()
        
        if (status == PHAuthorizationStatus.authorized) {
            // Access has been granted.
            openImagePickerController()
        }
        else if (status == PHAuthorizationStatus.denied) {
            self.alertPromptToAllowPhotoAccessViaSetting()
        }
        else if (status == PHAuthorizationStatus.notDetermined) {
            // Access has not been determined.
            PHPhotoLibrary.requestAuthorization({ (newStatus) in
                
                if (newStatus == PHAuthorizationStatus.authorized) {
                    openImagePickerController()
                }
                else {
                    DispatchQueue.main.async {
                        _ = self.navigationController?.popViewController(animated: true)
                    }
                }
            })
        }
        else if (status == PHAuthorizationStatus.restricted) {
            // Restricted access - normally won't happen.
        }
    }
}

//MARK: - Camera Orientation Extension
extension UIImage {
    func fixOrientation() -> UIImage {
        if self.imageOrientation == UIImage.Orientation.up {
            return self
        }
        UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)
        self.draw(in: CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height))
        if let normalizedImage: UIImage = UIGraphicsGetImageFromCurrentImageContext() {
            UIGraphicsEndImageContext()
            return normalizedImage
        } else {
            return self
        }
    }
}

extension UIImageView {
    
    func fetchImage(asset: PHAsset, contentMode: PHImageContentMode, targetSize: CGSize) {
        
        let options = PHImageRequestOptions()
        options.version = .original
        
        PHImageManager.default().requestImage(for: asset, targetSize: targetSize, contentMode: contentMode, options: options) { image, _ in
            
            guard let image = image else { return }
            
            switch contentMode {
            
            case .aspectFill:
                self.contentMode = .scaleAspectFill
                
            case .aspectFit:
                self.contentMode = .scaleAspectFit
                
            default:
                break
            }
            
            self.image = image
        }
    }
}
