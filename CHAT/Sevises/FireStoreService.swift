//
//  FireStoreService.swift
//  CHAT
//
//  Created by Никита Егоров on 26.11.2020.
//

import Firebase
import FirebaseFirestore

class FireStoreService {
    
    static let shared = FireStoreService()
    
    let db = Firestore.firestore()
    
    private var userRef : CollectionReference {
        return db.collection("users")
    }
    
    func getUserData(user: User, completion: @escaping (Result<MUser, Error>) -> Void) {
        let docRef = userRef.document(user.uid)
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                guard let muser = MUser(document: document) else {
                    completion(.failure(UserError.cannotUnwrapToUser))
                    return
                }
                completion(.success(muser))
            } else {
                completion(.failure(UserError.cannotGetUserInfo))
            }
        }
    }
    
    func saveProfileWith(id: String,
                         email: String,
                         username: String?,
                         avatarImage: UIImage?,
                         description: String?,
                         sex: String?,
                         completion: @escaping (Result<MUser, Error>) -> Void) {
        guard Validaters.isFilled(userName: username, description: description, sex: sex) else {
            completion(.failure(UserError.notFilled))
            return
        }
        
        guard  avatarImage != #imageLiteral(resourceName: "avatar") else {
            completion(.failure(UserError.photoNotExist))
            return
        }
        
        var muser = MUser(username: username!,
                          email: email,
                          avatarStringURL: "avatarImageString",
                          description: description!,
                          sex: sex!,
                          id: id)
        StorageService.shared.upload(photo: avatarImage!) { (result) in
            switch result {
            case .success(let url):
                muser.avatarStringURL = url.absoluteString
                self.userRef.document(muser.id).setData(muser.representation) { (error) in
                    if let error = error {
                        completion(.failure(error))
                    } else {
                        completion(.success(muser))
                    }
                }
            case .failure(let error):
                completion(.failure(error))
            }
            
        } //StorageService
        
    } // saveProfileWith
    
}
