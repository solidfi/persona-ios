//
//  ViewController.swift
//  PersonaSample
//
//  Created by Rohan on 28/09/21.
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
        
        /* MAKE API CALL TO SUBMIT 'inquiry_id' TO YOUR SERVER */
        personaHelper?.onSuccess = { (inquiryID: String) -> Void in
            debugPrint("identity success... inquiryID is : \(inquiryID)")
            
            /* MAKE API CALL TO SUBMIT 'inquiry_id' TO YOUR SERVER */
            self.callAPIToSubmitIDVerification(inquiryID: inquiryID)
        }
    }
    
    @IBAction func proceedIdentity(_ sender: Any) {
        /* MAKE API CALL TO GET 'template_id' FROM YOUR SERVER */
        callAPIToGetPersonaTempalteID()
    }
}

// MARK: - API calls
extension ViewController {

    func callAPIToGetPersonaTempalteID() {
        /* ON API CALL SUCCESS, MAKE REQUEST TO PERSONA WITH 'template_id' AND 'environment'
         - REPLACE "template_id" with one that you recieve from server
         - REPLACE "environment" with 'sandbox' OR 'production'
        */
        self.personaHelper?.startPersonaIdentity(with: "template_id", for: "environment")
    }

    func callAPIToSubmitIDVerification(inquiryID: String) {
        /* ON API CALL SUCCESS, MAKE API CALL TO SUBMIT KYC' */
        self.callAPIToSubmitKYC()
    }

    func callAPIToSubmitKYC() {
    }
}

