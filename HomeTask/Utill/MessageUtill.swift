//
//  MessageUtill.swift
//  HomeTask
//
//  Created by WebVajhegan on 3/7/22.
//  Copyright © 2022 WebVajhegan. All rights reserved.
//

import UIKit

class MessageUtill{
    
    static func makeMessage(title:String,body:String,controller:BaseViewController){
        let connectionAlert = UIAlertController(title: title, message: "\(body)", preferredStyle: UIAlertControllerStyle.alert)
        connectionAlert.addAction(UIAlertAction(title: "ok", style: .destructive))
        controller.present(connectionAlert, animated: true, completion: nil)
    }
    
    static func makeMessage(title:String,body:String,warningTitle:String,controller:BaseViewController,completion:@escaping()->()){
        let connectionAlert = UIAlertController(title: title, message: "\(body)", preferredStyle: UIAlertControllerStyle.alert)
        connectionAlert.addAction(UIAlertAction(title: warningTitle, style: .destructive, handler: { (action: UIAlertAction!) in
            completion()
        }))
        controller.present(connectionAlert, animated: true, completion: nil)
    }
    
}
