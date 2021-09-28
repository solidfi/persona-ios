//
//  PersonaHelper.swift
//  PersonaSample
//
//  Created by Solid on 28/09/21.
//

import Foundation
import UIKit
import Persona

class PersonaHelper {
    var parent: UIViewController?
    var onSuccess: ((String) -> Void)?
    var theme = InquiryTheme()

    convenience init(_ parent: UIViewController) {
        self.init()
        self.parent = parent
        self.setPersonaTheme()
    }

    func setPersonaTheme() {
        theme = InquiryTheme()
        theme.buttonBackgroundColor = .black //main buttons
        theme.selectedCellBackgroundColor = .lightGray //country selection cell
        theme.cameraButtonAlternateBackgroundColor = .lightGray //camera button RETAKE
        theme.cameraButtonBackgroundColor = .blue //camera button LOOKS GOOD
        
        /* OTHER THEME PROPERTIES */
        //theme.accentColor = .brandColor //animation tint color
        //theme.cameraGuideCornersColor = .white //camera capture area corner color
        //theme.cancelButtonAlternateBackgroundColor = .red
        //theme.backgroundColor = .white
        //theme.bodyTextColor = .black
        //theme.titleTextColor = .black
        //theme.closeButtonTintColor = .black
        //theme.cancelButtonBackgroundColor = .black
        
        /* THEME PROPERTIES FOR V2 */
        //theme.buttonSecondaryBorderColor = .black // for V2
        //theme.buttonSecondaryTextColor = .primaryColor // for V2
    }
    
    private func showErrorMessage(forError error: Error) {
        let alert = UIAlertController(title: "Error", message: "Persona SDK errored \(error)", preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(alertAction)
        self.parent!.present(alert, animated: true)
    }
}

// MARK: - Persona Methods
extension PersonaHelper: InquiryDelegate {
    @objc func startPersonaIdentity(with templateId: String, for environment: String) {
        var env: Persona.Environment? = .production
        if environment != "production" {
            env = .sandbox
        }
        
        let config = InquiryConfiguration(templateId: templateId,
                                          environment: env,
                                          theme: theme)
        
        // Create the inquiry with the view controller
        // as the delegate and presenter.
        Inquiry(config: config, delegate: self).start(from: self.parent!)
    }
    
    func inquirySuccess(inquiryId: String, attributes: Attributes, relationships: Relationships) {
        // ✅ Inquiry succeeded
        debugPrint("identity success. inquiryId : \(inquiryId)")
        self.onSuccess!(inquiryId)
    }
    
    func inquiryCancelled() {
        // ⏏️ Inquiry cancelled by user
        debugPrint("identity cancelled")
    }
    
    func inquiryFailed(inquiryId: String, attributes: Attributes, relationships: Relationships) {
        // ❌ Inquiry failed
        debugPrint("identity failed")
    }
    
    func inquiryError(_ error: Error) {
        // ⚠️ Inquiry errored
        debugPrint("identity error")
        self.showErrorMessage(forError: error)
    }
}