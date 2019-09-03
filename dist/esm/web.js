import { WebPlugin } from '@capacitor/core';
export class BraintreeWeb extends WebPlugin {
    constructor() {
        super({
            name: 'BrainTree',
            platforms: ['web']
        });
    }
    // @ts-ignore
    initialize(options) {
        return this.createBuggerOffPromise();
    }
    // @ts-ignore
    setUseVaultManager(options) {
        return this.createBuggerOffPromise();
    }
    // @ts-ignore
    setDisablePayPal(options) {
        return this.createBuggerOffPromise();
    }
    // @ts-ignore
    setDisableVenmo(options) {
        return this.createBuggerOffPromise();
    }
    // @ts-ignore
    setUseThreeDSecureVerification(options) {
        return this.createBuggerOffPromise();
    }
    // @ts-ignore
    setDisableAndroidPay(options) {
        return this.createBuggerOffPromise();
    }
    // @ts-ignore
    setDisableGooglePayment(options) {
        return this.createBuggerOffPromise();
    }
    // @ts-ignore
    presentModalPaymentUi(options) {
        return new Promise((_resolve, reject) => {
            const msg = "The BrainTree plugin doesn't plug in to the web. It only works on iOS/Android native.";
            console.log(msg);
            reject(msg);
        });
    }
    createBuggerOffPromise() {
        return new Promise((_resolve, reject) => {
            const msg = "The BrainTree plugin doesn't plug in to the web. It only works on iOS/Android native.";
            console.log(msg);
            reject(msg);
        });
    }
}
const Braintree = new BraintreeWeb();
export { Braintree };
import { registerWebPlugin } from '@capacitor/core';
registerWebPlugin(Braintree);
//# sourceMappingURL=web.js.map