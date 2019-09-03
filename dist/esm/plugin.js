import { Plugins } from '@capacitor/core';
const { BrainTree } = Plugins;
export class BraintreePayments {
    initialize(options) {
        return BrainTree.initialize(options);
    }
    setUseVaultManager(options) {
        return BrainTree.setUseVaultManager(options);
    }
    setDisablePayPal(options) {
        return BrainTree.setDisablePayPal(options);
    }
    setDisableVenmo(options) {
        return BrainTree.setDisableVenmo(options);
    }
    setUseThreeDSecureVerification(options) {
        return BrainTree.setUseThreeDSecureVerification(options);
    }
    setDisableAndroidPay(options) {
        return BrainTree.setDisableAndroidPay(options);
    }
    setDisableGooglePayment(options) {
        return BrainTree.setDisableGooglePayment(options);
    }
    presentModalPaymentUi(options) {
        return BrainTree.presentModalPaymentUi(options);
    }
}
//# sourceMappingURL=plugin.js.map