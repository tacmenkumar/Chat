//
//  NetworkManager.swift
//  Chat
//
//  Created by Niraj Kumar on 4/20/16.
//  Copyright © 2016 Niraj Kumar. All rights reserved.
//

import UIKit
import Alamofire

class NetworkManager: NSObject {
    static let sharedInstance = NetworkManager()
    let baseUrl = "https://enigmatic-basin-90863.herokuapp.com/"
    
    let defaultManager: Alamofire.Manager = {
        let serverTrustPolicies: [String: ServerTrustPolicy] = [
            "192.168.2.168": .DisableEvaluation,
            "192.168.2.168:5000": .DisableEvaluation,
            "localhost:5000" : .DisableEvaluation,
            "localhost" : .DisableEvaluation,
            "enigmatic-basin-90863.herokuapp.com": .DisableEvaluation
        ]
        
        let configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
        configuration.HTTPAdditionalHeaders = Alamofire.Manager.defaultHTTPHeaders
        
        return Alamofire.Manager(
            configuration: configuration,
            serverTrustPolicyManager: ServerTrustPolicyManager(policies: serverTrustPolicies)
        )
    }()
    
    /**
     Create the webservice method
     
     - parameter method:     method name like POST or GET
     - parameter urlMethod:  method to be called from the webservice
     - parameter parameters: payload to be sent to the webserivce
     - parameter headers:    headers if any
     
     - returns: httpRequest
     */
    func ws(method:String, urlMethod: String, parameters: [String: AnyObject], headers: [String: String], containerView: UIView, successCallback: (result:AnyObject) -> Void, errorCallback: (result:AnyObject) -> Void) {
        let url = "\(baseUrl)\(urlMethod)"
        var methodToCall = Method.GET
        if method == "POST" {
            methodToCall = Method.POST
        }
        AppActivityIndicator.sharedInstance.showLoader(containerView, message: "Loading...")
        print(url)
        self.defaultManager.request(methodToCall, url, parameters: parameters, encoding: .JSON, headers: headers)
            .responseJSON{  response in
                AppActivityIndicator.sharedInstance.hideLoader(containerView)
                switch response.result {
                case .Success(let JSON):
                    let response = JSON as! NSDictionary
                    if (response["status"] as? Int) == 1 {
                        successCallback(result: response)
                    }else{
                        let arrErrors = response.objectForKey("errors") as! NSArray
                        let errors = arrErrors.objectAtIndex(0) as! NSDictionary
                        if ((errors.objectForKey("message") as? String) != nil) {
                            print(response.objectForKey("message"))
                            errorCallback(result: errors)
                        }
                    }
                case .Failure(let error):
                    print("Request failed with error: \(error)")
                    errorCallback(result: error)
                }
        }
    }
    
    /**
     Register user
     
     - parameter displayName:  display name
     - parameter email:        email
     - parameter password:     password
     - parameter dateOfBirth:  date of birth
     - parameter mobileNumber: mobile number
     */
    func callWSRegister(parameters:[String: AnyObject], containerView: UIView, successCallback: (result:AnyObject) -> Void, errorCallback: (result:AnyObject) -> Void){
        let headers = [
            "Content-Type": "application/json"
        ];
        ws( "POST", urlMethod: "users/register", parameters: parameters, headers: headers, containerView: containerView, successCallback: successCallback, errorCallback: errorCallback )
    }
    
    /**
     Login user
     
     - parameter email:        email
     - parameter password:     password
     */
    func callWSLogin(parameters:[String: AnyObject], containerView: UIView, successCallback: (result:AnyObject) -> Void, errorCallback: (result:AnyObject) -> Void){
        let headers = [
            "Content-Type": "application/json"
        ];
        ws( "POST", urlMethod: "users/login", parameters: parameters, headers: headers, containerView: containerView, successCallback: successCallback, errorCallback: errorCallback )
    }
}
