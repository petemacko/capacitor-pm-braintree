package org.petemacko.capacitorbraintree;

import com.braintreepayments.api.models.CardNonce;
import com.braintreepayments.api.models.PayPalAccountNonce;
import com.braintreepayments.api.models.PaymentMethodNonce;
import com.braintreepayments.api.models.ThreeDSecureInfo;
import com.braintreepayments.api.models.VenmoAccountNonce;
import com.getcapacitor.JSObject;

public class PaymentUiResponse {
    public class Card {
        public String lastTwo;
        public String network;
        public String networkName;
    }

    public class PayPalAccount {
        public String email;
        public String firstName;
        public String lastName;
        public String phone;
        public String clientMetadataId;
        public String payerId;
    }

    public class ThreeDSecureCard {
        public boolean liabilityShifted = false;
        public boolean liabilityShiftPossible = false;
    }

    public class VenmoAccount {
        public String username;
    }

    public boolean userCancelled = false;
    public String nonce;
    public String type;
    public String localizedDescription = "";
    public Card card;
    public PayPalAccount payPalAccount;
    public ThreeDSecureCard threeDSecureCard;
    public VenmoAccount venmoAccount;

    public PaymentUiResponse(){ }

    public PaymentUiResponse(PaymentMethodNonce paymentNonce){
        if(paymentNonce == null) {
            userCancelled = true;
            return;
        }

        nonce = paymentNonce.getNonce();
        if(paymentNonce instanceof CardNonce) {
            Card zz = new Card();
            zz.lastTwo = ((CardNonce) paymentNonce).getLastTwo();
            zz.network = ((CardNonce) paymentNonce).getTypeLabel();
            zz.networkName = ((CardNonce) paymentNonce).getTypeLabel();

            ThreeDSecureInfo threeDSecureInfo = ((CardNonce) paymentNonce).getThreeDSecureInfo();
            if(threeDSecureInfo != null) {
                ThreeDSecureCard zzz = new ThreeDSecureCard();
                zzz.liabilityShifted = threeDSecureInfo.isLiabilityShifted();
                zzz.liabilityShiftPossible = threeDSecureInfo.isLiabilityShiftPossible();
                threeDSecureCard = zzz;
            }
            card = zz;
        }

        if(paymentNonce instanceof PayPalAccountNonce) {
            PayPalAccount zz = new PayPalAccount();
            zz.email = ((PayPalAccountNonce) paymentNonce).getEmail();
            zz.firstName = ((PayPalAccountNonce) paymentNonce).getFirstName();
            zz.lastName = ((PayPalAccountNonce) paymentNonce).getLastName();
            zz.phone = ((PayPalAccountNonce) paymentNonce).getPhone();
            zz.clientMetadataId = ((PayPalAccountNonce) paymentNonce).getClientMetadataId();
            zz.payerId = ((PayPalAccountNonce) paymentNonce).getPayerId();
            payPalAccount = zz;
        }

        if(paymentNonce instanceof VenmoAccountNonce) {
            VenmoAccount zz = new VenmoAccount();
            zz.username = ((VenmoAccountNonce) paymentNonce).getUsername();
            venmoAccount = zz;
        }
    }

    public JSObject buildCapacitorPluginResponse(){
        JSObject rv = new JSObject();

        rv.put("userCancelled", userCancelled);
        rv.put("nonce", nonce);
        rv.put("type", type);
        rv.put("localizedDescription", localizedDescription);

        if(card != null) {
            JSObject o = new JSObject();
            o.put("lastTwo", card.lastTwo);
            o.put("network", card.network);
            o.put("networkName", card.networkName);
            rv.put("card", o);
        }

        if(threeDSecureCard != null) {
            JSObject o = new JSObject();
            o.put("liabilityShifted", threeDSecureCard.liabilityShifted);
            o.put("liabilityShiftPossible", threeDSecureCard.liabilityShiftPossible);
            rv.put("threeDSecureCard", o);
        }

        if(payPalAccount != null) {
            JSObject o = new JSObject();
            o.put("email", payPalAccount.email);
            o.put("firstName", payPalAccount.firstName);
            o.put("lastName", payPalAccount.lastName);
            o.put("phone", payPalAccount.phone);
            o.put("clientMetadataId", payPalAccount.clientMetadataId);
            o.put("payerId", payPalAccount.payerId);
            rv.put("payPalAccount", o);
        }

        if(venmoAccount != null) {
            JSObject o = new JSObject();
            o.put("username", venmoAccount.username);
            rv.put("venmoAccount", o);
        }

        return rv;
    }
}
