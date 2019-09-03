#import <Foundation/Foundation.h>
#import <Capacitor/Capacitor.h>

// Define the plugin using the CAP_PLUGIN Macro, and
// each method the plugin supports using the CAP_PLUGIN_METHOD macro.
CAP_PLUGIN(BraintreePlugin, "BrainTree",
           CAP_PLUGIN_METHOD(initialize, CAPPluginReturnPromise);
           CAP_PLUGIN_METHOD(setUseVaultManager, CAPPluginReturnPromise);
           CAP_PLUGIN_METHOD(setDisablePayPal, CAPPluginReturnPromise);
           CAP_PLUGIN_METHOD(setDisableVenmo, CAPPluginReturnPromise);
           CAP_PLUGIN_METHOD(setUseThreeDSecureVerification, CAPPluginReturnPromise);
           CAP_PLUGIN_METHOD(setDisableAndroidPay, CAPPluginReturnPromise);
           CAP_PLUGIN_METHOD(setDisableGooglePayment, CAPPluginReturnPromise);
           CAP_PLUGIN_METHOD(presentModalPaymentUi, CAPPluginReturnPromise);
)

