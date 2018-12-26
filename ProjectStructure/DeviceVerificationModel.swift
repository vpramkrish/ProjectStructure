//
//  HomeScreenModel.swift
//  SunTVNetwork
//
//  Created by BLT0013-MACMI on 7/24/18.
//  Copyright © 2018 TVS. All rights reserved.
//

//import Foundation
import UIKit

struct DeviceVerificationModel : Codable {
    let userId : Int
    let empid: Int
    let title: String
    let completed: Bool
    let Data: [UserDat]?
//    let Success : Bool?
//    let Data : [UserData]?
//    let Message : String?
//    let ErrorCode : Int?
//    let Data1 : String?
//    let On_duty_master_ID : Int?
//    let ODStatus : ProgramStart?
//    let ODDetails : [ODDetails]?
//    let Emp_ID : String?
//    let UserDetails : [UserDetails]?
//    let ON_DUTY_PROGRAM_ID : Int?
//    let settings : [AutoCheckout]?
//    let IsProgramStatus : Bool?
//    let ODStartTime : String?
//    let PinStatus : Pinstatus?
//    let AuthenticationPin : String?
    /* The CodingKeys enum, which conforms to CodingKey protocol, lets you rename specific properties in case the serialized format doesn’t match the requirements of the API. */
    enum CodingKeys : String, CodingKey {
        case empid = "id"
        case userId
        case title
        case completed
        case Data
        
    }
    static func convertData(data: Data) -> DeviceVerificationModel? {
        let model = try! JSONDecoder().decode(DeviceVerificationModel.self, from: data)
        
        return model
    }
}

struct UserDat: Codable {
    let userId : Int
    let id: Int
    let title: String
    let completed: Bool
}
struct ProgramStart : Codable {
    let OD_STARTED : Bool?
    let OD_ENDED : Bool?
    let PROGRAM_STARTED : Bool?
    let PROGRAM_ENDED : Bool?
}
struct UserDetails : Codable {
    let EMP_ID : Int?
    let USER_ID : Int?
    let NAME : String?
    let Designation : String?
    let department : String?
    let company : String?
    let location : String?
    let date_of_joining : String?
    let photo_url : String?
    //    let DESIGNATION : String?
    //    let DEPARTMENT : String?
    //    let COMPANY : String?
    //    let LOCATION : String?
    //    let DATE_OF_JOINING : String?
    //    let PHOTO_URL : String?
}
struct ODDetails : Codable {
    
    let CREATED_DATE : String?
    let PROGRAM_CREATED_DATE : String?
    let ONDUTYID : Int?
    let ON_DUTY_PROGRAM_ID : Int?
    let ON_DUTY_MASTER_ID : Int?
    let OD_START_TIME : String?
    let OD_START_LOCATION_NAME : String?
    let OD_START_LOCATION_LAT : String?
    let OD_START_LOCATION_LONG : String?
    let OD_START_LOCATION_ADDRESS : String?
    let OD_END_TIME : String?
    let OD_END_LOCATION_NAME : String?
    let OD_END_LOCATION_LAT : String?
    let OD_END_LOCATION_LONG : String?
    let OD_END_LOCATION_ADDRESS : String?
    let PURPOSE_ID : Int?
    let CUSTOMER : String?
    let START_PROGRAM_TIME : String?
    let START_PROGRAM_LOCATION_NAME : String?
    let START_PROGRAM_LOCATION_LAT : String?
    let START_PROGRAM_LOCATION_LONG : String?
    let START_PROGRAM_LOCATION_ADDRESS : String?
    let END_PROGRAM_TIME : String?
    let END_PROGRAM_LOCATION_NAME : String?
    let END_PROGRAM_LOCATION_LAT : String?
    let END_PROGRAM_LOCATION_LONG : String?
    let END_PROGRAM_LOCATION_ADDRESS : String?
    let CUSTOMER1 : String?
    let OD_DURATION : String?
    let PROGRAM_DURATION : String?
    
}

struct UserData : Codable {
    let PURPOSE_ID : Int?
    let purpose_name :String?
    let OD_START_TIME : String?
    let OD_START_LOCATION_NAME : String?
    let OD_START_LOCATION_LAT : String?
    let OD_START_LOCATION_LONG : String?
    let OD_START_LOCATION_ADDRESS : String?
    let OD_END_TIME : String?
    let OD_END_LOCATION_NAME : String?
    let OD_END_LOCATION_LAT : String?
    let OD_END_LOCATION_LONG : String?
    let OD_END_LOCATION_ADDRESS : String?
    let CUSTOMER : String?
    let START_PROGRAM_TIME : String?
    let START_PROGRAM_LOCATION_NAME : String?
    let START_PROGRAM_LOCATION_LAT : String?
    let START_PROGRAM_LOCATION_LONG : String?
    let START_PROGRAM_LOCATION_ADDRESS : String?
    let END_PROGRAM_TIME : String?
    let END_PROGRAM_LOCATION_NAME : String?
    let END_PROGRAM_LOCATION_LAT : String?
    let END_PROGRAM_LOCATION_LONG : String?
    let END_PROGRAM_LOCATION_ADDRESS : String?
    
}
struct AutoCheckout : Codable {
    let AutoCheckOutTime : String?
    let AutoCheckOutDistance :String?
    let App_version : String?
    let Device_Platform :String?
    
}
struct Pinstatus : Codable {
    let AUTH_PIN : Bool?
    let FINGER_PRINT : Bool?
    let FACE_RECOGNITION : Bool?
}
