//
//  SaladaFileTestViewController.swift
//  Salada
//
//  Created by 1amageek on 2017/03/01.
//  Copyright © 2017年 Stamp. All rights reserved.
//

import UIKit
import Firebase

class SaladaFileTestViewController: UIViewController {

    @IBAction func start(_ sender: Any) {
//        let image: UIImage = #imageLiteral(resourceName: "pexels-photo.jpg")
        let image: UIImage = #imageLiteral(resourceName: "salada")
        let data: Data = UIImageJPEGRepresentation(image, 1)!
        
        let tmpURL = URL(fileURLWithPath: NSTemporaryDirectory(), isDirectory: true)
            .appendingPathComponent("sample")
            .appendingPathExtension("jpg")
        
        try! data.write(to: tmpURL)

        let file: File = File(url: tmpURL, mimeType: .jpeg)
        let item: Item = Item()
        item.file = file
        item.index = 0
        let task: StorageUploadTask = item.save { (ref, error) in
            if let error = error {
                print(error)
                return
            }
            print("Save")
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: {
                let image: UIImage = #imageLiteral(resourceName: "salada")
                let data: Data = UIImageJPEGRepresentation(image, 1)!
                let file: File = File(data: data)
                item.file = file
                _ = item.file?.update(completion: { (metadata, error) in
                    if let error = error {
                        print(error)
                        return
                    }
                    print("SSSSS")

                })
            })
        }["file"]!
        
        task.observe(.progress) { (snapshot) in
            print(snapshot.progress!)
        }
        
    }
    
}
