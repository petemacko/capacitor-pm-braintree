//
//  PaymentUiReponse.swift
//  CapacitorBraintree
//
//  Created by pete on 7/16/19.
//

import Foundation
import Braintree

@objc(PaymentUiResponse)
public class PaymentUiResponse: NSObject {
    
    public class Card: NSObject {
        public var lastTwo: String?
        public var network: String?
        public var networkName: String?
    }
    
    public class PayPalAccount: NSObject {
        public var email: String?
        public var firstName: String?
        public var lastName: String?
        public var phone: String?
        public var clientMetadataId: String?
        public var payerId: String?
    }
    
    // Need to test ApplePay before adding this stuff
    //    public class ApplePayCard: NSObject {
    //    }
    
    public class ThreeDSecureCard: NSObject {
        public var liabilityShifted: Bool?
        public var liabilityShiftPossible: Bool?
    }
    
    public class VenmoAccount: NSObject {
        public var username: String?
    }
    
    public var userCancelled: Bool = false
    public var nonce: String?
    public var type: String?
    public var localizedDescription: String?
    public var card: Card?
    public var payPalAccount: PayPalAccount?
    //    public var applePayCard: ApplePayCard?
    public var threeDSecureCard: ThreeDSecureCard?
    public var venmoAccount: VenmoAccount?
    
    public override init() {
    }
    
    convenience init(paymentNonce: BTPaymentMethodNonce) {
        self.init()
        userCancelled = false
        nonce = paymentNonce.nonce
        type = paymentNonce.type
        localizedDescription = paymentNonce.localizedDescription
        
        if let z = paymentNonce as? BTCardNonce {
            let zz = Card()
            zz.lastTwo = z.lastTwo
            zz.network = PaymentUiResponse.poorlyDescribeBraintreeCardNetwork(cardNetwork: z.cardNetwork)
            zz.networkName = PaymentUiResponse.describeBraintreeCardNetwork(cardNetwork: z.cardNetwork)
            card = zz
        }
        
        if let z = paymentNonce as? BTPayPalAccountNonce {
            let zz = PayPalAccount()
            zz.email = z.email
            zz.firstName = z.firstName
            zz.lastName = z.lastName
            zz.phone = z.phone
            zz.clientMetadataId = z.clientMetadataId
            zz.payerId = z.payerId
            payPalAccount = zz
        }
        
//        if let z = applePayNonce as? BTApplePayCardNonce {
//        }
        
        if let z = paymentNonce as? BTThreeDSecureCardNonce {
            let zz = ThreeDSecureCard()
            zz.liabilityShifted = z.liabilityShifted
            zz.liabilityShiftPossible = z.liabilityShiftPossible
            threeDSecureCard = zz
        }
        
        if let z = paymentNonce as? BTVenmoAccountNonce {
            let zz = VenmoAccount()
            zz.username = z.username
            venmoAccount = zz
        }
    }
    
    public func toDict() -> [String:Any] {
        // Could bring in a library to do this, or just store all the data as a big dict in the first place instead of strongly-typed
        // but I didn't do either. Ripped part of this from one of my other projects, and would also rather not introduce even more dependencies
        // to the plugin chain just to serialize one graph. Your opinion may likely vary.
        var rv = [String:Any]()
        
        rv["userCancelled"] = userCancelled
        if let z = nonce {
            rv["nonce"] = z
        }
        if let z = type {
            rv["type"] = z
        }
        if let z = localizedDescription {
            rv["localizedDescription"] = z
        }
        
        if let z = card {
            var d = [String:Any]()
            if let zz = z.lastTwo {
                d["lastTwo"] = zz
            }
            if let zz = z.network {
                d["network"] = zz
            }
            if let zz = z.networkName {
                d["networkName"] = zz
            }
            rv["card"] = d
        }
        
//        if let z = applePayNonce {
//            rv["applePayNonce"] = d
//        }
        
        if let z = payPalAccount {
            var d = [String:Any]()
            if let zz = z.email {
                d["email"] = zz
            }
            if let zz = z.firstName {
                d["firstName"] = zz
            }
            if let zz = z.lastName {
                d["lastName"] = zz
            }
            if let zz = z.email {
                d["email"] = zz
            }
            if let zz = z.phone {
                d["phone"] = zz
            }
            if let zz = z.clientMetadataId {
                d["clientMetadataId"] = zz
            }
            if let zz = z.payerId {
                d["payerId"] = zz
            }
            rv["payPalAccount"] = d
        }
        
        if let z = threeDSecureCard {
            var d = [String:Any]()
            if let zz = z.liabilityShifted {
                d["liabilityShifted"] = zz
            }
            if let zz = z.liabilityShiftPossible {
                d["liabilityShiftPossible"] = zz
            }
            rv["threeDSecureCard"] = d
        }
        
        if let z = venmoAccount {
            var d = [String:Any]()
            if let zz = z.username {
                d["username"] = zz
            }
            rv["venmoAccount"] = d
        }
        
        return rv
    }
    
    public static func describeBraintreeCardNetwork(cardNetwork: BTCardNetwork) -> String {
        switch cardNetwork {
        case .AMEX:
            return "AMEX"
        case .dinersClub:
            return "Diners Club"
        case .discover:
            return "Discover"
        case .masterCard:
            return "MasterCard"
        case .visa:
            return "Visa"
        case .JCB:
            return "JCB"
        case .laser:
            return "Laser"
        case .maestro:
            return "Maestro"
        case .unionPay:
            return "UnionPay"
        case .solo:
            return "Solo"
        case .switch:
            return "Switch"
        case .ukMaestro:
            return "UK Maestro"
        case .hiper:
            return "Hiper"
        case .hipercard:
            return "Hipercard"
        case .unknown:
            fallthrough
        default:
            return "Unknown"
        }
    }
    
    public static func poorlyDescribeBraintreeCardNetwork(cardNetwork: BTCardNetwork) -> String {
        switch cardNetwork {
        case .AMEX:
            return "BTCardNetworkAMEX"
        case .dinersClub:
            return "BTCardNetworkDinersClub"
        case .discover:
            return "BTCardNetworkDiscover"
        case .masterCard:
            return "BTCardNetworkMasterCard"
        case .visa:
            return "BTCardNetworkVisa"
        case .JCB:
            return "BTCardNetworkJCB"
        case .laser:
            return "BTCardNetworkLaser"
        case .maestro:
            return "BTCardNetworkMaestro"
        case .unionPay:
            return "BTCardNetworkUnionPay"
        case .solo:
            return "BTCardNetworkSolo"
        case .switch:
            return "BTCardNetworkSwitch"
        case .ukMaestro:
            return "BTCardNetworkUKMaestro"
        case .hiper:
            return "BTCardNetworkHiper"
        case .hipercard:
            return "BTCardNetworkHipercard"
        case .unknown:
            return "BTCardNetworkUnknown"
        default:
            return "Unknown"
        }
    }
    
    
}
