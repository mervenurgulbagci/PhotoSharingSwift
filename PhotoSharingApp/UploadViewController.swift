//
//  UploadViewController.swift
//  PhotoSharingApp
//
//  Created by Merve Nurgül BAĞCI on 15.03.2022.
//
import Firebase
import UIKit

class UploadViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var textField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.isUserInteractionEnabled = true
        
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(selectImage))
        imageView.addGestureRecognizer(gestureRecognizer)

    }
    
    @objc func selectImage(){
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = .photoLibrary
        present(pickerController, animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imageView.image = info[.originalImage] as? UIImage
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func uploadButtonClicked(_ sender: Any) {
        let storage = Storage.storage()
        let storageReference = storage.reference()
        
        let mediaFolder = storageReference.child("media")
        
        if let data = imageView.image?.jpegData(compressionQuality: 0.5){
            
            let uuid = UUID().uuidString
            
            let imageReference = mediaFolder.child("\(uuid).jpg")
            imageReference.putData(data, metadata: nil) { (storagemetadata, error) in
                
                if error != nil{
                    self.showErrorMessage(title: "Error!", message: error?.localizedDescription ?? "Something wrong, Try again!")
                    
                }else{
                    imageReference.downloadURL{ (url, error) in
                        if error == nil {
                            let imageUrl = url?.absoluteString
                            if let imageUrl = imageUrl {
                                let firebaseDatabase = Firestore.firestore()

                                let firestorePost = ["imageURL" : imageUrl , "comment" : self.textField.text!,
                                                     "email" : Auth.auth().currentUser!.email, "date" : FieldValue.serverTimestamp()] as [String : Any]
                                
                                
                                firebaseDatabase.collection("Post").addDocument(data: firestorePost) { (error) in
                                    if error !=  nil{
                                        self.showErrorMessage(title: "Error", message: error?.localizedDescription ?? "Something wrong, Try again!")
                                    }else{
                                        self.imageView.image = UIImage(named: "select")
                                        self.textField.text = ""
                                        self.tabBarController?.selectedIndex = 0
                                    }
                                }
                            }
                            
                        }
                    }
                }
            }
        }
    }
    
    func showErrorMessage(title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        var okButton: UIAlertAction {
            return UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        }
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }
}
