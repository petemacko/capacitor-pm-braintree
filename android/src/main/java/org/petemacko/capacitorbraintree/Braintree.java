package org.petemacko.capacitorbraintree;

import android.app.Activity;
import android.content.Intent;
import android.util.Log;

import com.braintreepayments.api.dropin.DropInActivity;
import com.braintreepayments.api.dropin.DropInResult;
import com.braintreepayments.api.models.PaymentMethodNonce;
import com.getcapacitor.JSObject;
import com.getcapacitor.NativePlugin;
import com.getcapacitor.Plugin;
import com.getcapacitor.PluginCall;
import com.getcapacitor.PluginMethod;

import com.braintreepayments.api.dropin.DropInRequest;

@NativePlugin(name = "BrainTree", requestCodes = {Braintree.SHOW_DROPIN})
public class Braintree extends Plugin {

    private static final String TAG = "BraintreePlugin";

    public static final int SHOW_DROPIN = 100;

    private boolean useVaultManager = true;
    private boolean disablePayPal = true;
    private boolean disableVenmo = true;
    private boolean useThreeDSecureVerification = false;
    private boolean disableAndroidPay = false;
    private boolean disableGooglePayment = false;
    private String braintreeToken = null;

    @PluginMethod()
    public void initialize(PluginCall call) {
        String tokenValue = call.getString("token");
        if (tokenValue == null || tokenValue.length() == 0) {
            call.error("Bad input - 'token' is required");
            return;
        }

        braintreeToken = tokenValue;
        call.success();
    }

    @PluginMethod()
    public void setUseVaultManager(PluginCall call) {
        Boolean value = call.getBoolean("value");
        if (value == null) {
            call.error("Bad input - 'value' is required");
            return;
        }

        useVaultManager = value;
        call.success();
    }

    @PluginMethod()
    public void setDisablePayPal(PluginCall call) {
        Boolean value = call.getBoolean("value");
        if (value == null) {
            call.error("Bad input - 'value' is required");
            return;
        }

        disablePayPal = value;
        call.success();
    }

    @PluginMethod()
    public void setDisableVenmo(PluginCall call) {
        Boolean value = call.getBoolean("value");
        if (value == null) {
            call.error("Bad input - 'value' is required");
            return;
        }

        disableVenmo = value;
        call.success();
    }

    @PluginMethod()
    public void setUseThreeDSecureVerification(PluginCall call) {
        Boolean value = call.getBoolean("value");
        if (value == null) {
            call.error("Bad input - 'value' is required");
            return;
        }

        useThreeDSecureVerification = value;
        call.success();
    }

    @PluginMethod()
    public void setDisableAndroidPay(PluginCall call) {
        Boolean value = call.getBoolean("value");
        if (value == null) {
            call.error("Bad input - 'value' is required");
            return;
        }

        disableAndroidPay = value;
        call.success();
    }

    @PluginMethod()
    public void setDisableGooglePayment(PluginCall call) {
        Boolean value = call.getBoolean("value");
        if (value == null) {
            call.error("Bad input - 'value' is required");
            return;
        }

        disableGooglePayment = value;
        call.success();
    }

    @PluginMethod()
    public void presentModalPaymentUi(PluginCall call) {
        String tokenValue = this.braintreeToken;
        if (tokenValue == null || tokenValue.length() == 0) {
            call.error("Braintree client was not initialized");
            return;
        }

//         String amount = call.getString("amount");
//         if (amount == null || amount.length() == 0) {
//             call.error("Bad input - 'amount' is required");
//             return;
//         }

        DropInRequest paymentRequest = new DropInRequest().clientToken(tokenValue);
        //paymentRequest.amount(amount);
        paymentRequest.vaultManager(useVaultManager);
        if (disablePayPal) paymentRequest.disablePayPal();
        if (disableVenmo) paymentRequest.disableVenmo();
        if (disableAndroidPay) paymentRequest.disableAndroidPay();
        if (disableGooglePayment) paymentRequest.disableGooglePayment();
        paymentRequest.requestThreeDSecureVerification(useThreeDSecureVerification);

        try {
            Intent intent = paymentRequest.getIntent(this.getActivity());
            if (intent == null) {
                String msg = "presentModalPaymentUi failed, unable to create BrainTree DropInRequest";
                Log.e(TAG, msg);
                call.error(msg);
                return;
            }
            startActivityForResult(call, intent, SHOW_DROPIN);
        } catch (Exception e) {
            String msg = "presentModalPaymentUi failed: " + e.getMessage();
            Log.e(TAG, msg);
            call.error(msg);
        }
    }

    @Override
    protected void handleOnActivityResult(int requestCode, int resultCode, Intent data) {
        super.handleOnActivityResult(requestCode, resultCode, data);

        PluginCall savedCall = getSavedCall();

        if (savedCall == null) {
            Log.e(TAG, "no saved call in handleOnActivityResult... exiting");
            return;
        }

        try {
            if (requestCode != SHOW_DROPIN) {
                String msg = "Braintree module returned a request for an activity that is currently not handled.";
                Log.e(TAG, msg);
                savedCall.error(msg);
                return;
            }

            if (data != null
                    && data.getSerializableExtra(DropInActivity.EXTRA_ERROR) != null) {
                Exception error = (Exception) data.getSerializableExtra(DropInActivity.EXTRA_ERROR);
                String msg = "handleOnActivityResult got exception: " + error.getLocalizedMessage();
                Log.e(TAG, msg);
                Log.e(TAG, error.getStackTrace().toString());
                savedCall.error(msg);
                return;
            }

            PaymentMethodNonce nonce = null;
            if (resultCode == Activity.RESULT_OK) {
                DropInResult result = data.getParcelableExtra(DropInResult.EXTRA_DROP_IN_RESULT);
                nonce = result.getPaymentMethodNonce();
            }

            JSObject response = processBraintreeUiResult(resultCode, nonce);
            savedCall.resolve(response);
        } finally {
            freeSavedCall();
        }
    }

    private JSObject processBraintreeUiResult(int resultCode, PaymentMethodNonce nonce) {
        if (resultCode == Activity.RESULT_CANCELED || nonce == null) {
            return new PaymentUiResponse(null).buildCapacitorPluginResponse();
        }

        return new PaymentUiResponse(nonce).buildCapacitorPluginResponse();
    }
}
