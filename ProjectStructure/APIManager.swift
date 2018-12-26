//
//  APIManager.swift
//  ProjectStructure
//
//  Created by BLT0013-MACMI on 12/18/18.
//  Copyright © 2018 Demo. All rights reserved.
//

import Foundation
import CommonCrypto


class APIManager {
    let baseURL = "https://jsonplaceholder.typicode.com/"
    
    
    //Mark : api call
    
    func deviceIDVerify(param :Dictionary<String , AnyObject> , completion : @escaping(_ success : Bool , _ jsonObject : DeviceVerificationModel?) -> ())
    {
        print("Url:----->\(baseURL)\(RequestMethod.verifyDeviceID.rawValue)")
        print("Params:----->\(param)")
        post(request: clientURLRequestPostMethod(path: RequestMethod.verifyDeviceID.rawValue, params: param)) { (success, object) in
            DispatchQueue.main.async(execute: { () -> Void in
                if success {
                    completion(true, DeviceVerificationModel.convertData(data: object as! Data))
                }else{
                    completion(false, DeviceVerificationModel.convertData(data: object as! Data))
                }
            })
        }
    }
    
    func purposeDetails(completion : @escaping(_ success : Bool , _ jsonObject : DeviceVerificationModel?) -> ())
    {
        print("Url:----->\(baseURL)\(RequestMethod.verifyDeviceID.rawValue)")
        var request = NSMutableURLRequest(url: NSURL(string: "\(baseURL)\(RequestMethod.verifyDeviceID.rawValue)")! as URL)
        get(request: request){ (success, object) in
            DispatchQueue.main.async(execute: { () -> Void in
                if success {
                    completion(true, DeviceVerificationModel.convertData(data: object as! Data))
                }else{
                    completion(false, DeviceVerificationModel.convertData(data: object as! Data))
                }
            })
        }
    }
    
    //MARK request method
    
    private func post(request: NSMutableURLRequest, completion: @escaping (_ success: Bool, _ object: AnyObject?) -> ()) {
        dataTask(request: request, method: "POST", completion: completion)
    }
    
    private func put(request: NSMutableURLRequest, completion: @escaping (_ success: Bool, _ object: AnyObject?) -> ()) {
        dataTask(request: request, method: "PUT", completion: completion)
    }
    
    private func get(request: NSMutableURLRequest, completion: @escaping (_ success: Bool, _ object: AnyObject?) -> ()) {
        dataTask(request: request, method: "GET", completion: completion)
    }
    
    //MARK Data task call
    
    private func dataTask(request: NSMutableURLRequest, method: String, completion: @escaping (_ success: Bool, _ object: AnyObject?) -> ()) {
        request.httpMethod = method
        
        let session = URLSession(configuration: URLSessionConfiguration.default)
        session.dataTask(with: request as URLRequest) { (data, response, error) -> Void in
            
            if let  data = data {
                
                if let response = response as? HTTPURLResponse, 200...299 ~= response.statusCode {
                    completion(true, data as AnyObject?)
                }else
                {
                    completion(false, data as AnyObject?)
                }
            }
                
            else {
                
                // IF NO INTERNERT CONNECTION
                
            }
            }.resume()
    }
    
    private func clientURLRequestPostMethod(path: String, params: Dictionary<String , AnyObject>? = nil) -> NSMutableURLRequest {
        if params != nil {
            var paramString = ""
            var index : Int = 0
            for (key, value) in params! {
                index = index + 1
                let escapedKey = key
                let escapedValue = value
                if params!.count == index{
                    paramString += "\(escapedKey)=\(escapedValue)"
                }else{
                    paramString += "\(escapedKey)=\(escapedValue)&"
                }
            }
            return self.setRequestDatas(strUrl: self.baseURL+path, params: params as Any)
        }
        
        return NSMutableURLRequest()
    }
    func setRequestDatas(strUrl: String, params: Any)->NSMutableURLRequest{
        print("Url:----->\(strUrl)")
        print("Params:----->\(params)")
        let millis = Date().timeIntervalSince1970
        let nm: NSString = "\(String(millis) as NSString)" as NSString
        let request = NSMutableURLRequest(url: NSURL(string: strUrl)! as URL)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("SunNetwork", forHTTPHeaderField: "TVSNext")
        request.setValue("hash", forHTTPHeaderField: self.md5(nm as String))
        request.setValue("time", forHTTPHeaderField: String(millis))
        request.httpBody = try! JSONSerialization.data(withJSONObject: params as Any, options: [])
        return request
    }
    
    private func clientURLRequestGetMethod(path: String, params: Dictionary<String, AnyObject>? = nil) -> NSMutableURLRequest {
        let millis = Date().timeIntervalSince1970
        let nm: NSString = "\(String(millis) as NSString)" as NSString
        
        if let params = params {
            var paramString = ""
            for (key, value) in params {
                let escapedKey = key.addingPercentEncoding(withAllowedCharacters:NSCharacterSet.urlQueryAllowed)
                let escapedValue = value.addingPercentEncoding(withAllowedCharacters:NSCharacterSet.urlQueryAllowed)
                paramString += "&\(escapedKey!)=\(escapedValue!)"
            }
            
            let request = NSMutableURLRequest(url: NSURL(string: baseURL+path+paramString)! as URL)
            print(request)
            //request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.setValue("SunNetwork", forHTTPHeaderField: "TVSNext")
            request.setValue("hash", forHTTPHeaderField: self.md5(nm as String))//
            request.setValue("time", forHTTPHeaderField: String(millis))
            
            return request
        }
        
        return NSMutableURLRequest()
    }
    func md5(_ string: String) -> String {
        let context = UnsafeMutablePointer<CC_MD5_CTX>.allocate(capacity: 1)
        var digest = Array<UInt8>(repeating:0, count:Int(CC_MD5_DIGEST_LENGTH))
        CC_MD5_Init(context)
        CC_MD5_Update(context, string, CC_LONG(string.lengthOfBytes(using: String.Encoding.utf8)))
        CC_MD5_Final(&digest, context)
        context.deallocate(capacity: 1)
        var hexString = ""
        for byte in digest {
            hexString += String(format:"%02x", byte)
        }
        return hexString
    }
}
