//
//  ViewController.swift
//  demo1
//
//  Created by Admin on 15/11/22.
//

import UIKit
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth
import FirebaseAnalytics

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // creating reference for out database
        let dbreference = Firestore.firestore()
        
        //Adding a documnets
        dbreference.collection("Books").addDocument(data: ["Maths":450, "English":300, "Science":"Not availlable"])
        
        //Getting the document id
        let newDocumnetId = dbreference.collection("Books").document()
        newDocumnetId.setData(["id":newDocumnetId.documentID])
        
        //Adding a document with a specific id
        dbreference.collection("Books").document("Book with price").setData(["Maths":450, "English":300, "Science":"Not availlable"])
        // if the given document id already exit then it will over write it
        //if we want to update the value then the KEY will remain same and we will change the value
        
        // updating a specific documnet id
        
        dbreference.collection("Books").document("Book with price").setData(["Maths":450, "English":300, "Science":"Not availlable","Hindi":200], merge: true)
        
        //Detecting error
        dbreference.collection("Books").addDocument(data: ["test":"test1"]) { (error) in
            if let error = error {
                // there is an error
            }
            else{
                //error is nill operation complete sussesfully
            }
            
            //Delecting a document
            dbreference.collection("Books").document("Book with price").delete()
            
            //Delete a single field
            dbreference.collection("Books").document("Book with price").updateData(["Maths":FieldValue.delete()])
            
            //Reading a specific documnet
            dbreference.collection("Books").document("Book with price").getDocument { document, error in
                //checking for error
                if error == nil {
                    if document != nil && ((document?.exists) != nil){
                        let documentData = document?.data()
                    }
                    
                }else{
                    
                }
            }
            
            //getting all documnet from a collection
            dbreference.collection("Books").getDocuments { (snapshot, error) in
                if error == nil && snapshot != nil {
                    
                    for document in snapshot!.documents {
                        let documentData = document.data()
                    }
                }
            }
            // getting a subset of document
            dbreference.collection("Books").whereField("hindi", isEqualTo: true).getDocuments { (snapshot, error) in
                if error == nil && snapshot != nil {
                    
                    for document in snapshot!.documents {
                        let documentData = document.data()
                    }
                }
                
            }
            
        }
        
        
        
        
    }
    
    
}


