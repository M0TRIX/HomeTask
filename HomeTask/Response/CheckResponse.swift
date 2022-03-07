//
//  CheckResponse.swift
//  HomeTask
//
//  Created by WebVajhegan on 3/7/22.
//  Copyright © 2022 WebVajhegan. All rights reserved.
//

import Foundation

class ServiceValidator{
    
    
    static func checkResposnse(response:URLResponse,data:Data?)->ServiceError{
        
        guard let _ = data else{
            return ServiceError.INVALIDRESPONSE
        }
        
        switch  (response as? HTTPURLResponse)!.statusCode {
        case 200:
            return ServiceError.SUCCESS
        case 400:
            return ServiceError.BADREQUEST
        case 401:
            return ServiceError.UNAUTHORIZE
        case 402,403:
            return ServiceError.FORBIDDEN
        default:
            return ServiceError.SERVERERROR
        }
        
    }
}
