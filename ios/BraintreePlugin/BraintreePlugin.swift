import Foundation
import Capacitor
import Braintree
import BraintreeDropIn

@objc(BraintreePlugin)
public class BraintreePlugin: CAPPlugin {
    
    private var client: BTAPIClient?;
    private var token: String?;
    private var applePaySuccess: Bool;
    private var applePayInitialized: Bool;
    private var applePayMerchantID: String?;
    private var currencyCode: String?;
    private var countryCode: String?;
    private var useVaultManager: Bool;
    private var disablePayPal: Bool;
    private var disableVenmo: Bool;
    private var useThreeDSecureVerification: Bool;
    private var disableAndroidPay: Bool; // exists for the droid dropin, not for iOS
    private var disableGooglePayment: Bool; // exists for the droid dropin, not for iOS
    
    override public init!(bridge: CAPBridge!, pluginId: String!, pluginName: String!) {
        applePaySuccess = false;
        applePayInitialized = false;
        useVaultManager = true;
        disablePayPal = true;
        disableVenmo = true;
        disableAndroidPay = true;
        disableGooglePayment = true;
        useThreeDSecureVerification = false;
        super .init(bridge: bridge, pluginId: pluginId, pluginName: pluginName)
    }
    
    @objc func initialize(_ call: CAPPluginCall) {
        guard let token = call.getString("token") else {
            call.error("Bad input - 'token' is required")
            return
        }
        
        guard let bi = Bundle.main.bundleIdentifier else {
            call.error("iOS internal error - failed to get bundle identifier via Bundle.main.bundleIdentifier");
            return
        }
        
        if bi.count == 0 {
            call.error("iOS internal error - bundle identifier via Bundle.main.bundleIdentifier was zero length");
            return
        }
        
        client = BTAPIClient(authorization: token);
        
        if client == nil {
            call.error("Braintree failed to initialize");
            return
        }
        
        self.token = token
        
        BTAppSwitch.setReturnURLScheme(bi + ".braintree.payments")

        call.resolve()
    }
    
    @objc func setUseVaultManager(_ call: CAPPluginCall) {
        
        guard let _ = client else {
            call.error("Braintree client was not initialized")
            return
        }
        
        guard let value = call.getBool("value") else {
            call.error("Bad input - 'value' is required")
            return
        }
        
        useVaultManager = value
        
        call.resolve()
    }
    
    @objc func setDisablePayPal(_ call: CAPPluginCall) {
        
        guard let _ = client else {
            call.error("Braintree client was not initialized")
            return
        }
        
        guard let value = call.getBool("value") else {
            call.error("Bad input - 'value' is required")
            return
        }
        
        disablePayPal = value
        
        call.resolve()
    }
    
    @objc func setDisableVenmo(_ call: CAPPluginCall) {
        
        guard let _ = client else {
            call.error("Braintree client was not initialized")
            return
        }
        
        guard let value = call.getBool("value") else {
            call.error("Bad input - 'value' is required")
            return
        }
        
        disableVenmo = value
        
        call.resolve()
    }
    
    @objc func setUseThreeDSecureVerification(_ call: CAPPluginCall) {
        
        guard let _ = client else {
            call.error("Braintree client was not initialized")
            return
        }
        
        guard let value = call.getBool("value") else {
            call.error("Bad input - 'value' is required")
            return
        }
        
        useThreeDSecureVerification = value
        
        call.resolve()
    }
    
    @objc func setDisableAndroidPay(_ call: CAPPluginCall) {
        
        guard let _ = client else {
            call.error("Braintree client was not initialized")
            return
        }
        
        guard let value = call.getBool("value") else {
            call.error("Bad input - 'value' is required")
            return
        }
        
        disableAndroidPay = value
        
        call.resolve()
    }
    
    @objc func setDisableGooglePayment(_ call: CAPPluginCall) {
        
        guard let _ = client else {
            call.error("Braintree client was not initialized")
            return
        }
        
        guard let value = call.getBool("value") else {
            call.error("Bad input - 'value' is required")
            return
        }
        
        disableGooglePayment = value
        
        call.resolve()
    }
    
    @objc func presentModalPaymentUi(_ call: CAPPluginCall) {

        guard let _ = client else {
            call.error("Braintree client was not initialized")
            return
        }
        
        guard let activeToken = token else {
            call.error("token was not set")
            return
        }
        
//         guard let amount = call.getString("amount") else {
//             call.error("Bad input - 'amount' is required")
//             return
//         }
        
        let paymentRequest = BTDropInRequest()
        //TODO: Investigate changes around new deprecation of 'amount' and 3d secure request
        //paymentRequest.amount = amount
        paymentRequest.applePayDisabled = applePayInitialized
        paymentRequest.vaultManager = useVaultManager
        paymentRequest.paypalDisabled = disablePayPal
        paymentRequest.venmoDisabled = disableVenmo
        paymentRequest.threeDSecureVerification = useThreeDSecureVerification
        
        
        let handler: BTDropInControllerHandler = { (controller, result, error) in
            controller.dismiss(animated: true, completion: {
                if let err = error {
                    call.error(err.localizedDescription, err, [:])
                    return
                }
                
                guard let res = result else {
                    NSLog("Braintree controller returned with no error but didn't return a result object. Assume no changes were made and no error occurred.")
                    let rv = PaymentUiResponse()
                    rv.userCancelled = true
                    call.resolve(rv.toDict())
                    return
                }
                
                if res.isCancelled {
                    let rv = PaymentUiResponse()
                    rv.userCancelled = true
                    call.resolve(rv.toDict())
                    return
                }
                
                guard let nonce = res.paymentMethod else {
                    NSLog("Braintree controller returned with no error and no cancellation but didn't return a nonce object. Assume no changes were made and no error occurred.")
                    let rv = PaymentUiResponse()
                    rv.userCancelled = true
                    call.resolve(rv.toDict())
                    return
                }
                
                let rv = PaymentUiResponse(paymentNonce: nonce)
                
                call.resolve(rv.toDict())
            })
        }
        
        guard let dropin = BTDropInController(authorization: activeToken, request: paymentRequest, handler: handler) else {
            call.error("Could not instantiate the Braintree view")
            return
        }
        
        DispatchQueue.main.async {
            self.bridge.viewController.present(dropin, animated: true)
        }
    }
}
