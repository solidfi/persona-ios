//
//  ViewController.swift
//  PersonaSample
//
//  Created by Solid on 28/09/21.
//

import UIKit

class ViewController: UIViewController {

    var personaHelper: PersonaHelper?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        /* SET UP PERSONA HELPER*/
        setupPersona()
    }

    func setupPersona() {
        /* INITIALSE PERSONA HELPER */
        personaHelper = PersonaHelper(self)
        
        /* HANDLE PERSONA IDENTIFICATION SUCCESS */
        personaHelper?.onSuccess = { (inquiryID: String) -> Void in
            debugPrint("identity success... inquiryID is : \(inquiryID)")
            
            /* MAKE API CALL TO SUBMIT 'inquiry_id' TO YOUR SERVER
             - API Link : https://documenter.getpostman.com/view/13543869/TWDfEDwX#937e0241-2229-4aad-96e7-10abbd235933
             */
            self.callAPIToSubmitIDVerification(inquiryID: inquiryID)
        }
    }
    
    @IBAction func startPersonaVerification(_ sender: Any) {
        /* MAKE API CALL TO GET 'template_id' FROM YOUR SERVER
         - API Link : https://documenter.getpostman.com/view/13543869/TWDfEDwX#b53a7e6a-a1b0-4510-89e5-c69704d3a7f9
         */
        callAPIToGetPersonaTemplateID()
    }
}

// MARK: - API calls
extension ViewController {

    func callAPIToGetPersonaTemplateID() {
        /* ON API CALL SUCCESS, MAKE REQUEST TO CREATE PERSONA INQUIRY WITH 'template_id' AND 'environment'
         - REPLACE "template_id" with one that you recieve from server
         - REPLACE "person_id" with one that you recieve from server
         - REPLACE "environment" with 'sandbox' OR 'production'
        */
        self.personaHelper?.startPersonaIdentity(withTemplateId: "template_id", withPersonId: "person_id", forEnvironment: "environment")
    }

    func callAPIToSubmitIDVerification(inquiryID: String) {
        /* ON API CALL SUCCESS, MAKE API CALL TO SUBMIT KYC'
         - API Link : https://documenter.getpostman.com/view/13543869/TWDfEDwX#d9e1ff39-729e-4f3a-beb0-78cd48710087
         */
        self.callAPIToSubmitKYC()
    }

    func callAPIToSubmitKYC() {
    }
}

